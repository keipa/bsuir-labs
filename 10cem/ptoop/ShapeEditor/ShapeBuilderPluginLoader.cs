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
            // TODO: think of another ways to load plugins. Using attributes means key is fixed at plugin compile time
            // TODO: smth like plugin manager with Inflate(IShapeFactory). less control though
            var builderPairs =
                from type in assembly.GetExportedTypes()
                where type.GetInterfaces().Contains(typeof(IShapeBuilder))
                let attribute = type.GetCustomAttribute<ShapeBuilderAttribute>()
                where attribute != null
                select new {type, attribute};
            foreach (var builderPair in builderPairs)
            {
                try
                {
                    var shapeBuilder = (IShapeBuilder) Activator.CreateInstance(builderPair.type);
                    factory_.Register(builderPair.attribute.Key, shapeBuilder);
                }
                catch
                {
                    // TODO: log. can be instantiation error
                }
            }
        }
    }
}
