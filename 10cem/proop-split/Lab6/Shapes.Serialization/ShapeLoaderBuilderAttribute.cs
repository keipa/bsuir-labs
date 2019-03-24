using System;

namespace Shapes.Serialization
{
    [AttributeUsage(AttributeTargets.Class)]
    public class ShapeLoaderBuilderAttribute : Attribute
    {
        public ShapeLoaderBuilderAttribute(string title)
        {
            Title = title;
        }

        public string Title { get; }
    }
}
