function Image = FaceEncryptor(I,bbox,keys)

numberOfFace = size(bbox,1);
Image = I;
faces = cell(numberOfFace,1);
for i = 1:numberOfFace
    faces{i,1} =imcrop(I,bbox(i,:));
    len(i) = length(faces{i,1}(:));
end
lenMaxPic = max(len);
keys = KeyExpander(keys,lenMaxPic);
%% encrypt facess
requirements = cell(numberOfFace,3);
for i = 1:numberOfFace
    temp1 = faces{i,1};
    temp = temp1(:);
    lenPic = length(temp);
    keysTemp = keys(:);
    keysTemp = keysTemp(1:lenPic);
    [cipher, numpad] = AESEncryptor(temp,keysTemp);
    faceCiphered = cipher(1:end-numpad);
    attached = cipher(end-numpad+1:end);
    imageFaceCipherd = reshape(faceCiphered,size(temp1));
    a = bbox(i,:);
    requirements{i,1} = attached;
    requirements{i,2} = a;
    requirements{i,3} = numpad;
    Image(a(2):a(2)+a(4),a(1):a(1)+a(3),:) = imageFaceCipherd;
    %   Image(a(2):a(2)+a(4),a(1):a(1)+a(3),:) = uint8(mean(faces{i,1}(:)))*ones(size(faces{i,1}),'uint8');
    %   Image(a(2):a(2)+a(4),a(1):a(1)+a(3),:) = imgaussfilt(faces{i,1},10);
end
Image = dataFusionToImage(Image,requirements);

end