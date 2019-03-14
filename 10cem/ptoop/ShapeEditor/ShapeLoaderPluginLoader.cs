using System;
using System.Linq;
using System.Reflection;
using Shapes.Serialization;

namespace ShapeEditor
{
    public class ShapeLoaderPluginLoader : IPluginLoader
    {
        private readonly IShapeLoaderFactory loaderFactory_;

        public ShapeLoaderPluginLoader(IShapeLoaderFactory loaderFactory)
        {
            loaderFactory_ = loaderFactory;
        }

        public void Load(Assembly assembly)
        {
            var builderPairs =
                from type in assembly.GetExportedTypes()
                where type.GetInterfaces().Contains(typeof(IShapeLoaderPacker))
                let attr = type.GetCustomAttribute<ShapeLoaderBuilderAttribute>()
                where attr != null
                select new { type, attr };
            foreach (var builderPair in builderPairs)
            {
                var loaderBuilder = (IShapeLoaderPacker)Activator.CreateInstance(builderPair.type);
                var info = new ShapeLoaderInfo(builderPair.type.FullName, builderPair.attr.Title, loaderBuilder);
                loaderFactory_.Register(info);          
            }
        }
    }
}