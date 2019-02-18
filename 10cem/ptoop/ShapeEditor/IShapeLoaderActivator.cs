using System.Reflection;

namespace ShapeEditor
{
    public interface IShapeLoaderActivator
    {
        void Load(Assembly assembly);
    }
}
