# face-Encryption via AES encryption
Face encryption is a technique that prevents unauthorized applications from using face recognition to identify users.

for encryption we used AES method check https://github.com/alirezadori/AES_Encryption for AES source code.

this code will use a 16 bytes key which will expand to size of faces (in the Picture). for expand Key we use a methode just like AES Key Expansion with a subtle difference which makes impossible to find keys witout source Code and primary key.

finally you can decrypt your Image with your key.

for encryption use MainFaceEncryptor.m AND and MainFaceDecryptor.m will Decrypt your Image.

the point of this project is you can cipher multi Faces in Image with one 16 bytes Key and decrypt it with the same Key without any more Data.
