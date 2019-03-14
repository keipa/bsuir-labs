using System;
using System.Collections.Generic;
using System.Linq;

namespace Shapes.Interpretation
{
    public class ShapeFactory : IShapeFactory
    {
        private readonly Dictionary<string, IShapeBuilder> builders_ = new Dictionary<string, IShapeBuilder>();

        public IEnumerable<string> KnownNames => builders_.Keys;

        public IShape Create(string name, IEnumerable<string> parameters, DrawingContext context)
        {
            return builders_.TryGetValue(name.ToLowerInvariant(), out var builder)
                ? builder.Build(parameters.ToList(), context)
                : throw new ArgumentException($"Shape name '{name}' is not registered.");
        }

        public bool Register(string name, IShapeBuilder shapeBuilder)
        {
            var key = name.ToLowerInvariant();
            if (builders_.ContainsKey(key))
            {
                return false;
            }
            builders_[name.ToLowerInvariant()] = shapeBuilder;
            return true;
        }
    }
}
