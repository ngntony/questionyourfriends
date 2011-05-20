﻿using System;
using System.Collections.Specialized;
using System.Web.DynamicData;
using System.Web.UI;

namespace QuestionYourFriendsBackEnd.DynamicData.FieldTemplates
{
    public partial class Boolean_EditField : FieldTemplateUserControl
    {
        protected override void OnDataBinding(EventArgs e)
        {
            base.OnDataBinding(e);

            object val = FieldValue;
            if (val != null)
                CheckBox1.Checked = (bool)val;
        }

        protected override void ExtractValues(IOrderedDictionary dictionary)
        {
            dictionary[Column.Name] = CheckBox1.Checked;
        }

        public override Control DataControl
        {
            get
            {
                return CheckBox1;
            }
        }

    }
}