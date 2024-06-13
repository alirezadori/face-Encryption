# face-Encryption via AES encryption
Face encryption is a technique that prevents unauthorized applications from using face recognition to identify users.

for encryption we use AES method cheak https://github.com/alirezadori/AES_Encryption for AES source code.

this code will use a 16 bytes key which will expand to size of face (in the Picture) for expansion we use a methode just like AES Key Expansion with a small difference which will be Hard to find keys witout source Code.

finally you can decrypt your Image with your key.

for encryption use MainFaceEncryptor.m AND and MainFaceDecryptor.m will encrypt your Image.

the point of this project is you can encrypt an Image with one 16 bytes Key and decrypt it with the same Key without any more Data.
