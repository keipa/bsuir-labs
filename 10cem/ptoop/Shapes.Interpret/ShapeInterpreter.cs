using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;

namespace Shapes.Interpretation
{
    /// <summary>
    /// An interpreter creating shapes from their string representation.
    /// </summary>
    public class ShapeInterpreter : IShapeInterpreter
    {
        private static readonly Regex ShapeRegex = new Regex(@"^(?<name>\w+)\((?<coords>[^\)]*)\)$");
        private static readonly Regex ControlRegex = new Regex(@"^@(?<name>[^:]+)\s*:\s*(?<value>[^\n]*)$");

        private readonly IShapeFactory shapeFactory_;
        private readonly IControlCommandProcessor processor_;

        public ShapeInterpreter(IShapeFactory shapeFactory, IControlCommandProcessor processor)
        {
            shapeFactory_ = shapeFactory;
            processor_ = processor;
        }

        public IEnumerable<IShape> Interpret(string text, DrawingContext context)
        {
            var lines = text.Split(new[] {Environment.NewLine}, StringSplitOptions.None)
                .Where(line => !String.IsNullOrWhiteSpace(line));
            foreach (string line in lines)
            {
                if (IsControl(line))
                {
                    ParseControl(line, context);
                }
                else
                {
                    yield return ParseShape(line, context);
                }
            }
        }

        private bool IsControl(string line)
        {
            return line.StartsWith("@");
        }

        private void ParseControl(string line, DrawingContext context)
        {
            var match = ControlRegex.Match(line);
            if (!match.Success)
            {
                throw new FormatException($"Invalid control statement: '{line}'");
            }
            var commandName = match.Groups["name"].Value.Trim();
            var commandValue = match.Groups["value"].Value.Trim();
            processor_.Process(commandName, commandValue, context);
        }

        private IShape ParseShape(string line, DrawingContext context)
        {
            var match = ShapeRegex.Match(line);
            if (!match.Success)
            {
                throw new FormatException($"Invalid shape declaration: '{line}'.");
            }
            var shapeName = match.Groups["name"].Value;
            var parameters = match.Groups["coords"].Value
                .Split(',')
                .Select(item => item.Trim());
            return shapeFactory_.Create(shapeName, parameters, context);
        }
    }
}
