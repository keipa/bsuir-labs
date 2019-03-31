using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Linq;

namespace Shapes.Serialization.ThirdParty
{
    public class ZipShapeLoaderDecorator : IShapeLoader
    {
        private readonly IShapeLoader loader_;

        public ZipShapeLoaderDecorator(IShapeLoader loader)
        {
            loader_ = loader;
        }

        public string FileExtension => "zip";

        public IEnumerable<IShape> Load(Stream stream)
        {
            using (var archive = new ZipArchive(stream, ZipArchiveMode.Read, true))
            {
                var entry = archive.Entries.FirstOrDefault();
                if (entry == null)
                {
                    throw new ArgumentException("The package is invalid");
                }
                using (Stream zipStream = entry.Open())
                {
                    return loader_.Load(zipStream);
                }
            }
        }

        public void Save(Stream stream, IEnumerable<IShape> shapes)
        {
            using (var archive = new ZipArchive(stream, ZipArchiveMode.Create, true))
            {
                ZipArchiveEntry entry = archive.CreateEntry(Path.ChangeExtension("shapes", loader_.FileExtension));
                using (Stream zipStream = entry.Open())
                {
                    loader_.Save(zipStream, shapes);
                }
            }
        }
    }
}