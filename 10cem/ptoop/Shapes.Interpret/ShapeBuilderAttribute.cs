using System;

namespace Shapes.Interpretation
{
    /// <summary>
    /// A marker indicating the IShapeBuilder instance can be dynamically loaded.
    /// </summary>
    [AttributeUsage(AttributeTargets.Class)]
    public class ShapeBuilderAttribute : Attribute
    {
        /// <param name="key">A key that will be used to run the builder.</param>
        public ShapeBuilderAttribute(string key)
        {
            Key = key;
        }

        public string Key { get; }
    }
}