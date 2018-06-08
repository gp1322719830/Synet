/*
* Synet Framework (http://github.com/ermig1979/Synet).
*
* Copyright (c) 2018-2018 Yermalayeu Ihar.
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
#include "Synet/Layer.h"

namespace Synet
{
    namespace Detail
    {
        template <class T> void CpuAbs(const T * src, size_t size, T * dst)
        {
            for (size_t i = 0; i < size; ++i)
                dst[i] = ::abs(src[i]);
        }

        template<class T> void CpuRsqrt(const T * src, size_t size, T * dst)
        {
            for (size_t i = 0; i < size; ++i)
                dst[i] = 1.0f / sqrt(src[i]);
        }

        template<class T> void CpuSqrt(const T * src, size_t size, T * dst)
        {
            for (size_t i = 0; i < size; ++i)
                dst[i] = sqrt(src[i]);
        }
    }

    template <class T> class UnaryOperationLayer : public Synet::Layer<T>
    {
    public:
        typedef T Type;
        typedef Layer<T> Base;
        typedef typename Base::TensorPtrs TensorPtrs;

        UnaryOperationLayer(const LayerParam & param)
            : Base(param)
        {
        }

        virtual void Setup(const TensorPtrs & src, const TensorPtrs & buf, const TensorPtrs & dst)
        {
            _type = this->Param().unaryOperation().type();
            switch (_type)
            {
            case UnaryOperationTypeAbs:
                _func = Detail::CpuAbs;
                break;
            case UnaryOperationTypeRsqrt:
                _func = Detail::CpuRsqrt;
                break;
            case UnaryOperationTypeSqrt:
                _func = Detail::CpuSqrt;
                break;
            default:
                assert(0);
            }
        }

        virtual void Reshape(const TensorPtrs & src, const TensorPtrs & buf, const TensorPtrs & dst)
        {
            dst[0]->Reshape(src[0]->Shape());
        }

    protected:
        virtual void ForwardCpu(const TensorPtrs & src, const TensorPtrs & buf, const TensorPtrs & dst)
        {
            SYNET_PERF_FUNC();
            _func(src[0]->CpuData(), src[0]->Size(), dst[0]->CpuData());
        }

    private:
        typedef void (*FuncPtr)(const Type * src, size_t size, Type * dst);

        UnaryOperationType _type;
        FuncPtr _func;
    };
}