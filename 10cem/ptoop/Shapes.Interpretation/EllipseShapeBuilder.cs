using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;

namespace Shapes.Interpretation
{
    public class EllipseShapeBuilder : IShapeBuilder
    {
        private const int ParamCount = 4;

        public IShape Build(IList<string> parameters, DrawingContext context)
        {
            if (parameters.Count != ParamCount)
            {
                throw new ArgumentException($"Invalid number of arguments: {parameters.Count}. Expected {ParamCount}.");
            }
            var intParameters = parameters.Select(int.Parse).ToList();
            var start = new Point(intParameters[0], intParameters[1]);
            var end = new Point(intParameters[2], intParameters[3]);
            return new EllipseShape(start, end, context.CreatePenBillet());
        }
    }
}