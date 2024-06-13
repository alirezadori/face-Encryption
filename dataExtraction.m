function [Image , KAI]  =dataExtraction(image)
I = image(:);

lenData = I(end-1:end);
lenData = double(typecast(lenData,'uint16'));
allInformation = I(end-lenData+1:end-2);
orginalSize = allInformation(1:6);
orginalSize = double(typecast(orginalSize,'uint16'));
numFace = double(allInformation(7));
lenBbox = numFace*8;
bbox = allInformation(8:7+lenBbox);
bbox = double(typecast(bbox','uint16'));
bbox = reshape(bbox,numFace,4);
line = 8 + lenBbox;
numPad = double(allInformation(line:line+numFace-1));
line = line+numFace;
KAI = cell(numFace,3);
for i = 1:numFace
    KAI{i,1} = allInformation(line:line+numPad(i)-1);
    line = line + numPad(i);
    KAI{i,2} = bbox(i,:);
    KAI{i,3} = numPad(i);
end
a = orginalSize(1) * orginalSize(3);
b = ceil(lenData/a);
Image = image(:,1:end-b,:);









end