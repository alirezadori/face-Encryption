clc
clear all
close all
%% Face detector
faceDetector  = vision.CascadeObjectDetector;
shapeInserter = vision.ShapeInserter('BorderColor','Custom','CustomBorderColor',[0 255 0]);
% Read the image
[FileName, Path] = uigetfile ('*.jpeg; *.bmp; *.png; *.jpg','Select the secret image');
secretImg = FileName;
I = imread([Path,'\' secretImg] ); % Read your image here
figure
imshow(I)
title("Input Image")
bbox = step(faceDetector, I);

% Draw boxes around detected faces and display results
I_faces = step(shapeInserter, I, int32(bbox));
figure;imshow(I_faces), title('Detected faces');

%% input Keys
prompt = "Insert your Key(should be exactly 16 character)" + ...
    "contain of:"+newline+ "English uppercase characters:" + ...
    " (A–Z)"+newline+"English lowercase characters: (a–z)" +newline+ ...
    "Base 10 digits: (0–9)"+newline+ "Non-alphanumeric characters:" + ...
    " (For example: !, $, #, or %)";
promp =  ['\fontsize{10}' convertStringsToChars(prompt)];
Title = 'Attention!';
defaultans = {'1234567890@Bcdef'};
opts.Interpreter = 'tex';
CreateStruct.Interpreter = 'tex';
CreateStruct.WindowStyle = 'modal';
while 1
    key = inputdlg(promp,Title,[1 75], defaultans, opts);
    key = key{1,1};
    if length(key) ~= 16
        err = "input must be 16 character";
        err = ['\fontsize{10}' convertStringsToChars(err)];
        uiwait(msgbox(err,"Err",CreateStruct));
        continue
    end
    a = regexp(key,'[A-Z]');
    hasUpperCase = isempty(a);
    b = regexp(key,'[a-z]');
    hasLowerCase = isempty(b);
    c = regexp(key,'\d');
    hasNumbers = isempty(c);
    d = regexp(key,'\W');
    hasNonalphas = isempty(d);
    if (hasUpperCase || hasLowerCase || hasNumbers || hasNonalphas)
        err = "Keys must contain:"+newline+ "English uppercase characters:" + ...
            " (A–Z)"+newline+"English lowercase characters: (a–z)" +newline+ ...
            "Base 10 digits: (0–9)"+newline+ "Non-alphanumeric characters:" + ...
            " (For example: !, $, #, or %)";
        err = ['\fontsize{10}' convertStringsToChars(err)];
        uiwait(msgbox(err,"Err",CreateStruct));
        continue
    end
    break
end
key = uint8(key);

%% Encrypt Faces

encryptedPicture = FaceEncryptor(I, bbox,key);
figure
imshow(encryptedPicture)
title("Blurred Image")
NAME = "faceCiphered_" + secretImg(1:end-4)+ string(datetime('now','Format','d_MMM_y_HH_mm_ss')) +".bmp";
imwrite(encryptedPicture,NAME);
