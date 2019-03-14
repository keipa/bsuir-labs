using System;

namespace Shapes.Interpretation
{
    [AttributeUsage(AttributeTargets.Class)]
    public class ShapeBuilderAttribute : Attribute
    {
        public ShapeBuilderAttribute(string key)
        {
            Key = key;
        }

        public string Key { get; }
    }
}