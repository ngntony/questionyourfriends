﻿using System;
using System.Collections.Generic;
using System.Linq;
using AutoPoco.Configuration.Providers;
using AutoPoco.Engine;

namespace AutoPoco.Configuration
{
    public class EngineConfigurationTypeMemberBuilder : IEngineConfigurationTypeMemberBuilder,
                                                        IEngineConfigurationTypeMemberProvider
    {
        private readonly List<DatasourceFactory> mDatasources = new List<DatasourceFactory>();
        private readonly EngineTypeMember mMember;
        private readonly EngineConfigurationTypeBuilder mParentConfiguration;

        public EngineConfigurationTypeMemberBuilder(EngineTypeMember member,
                                                    EngineConfigurationTypeBuilder parentConfiguration)
        {
            mMember = member;
            mParentConfiguration = parentConfiguration;
        }

        #region IEngineConfigurationTypeMemberBuilder Members

        public IEngineConfigurationTypeBuilder Use(Type dataSource)
        {
            return Use(dataSource, new Object[] {});
        }

        public IEngineConfigurationTypeBuilder Use(Type dataSource, params object[] args)
        {
            if (dataSource.GetInterface(typeof (IDatasource).FullName) == null)
            {
                throw new ArgumentException("dataSource does not implement IDatasource", "dataSource");
            }
            mDatasources.Clear();

            var newFactory = new DatasourceFactory(dataSource);
            newFactory.SetParams(args);
            mDatasources.Add(newFactory);
            return mParentConfiguration;
        }

        public IEngineConfigurationTypeBuilder Default()
        {
            mDatasources.Clear();
            return mParentConfiguration;
        }

        #endregion

        #region IEngineConfigurationTypeMemberProvider Members

        public EngineTypeMember GetConfigurationMember()
        {
            return mMember;
        }

        public IEnumerable<IEngineConfigurationDatasource> GetDatasources()
        {
            return mDatasources.Cast<IEngineConfigurationDatasource>();
        }

        #endregion

        public void SetDatasources(params DatasourceFactory[] dataSources)
        {
            mDatasources.Clear();
            if (dataSources.Length > 0)
            {
                mDatasources.AddRange(dataSources);
            }
        }
    }
}