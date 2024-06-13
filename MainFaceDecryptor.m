clc
clear all
close all
%%
[FileName, Path] = uigetfile ('*.jpeg; *.bmp; *.png; *.jpg','Select the secret image');
secretImg = FileName;
I = imread([Path,'\' secretImg] ); % Read your image here
figure
imshow(I)
title("faceCiphered Image")

prompt = "Insert your Key(should be exactly 16 character)";
promp =  ['\fontsize{10}' convertStringsToChars(prompt)];
Title = 'Security Code';
defaultans = {''};
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
        j = 1;
        continue
    end
    break
end
%%  Decrypte faces
decrypted = FaceDecryptor(I,key);
figure(2)
imshow(decrypted)
title("decrypted")

answer = questdlg('Would you like to save Image?', ...
	'Save', ...
	'Yes','No thank you','No thank you');
switch answer
    case 'Yes'
        s = true;
    case 'No thank you'
        s = false;
end

if s
    figure(2)
    imsave
end












