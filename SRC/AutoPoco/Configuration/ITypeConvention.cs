﻿namespace AutoPoco.Configuration
{
    public interface ITypeConvention : IConvention
    {
        /// <summary>
        /// Apply the convention to the registered type
        /// </summary>
        void Apply(ITypeConventionContext context);
    }
}