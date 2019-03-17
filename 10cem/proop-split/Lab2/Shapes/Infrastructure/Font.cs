namespace Shapes
{
    public class Font
    {
        private readonly float _emSize;

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