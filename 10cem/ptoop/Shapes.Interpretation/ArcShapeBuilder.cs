using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;

namespace Shapes.Interpretation
{
    public class ArcShapeBuilder : IShapeBuilder
    {
        private const int ParamCount = 6;

        public IShape Build(IList<string> parameters, DrawingContext context)
        {
            if (parameters.Count != ParamCount)
            {
                throw new ArgumentException($"Invalid number of arguments: {parameters.Count}. Expected {ParamCount}.");
            }
            var doubleParameters = parameters.Take(4).Select(int.Parse).ToList();
            var width = doubleParameters[2] - doubleParameters[0];
            var height = doubleParameters[3] - doubleParameters[1];
            var rect = new Rectangle(doubleParameters[0], doubleParameters[1], width, height);
            var doubleParametres = parameters.Skip(4).Take(2).Select(float.Parse).ToList();
            return new ArcShape(rect, doubleParametres[0], doubleParametres[1], context.CreatePenBillet());
        }
    }
}