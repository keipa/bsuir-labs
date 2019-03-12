using System.Collections.Generic;

namespace Shapes.Interpretation
{
    public interface IShapeInterpreter
    {
        IEnumerable<IShape> Interpret(string text, DrawingContext context);
    }
}
