using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;

namespace Shapes
{
    public class Aggregation : IShape
    {
        private readonly IShape[] _shapes;

        public Aggregation(IEnumerable<IShape> shapes)
        {
            _shapes = shapes.ToArray();
        }

        public void Draw(Graphics graphics)
        {
            foreach (var shape in _shapes) shape.Draw(graphics);
        }
    }
}