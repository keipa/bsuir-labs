namespace Shapes.Interpretation
{
    public class LineWidthContextUpdater : IContextUpdater
    {
        public void Update(DrawingContext context, string arg)
        {
            context.LineWidth = GetWidth(arg);
        }

        private int GetWidth(string arg)
        {
            return int.Parse(arg);
        }
    }
}
