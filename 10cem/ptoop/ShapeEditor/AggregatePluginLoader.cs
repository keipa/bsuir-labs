using System.Collections.Generic;
using System.Linq;
using System.Reflection;

namespace ShapeEditor
{
    public class AggregatePluginLoader : IPluginLoader
    {
        private readonly IPluginLoader[] pluginLoaders_;

        public AggregatePluginLoader(IEnumerable<IPluginLoader> pluginLoaders)
        {
            pluginLoaders_ = pluginLoaders.ToArray();
        }

        public void Load(Assembly assembly)
        {
            foreach (IPluginLoader pluginLoader in pluginLoaders_)
            {
                pluginLoader.Load(assembly);
            }
        }
    }
}
