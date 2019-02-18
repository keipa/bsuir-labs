using System.Reflection;

namespace ShapeEditor
{
    public interface IPluginLoader
    {
        void Load(Assembly assembly);
    }
}
