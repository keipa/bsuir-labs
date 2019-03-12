using System.Collections.Generic;

namespace Shapes.Interpretation
{
    /// <summary>
    /// Shape building unit creating shapes from provided parameters.
    /// </summary>
    public interface IShapeBuilder
    {
        /// <summary>
        /// Creates a shape using the provided parameters.
        /// </summary>
        /// <param name="parameters"></param>
        /// <param name="context"></param>
        /// <returns></returns>
        IShape Build(IList<string> parameters, DrawingContext context);
    }
}
