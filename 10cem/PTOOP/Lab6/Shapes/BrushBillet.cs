using System;
using System.Drawing;
using System.Runtime.Serialization;

namespace Shapes
{
    /// <summary>
    /// Class that describes a brush and can create brushes by the description.
    /// </summary>
    [DataContract]
    public class BrushBillet
    {
        [DataMember] private readonly Color color_;
        [DataMember] private readonly BrushType type_;

        public BrushBillet(Color color, BrushType type)
        {
            color_ = color;
            type_ = type;
        }

        public Color Color => color_;

        public BrushType Type => type_;

        public Brush CreateBrush()
        {
            switch (Type)
            {
                case BrushType.Solid:
                    return new SolidBrush(Color);
                default:
                    throw new InvalidOperationException($"Invalid brush type: {Type}");
            }
        }
    }
}
