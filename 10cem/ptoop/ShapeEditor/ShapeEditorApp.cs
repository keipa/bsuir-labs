using System;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Windows.Forms;

namespace ShapeEditor
{
    public class ShapeEditorApp
    {
        private readonly IPluginLoader pluginLoader_;
        private readonly Func<Form> mainFormFactory_;

        public ShapeEditorApp(
            IPluginLoader pluginLoader, 
            Func<Form> mainFormFactory)
        {
            pluginLoader_ = pluginLoader;
            mainFormFactory_ = mainFormFactory;
        }

        public void Run()
        {
            LoadPlugins();
            RunMainForm();
        }

        private void LoadPlugins()
        {
            // TODO: inject configuration manager to avoid using static
            var fileNames = (ConfigurationManager.AppSettings["pluginDlls"] ?? "")
                .Split(new[] {';'}, StringSplitOptions.None)
                .Select(path => path.Trim())
                .Where(path => !String.IsNullOrEmpty(path));
            foreach (string fileName in fileNames)
            {
                // TODO: improve plugin management
                LoadPlugins(fileName);
            }
        }

        private static Assembly GetAssembly(string fileName)
        {
            using (var fileStream = File.Open(fileName, FileMode.Open))
            using (var memoryStream = new MemoryStream())
            {
                fileStream.CopyTo(memoryStream);
                var byteArray = memoryStream.ToArray();
                return Assembly.Load(byteArray);
            }
        }

        private void LoadPlugins(string dllFileName)
        {
            // TODO: can be done via UI at runtime
            try
            {
                // TODO: add a plugin manager or smth
                Assembly assembly = GetAssembly(dllFileName);
                pluginLoader_.Load(assembly);
            }
            catch (Exception e)
            {
                // TODO: log
            }
        }

        private void RunMainForm()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            // NOTE: SetCompatibleTextRenderingDefault() has to be called before any form is created => cannot pass the form
            Application.Run(mainFormFactory_());
        }
    }
}
