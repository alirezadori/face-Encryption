function outImage = dataFusionToImage(image,info)

oSize = uint16(size(image));
if length(oSize) <3
    oSize(3) = 1;
end
orginalSize = typecast(oSize,'uint8');
numFace = uint8(size(info,1));
for i = 1:numFace
    bbox(i,:) = info{i,2};
    numpad(i) = info{i,3};
end
bbox = typecast(uint16(bbox(:)),'uint8'); %reshape(bbox,numFace,4)
numpad = uint8(numpad);
attach = [];
for i = 1:numFace
    attach = [attach info{i,1}'];
end
allInformation = [orginalSize' ; numFace; bbox ;numpad' ; attach'];
a = typecast(uint16(length(allInformation)+2),'uint8');
allInformation = [allInformation ; a'];
lenData = length(allInformation);
oSize = size(image);
if length(oSize) <3
    oSize(3) = 1;
end
b = ceil(lenData/oSize(3));
c = ceil(b/size(image,1));
shouldBePad = oSize(1)*c*oSize(3) - lenData;
inputData = padarray(allInformation,[shouldBePad 0],'pre');
inputData = reshape(inputData,[oSize(1),c,oSize(3)]);
outImage = [image inputData];
end
