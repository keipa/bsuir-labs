using System;
using System.Diagnostics;
using System.IO;
using System.IO.Compression;
using Shapes.Infrastructure;

namespace Zipp
{
    public class Zipp : IPostDecorator
    {
        public void Apply(string path)
        {
            Compress(path, $"{path}.zip");
        }
        
        public void Compress(string sourceFilePath, string zippedFilePath)
        {
            Debug.WriteLine($"Starting compressing {GetFileSize(sourceFilePath):0.00} MB");
            try
            {
                using (var zipFile = ZipFile.Open(zippedFilePath, ZipArchiveMode.Create))
                {
                    zipFile.CreateEntryFromFile(sourceFilePath, Path.GetFileName(sourceFilePath));
                }
                Debug.WriteLine($"{100*GetFileSize(zippedFilePath)/ GetFileSize(sourceFilePath):0.00}% compression done");
                Debug.WriteLine($"Output:  {zippedFilePath}");
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.Message, e);
                throw;
            }
            
        }
        
        public double GetFileSize(string path) => (double) new FileInfo(path).Length / 1024 / 1024;

    }
}