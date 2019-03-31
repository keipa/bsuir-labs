using System;
using System.Collections.Generic;
using System.IO;

namespace Shapes.Serialization.ThirdParty
{
    public class ChecksumShapeLoaderDecorator : IShapeLoader
    {
        private readonly IShapeLoader loader_;
        private readonly IHash hash_;

        public ChecksumShapeLoaderDecorator(IShapeLoader loader, IHash hash)
        {
            loader_ = loader;
            hash_ = hash;
        }

        public string FileExtension => "dat";

        public IEnumerable<IShape> Load(Stream stream)
        {
            var hash = new byte[hash_.ByteLength];
            stream.Read(hash, 0, hash.Length);
            using (var memoryStream = new MemoryStream())
            {
                // TODO?: reset position in memoryStream
                stream.CopyTo(memoryStream);
                memoryStream.Seek(0, SeekOrigin.Begin);
                var actualHash = hash_.Compute(memoryStream);
                memoryStream.Seek(0, SeekOrigin.Begin);
                if (!AreHashesEqual(hash, actualHash))
                {
                    throw new ArgumentException("The file is corrupted.");
                }
                return loader_.Load(memoryStream);
            }
        }

        public void Save(Stream stream, IEnumerable<IShape> shapes)
        {
            using (var memoryStream = new MemoryStream())
            {
                loader_.Save(memoryStream, shapes);
                memoryStream.Seek(0, SeekOrigin.Begin);
                byte[] hash = hash_.Compute(memoryStream);
                memoryStream.Seek(0, SeekOrigin.Begin);
                if (hash.Length != hash_.ByteLength)
                {
                    throw new InvalidOperationException("The hash algorithm is incorrect.");
                }
                stream.Write(hash, 0, hash.Length);
                memoryStream.CopyTo(stream);
            }
        }

        private bool AreHashesEqual(byte[] a, byte[] b)
        {
            if (a == null || b == null)
            {
                return false;
            }
            if (a.Length != b.Length)
            {
                return false;
            }
            for (var i = 0; i < a.Length; i++)
            {
                if (a[i] != b[i])
                {
                    return false;
                }
            }
            return true;
        }
    }
}
