namespace Shapes.Serialization.ThirdParty
{
    [ShapeLoaderBuilder("Archive")]
    public class ZipShapeLoaderPacker : IShapeLoaderPacker
    {
        public IShapeLoader Wrap(IShapeLoader shapeLoader)
        {
            return new ZipShapeLoaderDecorator(shapeLoader);
        }
    }
}
