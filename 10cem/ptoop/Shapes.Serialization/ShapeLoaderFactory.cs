using System.Collections.Generic;
using System.Linq;

namespace Shapes.Serialization
{
    public class ShapeLoaderFactory : IShapeLoaderFactory
    {
        private readonly IShapeLoader coreLoader_;
        private readonly Dictionary<string, ShapeLoaderInfo> shapeLoaders_ = new Dictionary<string, ShapeLoaderInfo>();
        private readonly List<ShapeLoaderInfo> activeLoaders_ = new List<ShapeLoaderInfo>();

        public ShapeLoaderFactory(IShapeLoader coreLoader)
        {
            coreLoader_ = coreLoader;
        }

        public IEnumerable<string> Keys => shapeLoaders_.Keys;

        // TODO?: pass active keys as parameters
        public IShapeLoader Create()
        {
            var loader = coreLoader_;
            foreach (ShapeLoaderInfo info in activeLoaders_)
            {
                loader = info.Packer.Wrap(loader);
            }
            return loader;
        }

        public bool Register(ShapeLoaderInfo info)
        {
            if (!shapeLoaders_.ContainsKey(info.Key))
            {
                shapeLoaders_[info.Key] = info;
                activeLoaders_.Add(info);
                return true;
            }
            return false;
        }

        public IList<ShapeLoaderInfo> SetActiveKeys(IList<string> keys)
        {
            var loaders = keys.Select(key =>
            {
                shapeLoaders_.TryGetValue(key, out var info);
                return info;
            }).Where(info => info != null);
            activeLoaders_.Clear();
            activeLoaders_.AddRange(loaders);
            return activeLoaders_;
        }

        public bool TryGetLoaderInfo(string key, out ShapeLoaderInfo info)
        {
            return shapeLoaders_.TryGetValue(key, out info);
        }
    }
}
