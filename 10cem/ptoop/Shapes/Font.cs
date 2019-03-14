using System.Drawing;
using System.Runtime.Serialization;

namespace Shapes
{
    [DataContract]
    public class Font
    {
        [DataMember] 
        private readonly float _emSize;
        
        [DataMember] 
        private readonly string _familyName;

        public Font(string familyName, float emSize)
        {
            _familyName = familyName;
            _emSize = emSize;
        }

        public System.Drawing.Font CreateFont()
        {
            return new System.Drawing.Font(_familyName, _emSize);
        }
    }
}
