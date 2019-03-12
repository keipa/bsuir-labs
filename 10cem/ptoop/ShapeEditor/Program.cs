using System;
using System.Windows.Forms;
using Shapes.Interpretation;
using Shapes.Serialization;

namespace ShapeEditor
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            // TODO: init by attribute?

            // NOTE: shapeFactory should be registered as singleton
            var shapeFactory = new ShapeFactory();
            shapeFactory.Register("line", new LineShapeBuilder());
            shapeFactory.Register("arc", new ArcShapeBuilder());
            shapeFactory.Register("curve", new CurveShapeBuilder());
            shapeFactory.Register("rectangle", new RectangleShapeBuilder());
            shapeFactory.Register("ellipse", new EllipseShapeBuilder());
            shapeFactory.Register("string", new StringShapeBuilder());

            var commandProcessor = new ControlCommandProcessor();
            commandProcessor.Register("linecolor", new LineColorContextUpdater());
            commandProcessor.Register("linewidth", new LineWidthContextUpdater());

            var shapeLoader = new ShapeLoader();
            // NOTE: shapeLoaderFactory should be registered as singleton
            var shapeLoaderFactory = new ShapeLoaderFactory(shapeLoader);

            var interpreter = new ShapeInterpreter(shapeFactory, commandProcessor);
            Form MainFormFactory() => new MainForm(interpreter, shapeLoaderFactory);

            var pluginLoader = new AggregatePluginLoader(new IPluginLoader[]
            {
                new ShapeBuilderPluginLoader(shapeFactory),
                new ShapeLoaderPluginLoader(shapeLoaderFactory), 
            });
            
            var app = new ShapeEditorApp(pluginLoader, MainFormFactory);
            app.Run();
        }
    }
}
