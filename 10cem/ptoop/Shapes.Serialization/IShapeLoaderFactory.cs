using System.Collections.Generic;

namespace Shapes.Serialization
{
    public interface IShapeLoaderFactory
    {
        IEnumerable<string> Keys { get; }

        IShapeLoader Create();

        bool Register(ShapeLoaderInfo info);

        IList<ShapeLoaderInfo> SetActiveKeys(IList<string> keys);
    }
}
