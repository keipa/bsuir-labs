using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Runtime.Serialization;

namespace Shapes
{
    /// <summary>
    /// A shape combining other shapes.
    /// </summary>
    [DataContract]
    public class AggregateShape : IShape
    {
        [DataMember]
        private readonly IShape[] shapes_;

        public AggregateShape(IEnumerable<IShape> shapes)
        {
            shapes_ = shapes.ToArray();
        }

        public IEnumerable<IShape> Shapes => shapes_;

        public void Draw(Graphics graphics)
        {
            foreach (IShape shape in shapes_)
            {
                shape.Draw(graphics);
            }
        }
    }
}
