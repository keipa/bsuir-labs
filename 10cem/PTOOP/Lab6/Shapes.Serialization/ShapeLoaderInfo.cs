namespace Shapes.Serialization
{
    public class ShapeLoaderInfo
    {
        public ShapeLoaderInfo(string key, string title, IShapeLoaderPacker packer)
        {
            Key = key;
            Title = title;
            Packer = packer;
        }

        public string Key { get; }

        public string Title { get; }

        public IShapeLoaderPacker Packer { get; }
    }
}
