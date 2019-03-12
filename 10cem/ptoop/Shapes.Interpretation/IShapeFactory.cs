using System.Collections.Generic;

namespace Shapes.Interpretation
{
    public interface IShapeFactory
    {
        IShape Create(string name, IEnumerable<string> parameters, DrawingContext context);

        bool Register(string name, IShapeBuilder shapeBuilder);
    }
}
