using System.Collections.Generic;

namespace Shapes.Interpretation
{
    public interface IShapeBuilder
    {
        IShape Build(IList<string> parameters, DrawingContext context);
    }
}
