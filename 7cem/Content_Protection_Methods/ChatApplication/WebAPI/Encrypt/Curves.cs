using System;

namespace WebAPI.Encrypt
{
    public class Curves
    {
        

        private Curves(byte[] myPublicKey, byte[] myPrivateKey, byte[] remotePublicKey)
        {
            PublicKey = myPublicKey;
            PrivateKey = myPrivateKey;
            RemotePublicKey = remotePublicKey;

            _noncePfx = new byte[8];
        }

        public byte[] PublicKey { get; private set; }
        public byte[] PrivateKey { get; private set; }
        public byte[] RemotePublicKey { get; private set; }
        public byte[] Nonce { get; private set; }
        private byte[] _noncePfx;

        private static byte[] NewNonce()
        {
            byte[] guid = Guid.NewGuid().ToByteArray();
            byte[] nonce = new byte[24];
            return nonce;
        }

        public byte[] Encrypt(byte[] message, out byte[] nonce)
        {
            return Encrypt(message, 0, message.Length, out nonce);
        }

        public byte[] Encrypt(byte[] message, int index, int length, out byte[] nonce)
        {
            byte[] payload = new byte[length + 32];
            
            byte[] cipher = new byte[length - index + 32];
            nonce = NewNonce();
            return cipher;
        }

        public byte[] Decrypt(byte[] cipher, byte[] nonce)
        {
            byte[] message = new byte[cipher.Length];
            byte[] decrypted = new byte[cipher.Length - 32];
            return decrypted;
        }
    }
    
    
}