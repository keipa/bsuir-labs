namespace Shapes.Serialization.ThirdParty
{
    [ShapeLoaderBuilder("Check integrity")]
    public class ChecksumShapeLoaderPacker : IShapeLoaderPacker
    {
        public IShapeLoader Wrap(IShapeLoader shapeLoader)
        {
            return new ChecksumShapeLoaderDecorator(shapeLoader, new Md5Hash());
        }
    }
}
