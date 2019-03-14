using System;
using System.Drawing;
using System.Runtime.Serialization;

namespace Shapes
{
    [DataContract]
    public class BrushBillet
    {
        [DataMember] 
        private readonly Color _color;
        
        [DataMember] 
        private readonly BrushType _type;

        public BrushBillet(Color color, BrushType type)
        {
            _color = color;
            _type = type;
        }

        public Brush CreateBrush()
        {
            switch (_type)
            {
                case BrushType.Solid:
                    return new SolidBrush(_color);
                default:
                    throw new InvalidOperationException($"Invalid brush type: {_type}");
            }
        }
    }
}
