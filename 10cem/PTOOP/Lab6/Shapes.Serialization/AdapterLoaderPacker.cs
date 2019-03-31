namespace Shapes.Serialization
{
    public class AdapterLoaderPacker : IShapeLoaderPacker
    {
        private readonly IStreamWrapper wrapper_;

        public AdapterLoaderPacker(IStreamWrapper wrapper)
        {
            wrapper_ = wrapper;
        }

        public IShapeLoader Wrap(IShapeLoader shapeLoader)
        {
            return new ShapeLoaderAdapter(shapeLoader, wrapper_);
        }
    }
}
