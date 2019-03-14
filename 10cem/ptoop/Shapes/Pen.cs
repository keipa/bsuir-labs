using System.Drawing;
using System.Runtime.Serialization;

namespace Shapes
{
    [DataContract]
    public class Pen
    {
        [DataMember] 
        private readonly Color _color;
        
        [DataMember] 
        private readonly int? _width;

        public Pen(Color color)
        {
            _color = color;
        }

        public Pen(Color color, int width)
        {
            _color = color;
            _width = width;
        }

        public Color Color => _color;

        public int? Width => _width;

        public System.Drawing.Pen CreatePen()
        {
            return Width.HasValue
                ? new System.Drawing.Pen(Color, Width.Value)
                : new System.Drawing.Pen(Color);
        }
    }
}
