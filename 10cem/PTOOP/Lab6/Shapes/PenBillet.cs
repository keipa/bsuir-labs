using System.Drawing;
using System.Runtime.Serialization;

namespace Shapes
{
    /// <summary>
    /// A class describing a pen and capable of creating pens by the description.
    /// </summary>
    [DataContract]
    public class PenBillet
    {
        [DataMember] private readonly Color color_;
        [DataMember] private readonly int? width_;

        public PenBillet(Color color)
        {
            color_ = color;
        }

        public PenBillet(Color color, int width)
        {
            color_ = color;
            width_ = width;
        }

        public Color Color => color_;

        public int? Width => width_;

        public Pen CreatePen()
        {
            return Width.HasValue
                ? new Pen(Color, Width.Value)
                : new Pen(Color);
        }
    }
}
