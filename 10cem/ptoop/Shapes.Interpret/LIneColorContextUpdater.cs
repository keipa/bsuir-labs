using System;
using System.Drawing;
using System.Linq;
using System.Text.RegularExpressions;

namespace Shapes.Interpretation
{
    public class LineColorContextUpdater : IContextUpdater
    {
        private static readonly Regex ArgbRegex = 
            new Regex(@"^argb\((?<numbers>[^\)]+)\)$");

        public void Update(DrawingContext context, string arg)
        {
            context.LineColor = ParseColor(arg);
        }

        private Color ParseColor(string arg)
        {
            var lowerArg = arg.ToLowerInvariant();
            var match = ArgbRegex.Match(lowerArg);
            if (!match.Success)
            {
                throw new FormatException(GetErrorMessage(arg));
            }
            return GetColor(match);
        }

        private Color GetColor(Match match)
        {
            try
            {
                var numbers = match.Groups["numbers"].Value
                    .Split(',')
                    .Select(arg => arg.Trim())
                    .Select(int.Parse)
                    .ToArray();
                return Color.FromArgb(numbers[0], numbers[1], numbers[2], numbers[3]);
            }
            catch (Exception e)
            {
                throw new FormatException(GetErrorMessage(match.Value));
            }
        }

        private string GetErrorMessage(string arg)
        {
            return $"'{arg}' is not a valid ARGB declaration. Use 'argb(1, 2, 3, 4)'.";
        }
    }
}
