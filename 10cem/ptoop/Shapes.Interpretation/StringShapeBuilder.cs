using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text.RegularExpressions;

namespace Shapes.Interpretation
{
    public class StringShapeBuilder : IShapeBuilder
    {
        private const int ParamCount = 3;
        private static readonly Regex StringRegex = new Regex(@"^(['""])(?<text>[^'""]*)\1$");

        public IShape Build(IList<string> parameters, DrawingContext context)
        {
            if (parameters.Count != ParamCount)
            {
                throw new ArgumentException($"Invalid number of arguments: {parameters.Count}. Expected {ParamCount}.");
            }
            Match textMatch = StringRegex.Match(parameters[0]);
            var text = textMatch.Success
                ? textMatch.Groups["text"].Value
                : throw new ArgumentException($"The string {parameters[0]} is in incorrect format.");
            var intParams = parameters
                .Skip(1)
                .Take(2)
                .Select(int.Parse)
                .ToList();
            var point = new Point(intParams[0], intParams[1]);
            return new StringShape(text, point, context.CreateBrushBillet(), context.CreateFontBillet());
        }
    }
}