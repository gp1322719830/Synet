/*
* Synet Framework (http://github.com/ermig1979/Synet).
*
* Copyright (c) 2018-2020 Yermalayeu Ihar.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

#pragma once

#include "Synet/Common.h"
#include "Synet/Params.h"
#include "Synet/Utils/FileUtils.h"

namespace Synet
{
	class Deoptimizer
	{
	public:
		bool Run(Synet::NetworkParam& network)
		{
			if (!DeoptimizeLayers(network, 0))
				return false;
			if (!DeoptimizeLayers(network, 1))
				return false;
			if (!DeoptimizeLayers(network, 2))
				return false;
			return true;
		}

	private:
		struct Change
		{
			size_t start;
			String prev, curr;
			Change(size_t s, const String & p, const String & c)
				: start(s), prev(p), curr(c) {}
		};
		typedef std::vector<Change> Changes;
		typedef std::vector<Synet::LayerParam> LayerParams;

        bool DeoptimizeLayers(Synet::NetworkParam & network, int stage)
        {
            Changes changes;
            LayerParams deoptimized;
            for (size_t i = 0; i < network.layers().size(); ++i)
            {
				const LayerParam& layer = network.layers()[i];
                switch (stage)
                {
                case 0:
                {
                    if (SeparateMergedConvolution(layer, deoptimized, changes))
                        continue;
                    break;
                }
                case 1:
                {
                    if (SeparateConvolutionOrDeconvolution(layer, deoptimized, changes))
                        continue;
                    break;
                }
				case 2:
				{
					if (RemoveLayerReusage(layer, deoptimized, changes))
						continue;
					break;
				}
                default:
                    assert(0);
                    return false;
                }
				deoptimized.push_back(layer);
            }
			Rename(changes, deoptimized);
            network.layers() = deoptimized;
            return true;
        }

		bool SeparateConvolutionOrDeconvolution(const Synet::LayerParam & layer, LayerParams & deoptimized, Changes & changes)
		{
			if (layer.type() != LayerTypeConvolution && layer.type() != LayerTypeDeconvolution)
				return false;
			if (layer.convolution().activationType() == ActivationFunctionTypeIdentity)
				return false;
			LayerParam convolution = layer;
			LayerParam activation;
			if (layer.convolution().activationType() == ActivationFunctionTypeRelu)
			{
				activation.type() = LayerTypeRelu;
				activation.name() = layer.name() + "_relu";
				activation.relu().negativeSlope() = layer.convolution().activationParam0();
			}
			else if (layer.convolution().activationType() == ActivationFunctionTypePrelu)
			{
				activation.type() = LayerTypePrelu;
				activation.name() = layer.name() + "_prelu";
				activation.weight().push_back(layer.weight().back());
				convolution.weight().pop_back();
			}
			else
				return false;
			convolution.convolution().activationType() = ActivationFunctionTypeIdentity;
			convolution.convolution().activationParam0() = 0.0f;
			convolution.convolution().activationParam1() = 6.0f;
			convolution.dst()[0] = convolution.name();
			activation.src() = convolution.dst();
			activation.dst().push_back(activation.name());
			deoptimized.push_back(convolution);
			deoptimized.push_back(activation);
			changes.push_back(Change(deoptimized.size(), convolution.name(), activation.name()));
			return true;
		}

		size_t WeightCount(const Synet::ConvolutionParam& convolution) const
		{
			return 1 + (convolution.biasTerm() ? 1 : 0) + (convolution.activationType() == ActivationFunctionTypePrelu ? 1 : 0);
		}

		bool SeparateMergedConvolution(const Synet::LayerParam& layer, LayerParams& deoptimized, Changes& changes)
		{
			if (layer.type() != LayerTypeMergedConvolution || layer.mergedConvolution().add())
				return false;

			LayerParam conv[3];
			for (int i = 0, w = 0; i < 3; ++i)
			{
				conv[i].type() = LayerTypeConvolution;
				conv[i].name() = layer.name() + (i == 2 ? String("") : String("_conv") + Synet::ValueToString(i));
				conv[i].src() = i ? conv[i - 1].dst() : layer.src();
				conv[i].dst().push_back(conv[i].name());
				conv[i].convolution() = layer.mergedConvolution().conv()[i];
				for (size_t end = w + WeightCount(conv[i].convolution()); w < end; ++w)
					conv[i].weight().push_back(layer.weight()[w]);
				deoptimized.push_back(conv[i]);
			}

			return true;
		}

		bool RemoveLayerReusage(const Synet::LayerParam& layer, LayerParams& deoptimized, Changes& changes)
		{
			if (layer.src().empty())
				return false;
			if (layer.dst()[0] != layer.src()[0])
				return false;
			LayerParam updated = layer;
			updated.dst()[0] = layer.dst().size() > 1 ? layer.name() + ":0" : layer.name();
			deoptimized.push_back(updated);
			changes.push_back(Change(deoptimized.size(), layer.dst()[0], updated.dst()[0]));
			return true;
		}

		bool Rename(const Change& change, LayerParams& layers)
		{
			for (size_t i = change.start; i < layers.size(); ++i)
			{
				for (size_t j = 0; j < layers[i].src().size(); ++j)
				{
					if (layers[i].src()[j] == change.prev)
						layers[i].src()[j] = change.curr;
				}
			}
			return true;
		}

		bool Update(size_t start, Changes & changes)
		{
			for (size_t i = start + 1; i < changes.size(); ++i)
			{
				if (changes[i].prev == changes[start].prev)
					changes[i].prev = changes[start].curr;
			}
			return true;
		}

		bool Rename(Changes & changes, LayerParams& layers)
		{
			for (size_t k = 0; k < changes.size(); ++k)
			{
				if (!Rename(changes[k], layers))
					return false;
				if (!Update(k, changes))
					return false;
			}
			return true;
		}
	};

	inline bool DeoptimizeSynetModel(const String& srcModel, const String& dstModel)
	{
		NetworkParamHolder network;
		if (!network.Load(srcModel))
		{
			std::cout << "Can't load '" << srcModel << "' model file!" << std::endl;
			return false;
		}
		Deoptimizer deoptimizer;
		if (!deoptimizer.Run(network()))
		{
			std::cout << "Can't deoptimize Synet model!" << std::endl;
			return false;
		}
		if (!network.Save(dstModel, false))
		{
			std::cout << "Can't save '" << dstModel << "' model file!" << std::endl;
			return false;
		}
		return true;
	}
}