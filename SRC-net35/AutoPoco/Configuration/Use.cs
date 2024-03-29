﻿using System;
using AutoPoco.Engine;

namespace AutoPoco.Configuration
{
    public static class Use
    {
        public static TParamType Source<TParamType, TSource>() where TSource : IDatasource<TParamType>
        {
            return default(TParamType);
        }

        public static TParamType Source<TParamType, TSource>(params Object[] args)
            where TSource : IDatasource<TParamType>
        {
            return default(TParamType);
        }
    }
}