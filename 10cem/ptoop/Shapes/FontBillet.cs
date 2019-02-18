using System.Drawing;
using System.Runtime.Serialization;

namespace Shapes
{
    /// <summary>
    /// A class describing a font and capable of creating fonts by the description.
    /// </summary>
    [DataContract]
    public class FontBillet
    {
        [DataMember] private readonly float emSize_;
        [DataMember] private readonly string familyName_;

        public FontBillet(string familyName, float emSize)
        {
            familyName_ = familyName;
            emSize_ = emSize;
        }

        public float EmSize => emSize_;

        public string FamilyName => familyName_;

        /// <summary>
        /// Creates a font according to the stored settings.
        /// </summary>
        /// <returns></returns>
        public Font CreateFont()
        {
            return new Font(FamilyName, EmSize);
        }
    }
}
