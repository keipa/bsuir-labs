using System.Collections.Generic;

namespace Shapes.Interpretation
{
    public class ControlCommandProcessor : IControlCommandProcessor
    {
        private readonly Dictionary<string, IContextUpdater> updaters_ = new Dictionary<string, IContextUpdater>();

        // TODO: API to remove or overwrite
        public bool Register(string commandName, IContextUpdater updater)
        {
            var key = GetKey(commandName);
            if (!updaters_.ContainsKey(key))
            {
                updaters_.Add(key, updater);
                return true;
            }
            return false;
        }

        public void Process(string commandName, string commandValue, DrawingContext context)
        {
            var key = GetKey(commandName);
            if (updaters_.TryGetValue(key, out var updater))
            {
                updater.Update(context, commandValue);
            }
        }

        private string GetKey(string commandName)
        {
            return commandName.ToLowerInvariant();
        }
    }
}
