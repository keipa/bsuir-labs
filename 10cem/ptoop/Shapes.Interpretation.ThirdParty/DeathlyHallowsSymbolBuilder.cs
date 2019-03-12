using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;

namespace Shapes.Interpretation.ThirdParty
{
    [ShapeBuilder("hallows")]
    public class DeathlyHallowsSymbolBuilder : IShapeBuilder
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
            var middleX = (start.X + end.X) / 2;

            var lineShape1 = new LineShape(new Point(start.X, end.Y), new Point(middleX, start.Y), context.CreatePenBillet());
            var lineShape2 = new LineShape(new Point(middleX, start.Y), new Point(end.X, end.Y), context.CreatePenBillet());
            var lineShape3 = new LineShape(new Point(start.X, end.Y), new Point(end.X, end.Y), context.CreatePenBillet());
            var lineShape4 = new LineShape(new Point(middleX, start.Y), new Point(middleX, end.Y), context.CreatePenBillet());

            var ellipseShape = CreateEllipseShape(start, end, context);

            return new AggregateShape(new IShape[]
            {
                lineShape1, lineShape2, lineShape3, lineShape4, ellipseShape
            });
        }

        private EllipseShape CreateEllipseShape(Point upperLeftCorner, Point lowerRightCorner, DrawingContext context)
        {
            var middleX = (upperLeftCorner.X + lowerRightCorner.X) / 2;
            var height = lowerRightCorner.Y - upperLeftCorner.Y;
            var width = lowerRightCorner.X - upperLeftCorner.X;
            var hypotenuse = Math.Sqrt(height * height + width * width / 4);
            var radius = (int)(height * width / (2 * hypotenuse + width));
            return new EllipseShape(
                new Point(middleX - radius, lowerRightCorner.Y - 2 * radius),
                new Point(middleX + radius, lowerRightCorner.Y),
                context.CreatePenBillet()
            );
        }
    }
}
