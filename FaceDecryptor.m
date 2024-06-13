function decrypted = FaceDecryptor(I,key)
[I,KAI] = dataExtraction(I);
decrypted = I;

numberOfFaces = size(KAI,1);
for i = 1:numberOfFaces
    faces{i,1} =imcrop(I,KAI{i,2});
    len(i) = length(faces{i,1}(:));
end
lenMaxPic = max(len);
allKeys = KeyExpander(key,lenMaxPic);

for i = 1:numberOfFaces
    attached = KAI{i,1};
    a = KAI{i,2};
    keys = allKeys(1:len(i));
    numpad = double(KAI{i,3});
    temp1 = imcrop(I,a);
    temp = cat(1,temp1(:),attached);
    tempDecrypted = AESDecryptor(temp,keys,numpad);
    tempDecrypted =reshape(tempDecrypted,size(temp1));
    decrypted(a(2):a(2)+a(4),a(1):a(1)+a(3),:) = tempDecrypted;
end














end