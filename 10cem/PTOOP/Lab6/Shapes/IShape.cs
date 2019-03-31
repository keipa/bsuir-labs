using System.Drawing;

namespace Shapes
{
    // TODO: consider separating drawing logic from declarative shape description

    /// <summary>
    /// Desribes an abstract shape capable of drawing itself.
    /// </summary>
    public interface IShape
    {
        /// <summary>
        /// Draws the shape on the provided graphics object.
        /// </summary>
        /// <param name="graphics"></param>
        void Draw(Graphics graphics);
    }
}
