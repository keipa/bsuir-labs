using System;
using System.Linq;
using System.Reflection;
using Shapes.Interpretation;

namespace ShapeEditor
{
    public class ShapeBuilderPluginLoader : IPluginLoader
    {
        private readonly IShapeFactory factory_;

        public ShapeBuilderPluginLoader(IShapeFactory factory)
        {
            factory_ = factory;
        }

        public void Load(Assembly assembly)
        {
            var builderPairs =
                from type in assembly.GetExportedTypes()
                where type.GetInterfaces().Contains(typeof(IShapeBuilder))
                let attribute = type.GetCustomAttribute<ShapeBuilderAttribute>()
                where attribute != null
                select new {type, attribute};
            foreach (var builderPair in builderPairs)
            {
                var shapeBuilder = (IShapeBuilder) Activator.CreateInstance(builderPair.type);
                factory_.Register(builderPair.attribute.Key, shapeBuilder);
            }
        }
    }
}
