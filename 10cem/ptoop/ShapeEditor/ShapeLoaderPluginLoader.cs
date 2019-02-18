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
            // TODO: think of a better approach to loader, attribute is too restricting
            var builderPairs =
                from type in assembly.GetExportedTypes()
                where type.GetInterfaces().Contains(typeof(IShapeLoaderPacker))
                let attr = type.GetCustomAttribute<ShapeLoaderBuilderAttribute>()
                where attr != null
                select new { type, attr };
            foreach (var builderPair in builderPairs)
            {
                try
                {
                    var loaderBuilder = (IShapeLoaderPacker)Activator.CreateInstance(builderPair.type);
                    var info = new ShapeLoaderInfo(builderPair.type.FullName, builderPair.attr.Title, loaderBuilder);
                    loaderFactory_.Register(info);
                }
                catch
                {
                    // TODO: log. can be instantiation error
                }
            }
        }

        private void LoadAdapters(Assembly assembly)
        {
            var types =
                from type in assembly.GetExportedTypes()
                where type.GetInterfaces().Contains(typeof(IStreamWrapper))
                select type;
            foreach (var type in types)
            {
                try
                {
                    var wrapper = (IStreamWrapper)Activator.CreateInstance(type);
                    var loaderBuilder = new AdapterLoaderPacker(wrapper);
                    var info = new ShapeLoaderInfo(type.FullName, type.Name, loaderBuilder);
                    loaderFactory_.Register(info);
                }
                catch
                {
                    // TODO: log. can be instantiation error
                }
            }
        }
    }
}