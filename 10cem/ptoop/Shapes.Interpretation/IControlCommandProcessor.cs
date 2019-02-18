namespace Shapes.Interpretation
{
    public interface IControlCommandProcessor
    {
        void Process(string commandName, string commandValue, DrawingContext context);
    }
}
