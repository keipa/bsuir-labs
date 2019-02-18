using System;
using System.Collections.Generic;
using System.Linq;

namespace Shapes.Interpretation
{
    /// <summary>
    /// A factory creating shapes by class and parameters.
    /// </summary>
    public class ShapeFactory : IShapeFactory
    {
        private readonly Dictionary<string, IShapeBuilder> builders_ = new Dictionary<string, IShapeBuilder>();

        public IEnumerable<string> KnownNames => builders_.Keys;

        /// <summary>
        /// Creates a shape.
        /// </summary>
        /// <param name="name"></param>
        /// <param name="parameters"></param>
        /// <param name="context"></param>
        /// <returns></returns>
        public IShape Create(string name, IEnumerable<string> parameters, DrawingContext context)
        {
            return builders_.TryGetValue(name.ToLowerInvariant(), out var builder)
                ? builder.Build(parameters.ToList(), context)
                : throw new ArgumentException($"Shape name '{name}' is not registered.");
        }

        /// <summary>
        /// Registers a new shape builder that will be used for the given shape name.
        /// </summary>
        /// <param name="name"></param>
        /// <param name="shapeBuilder"></param>
        /// <returns>Whether the builder has been successfully registered.</returns>
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
