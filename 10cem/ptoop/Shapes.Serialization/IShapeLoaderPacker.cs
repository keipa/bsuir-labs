namespace Shapes.Serialization
{
    public interface IShapeLoaderPacker
    {
        IShapeLoader Wrap(IShapeLoader shapeLoader);
    }
}
