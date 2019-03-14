using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Runtime.Serialization;

namespace Shapes
{
    [DataContract]
    public class AggregateShape : IShape
    {
        [DataMember]
        private readonly IShape[] _shapes;

        public AggregateShape(IEnumerable<IShape> shapes)
        {
            _shapes = shapes.ToArray();
        }

        public void Draw(Graphics graphics)
        {
            foreach (var shape in _shapes)
            {
                shape.Draw(graphics);
            }
        }
    }
}
