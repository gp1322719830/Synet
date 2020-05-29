/*
* Synet Framework (http://github.com/ermig1979/Synet).
*
* Copyright (c) 2018-2019 Yermalayeu Ihar.
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

#include "Synet/Tensor.h"

namespace Synet
{
    namespace Detail
    {
        template <typename T> void UpdateChannelsMinMax(const T* src, size_t batch, size_t channels, size_t height, size_t width, TensorFormat format, T* min, T* max)
        {
            for (size_t b = 0; b < batch; ++b)
            {
                if (format == TensorFormatNhwc)
                {
                    for (size_t h = 0; h < height; ++h)
                    {
                        for (size_t w = 0; w < width; ++w)
                        {
                            for (size_t c = 0; c < channels; ++c)
                            {
                                float value = src[c];
                                min[c] = std::min(min[c], value);
                                max[c] = std::max(max[c], value);
                            }
                            src += channels;
                        }
                    }
                }
                else
                    assert(0);
            }
        }

        template <typename T> void UpdateChannelsHistogram(const T* src, size_t batch, size_t channels, size_t height, size_t width, TensorFormat format, const T* min, const T* max, uint32_t* histogram, size_t size)
        {
            for (size_t b = 0; b < batch; ++b)
            {
                if (format == TensorFormatNhwc)
                {
                    for (size_t h = 0; h < height; ++h)
                    {
                        for (size_t w = 0; w < width; ++w)
                        {
                            for (size_t c = 0; c < channels; ++c)
                            {
                                T value = (src[c] - min[c]) / (max[c] - min[c]);
                                uint32_t index = Round(value * (size - 1));
                                histogram[c * size + index]++;
                            }
                            src += channels;
                        }
                    }
                }
                else
                    assert(0);
            }
        }

        template <typename T> void ValidateMinMax(const T * min, T * max, size_t channels, T epsilon)
        {
            for (size_t c = 0; c < channels; ++c)
                max[c] = min[c] + std::max(max[c] - min[c], epsilon);
        }

        template <typename T> void UpdateMinMax(const T* srcMin, T* srcMax, size_t channels, T * dstMin, T * dstMax)
        {
            for (size_t c = 0; c < channels; ++c)
            {
                dstMin[c] = std::min(dstMin[c], srcMin[c]);
                dstMax[c] = std::max(dstMax[c], srcMax[c]);
            }
        }

        template <typename T> void UpdateMinMax(const T* srcMin, T* srcMax, size_t channels, uint32_t * histogram, size_t size, size_t threshold, T* dstMin, T* dstMax)
        {
            for (size_t c = 0; c < channels; ++c)
            {
                size_t lo = 0, hi = size;
                for (size_t sum = 0, i = 0; sum <= threshold; i += 1, sum += histogram[i])
                    lo = i;
                for (size_t sum = 0, i = size - 1; sum <= threshold; i -= 1, sum += histogram[i])
                    hi = i + 1;
                T min = srcMin[c] + (srcMax[c] - srcMin[c]) * lo / size;
                T max = srcMin[c] + (srcMax[c] - srcMin[c]) * hi / size;
                dstMin[c] = std::min(dstMin[c], min);
                dstMax[c] = std::max(dstMax[c], max);
                histogram += size;
            }
        }
    }

    template <typename T> void UpdateChannelsMinMax(const Tensor<T> & tensor, T* min, T* max)
    {
        assert(tensor.Count() == 4);
        if (tensor.Format() == TensorFormatNhwc)
            Detail::UpdateChannelsMinMax(tensor.CpuData(), tensor.Axis(0), tensor.Axis(3), tensor.Axis(1), tensor.Axis(2), tensor.Format(), min, max);
        else
            assert(0);
    }

    template <typename T> void UpdateChannelsHistogram(const Tensor<T>& tensor, const T* min, const T* max, uint32_t* histogram, size_t size)
    {
        assert(tensor.Count() == 4);
        if (tensor.Format() == TensorFormatNhwc)
            Detail::UpdateChannelsHistogram(tensor.CpuData(), tensor.Axis(0), tensor.Axis(3), tensor.Axis(1), tensor.Axis(2), tensor.Format(), min, max, histogram, size);
        else
            assert(0);
    }

    template <typename T> void UpdateChannelsQuantile(const Tensor<T>& tensor, T quntile, T epsilon, T * lower, T * upper)
    {
        assert(tensor.Count() == 4 && tensor.Format() == TensorFormatNhwc);
        size_t channels = tensor.Axis(3);
        size_t count = tensor.Size() / channels;
        size_t threshold = Round(quntile * count);
        if (threshold == 0)
        {
            UpdateChannelsMinMax(tensor, lower, upper);
            return;
        }
        std::vector<T> min(channels, std::numeric_limits<T>::max());
        std::vector<T> max(channels, std::numeric_limits<T>::lowest());
        UpdateChannelsMinMax(tensor, min.data(), max.data());
        Detail::ValidateMinMax(min.data(), max.data(), channels, epsilon);
        const size_t SIZE = 256;
        std::vector<uint32_t> histogram(channels * SIZE, 0);
        UpdateChannelsHistogram(tensor, min.data(), max.data(), histogram.data(), SIZE);
        Detail::UpdateMinMax(min.data(), max.data(), channels, histogram.data(), SIZE, threshold, lower, upper);
    }
}