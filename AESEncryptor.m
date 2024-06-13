function [encrypted, padnum]=  AESEncryptor(Image,keyAll)
%%
sBox = ['637c777bf26b6fc53001672bfed7ab76';...
    'ca82c97dfa5947f0add4a2af9ca472c0';...
    'b7fd9326363ff7cc34a5e5f171d83115';...
    '04c723c31896059a071280e2eb27b275';...
    '09832c1a1b6e5aa0523bd6b329e32f84';...
    '53d100ed20fcb15b6acbbe394a4c58cf';...
    'd0efaafb434d338545f9027f503c9fa8';...
    '51a3408f929d38f5bcb6da2110fff3d2';...
    'cd0c13ec5f974417c4a77e3d645d1973';...
    '60814fdc222a908846eeb814de5e0bdb';...
    'e0323a0a4906245cc2d3ac629195e479';...
    'e7c8376d8dd54ea96c56f4ea657aae08';...
    'ba78252e1ca6b4c6e8dd741f4bbd8b8a';...
    '703eb5664803f60e613557b986c11d9e';...
    'e1f8981169d98e949b1e87e9ce5528df';...
    '8ca1890dbfe6426841992d0fb054bb16'];
sBox = uint8(hex2dec(reshape(sBox',2,[])'));
mul2num = [0x00,0x02,0x04,0x06,0x08,0x0a,0x0c,0x0e,0x10,0x12,0x14,0x16,0x18,0x1a,0x1c,0x1e ...
    0x20,0x22,0x24,0x26,0x28,0x2a,0x2c,0x2e,0x30,0x32,0x34,0x36,0x38,0x3a,0x3c,0x3e ...
    0x40,0x42,0x44,0x46,0x48,0x4a,0x4c,0x4e,0x50,0x52,0x54,0x56,0x58,0x5a,0x5c,0x5e ...
    0x60,0x62,0x64,0x66,0x68,0x6a,0x6c,0x6e,0x70,0x72,0x74,0x76,0x78,0x7a,0x7c,0x7e ...
    0x80,0x82,0x84,0x86,0x88,0x8a,0x8c,0x8e,0x90,0x92,0x94,0x96,0x98,0x9a,0x9c,0x9e ...
    0xa0,0xa2,0xa4,0xa6,0xa8,0xaa,0xac,0xae,0xb0,0xb2,0xb4,0xb6,0xb8,0xba,0xbc,0xbe ...
    0xc0,0xc2,0xc4,0xc6,0xc8,0xca,0xcc,0xce,0xd0,0xd2,0xd4,0xd6,0xd8,0xda,0xdc,0xde ...
    0xe0,0xe2,0xe4,0xe6,0xe8,0xea,0xec,0xee,0xf0,0xf2,0xf4,0xf6,0xf8,0xfa,0xfc,0xfe ...
    0x1b,0x19,0x1f,0x1d,0x13,0x11,0x17,0x15,0x0b,0x09,0x0f,0x0d,0x03,0x01,0x07,0x05 ...
    0x3b,0x39,0x3f,0x3d,0x33,0x31,0x37,0x35,0x2b,0x29,0x2f,0x2d,0x23,0x21,0x27,0x25 ...
    0x5b,0x59,0x5f,0x5d,0x53,0x51,0x57,0x55,0x4b,0x49,0x4f,0x4d,0x43,0x41,0x47,0x45 ...
    0x7b,0x79,0x7f,0x7d,0x73,0x71,0x77,0x75,0x6b,0x69,0x6f,0x6d,0x63,0x61,0x67,0x65 ...
    0x9b,0x99,0x9f,0x9d,0x93,0x91,0x97,0x95,0x8b,0x89,0x8f,0x8d,0x83,0x81,0x87,0x85 ...
    0xbb,0xb9,0xbf,0xbd,0xb3,0xb1,0xb7,0xb5,0xab,0xa9,0xaf,0xad,0xa3,0xa1,0xa7,0xa5 ...
    0xdb,0xd9,0xdf,0xdd,0xd3,0xd1,0xd7,0xd5,0xcb,0xc9,0xcf,0xcd,0xc3,0xc1,0xc7,0xc5 ...
    0xfb,0xf9,0xff,0xfd,0xf3,0xf1,0xf7,0xf5,0xeb,0xe9,0xef,0xed,0xe3,0xe1,0xe7,0xe5]';

mul3num = [0x00,0x03,0x06,0x05,0x0c,0x0f,0x0a,0x09,0x18,0x1b,0x1e,0x1d,0x14,0x17,0x12,0x11 ...
    0x30,0x33,0x36,0x35,0x3c,0x3f,0x3a,0x39,0x28,0x2b,0x2e,0x2d,0x24,0x27,0x22,0x21 ...
    0x60,0x63,0x66,0x65,0x6c,0x6f,0x6a,0x69,0x78,0x7b,0x7e,0x7d,0x74,0x77,0x72,0x71 ...
    0x50,0x53,0x56,0x55,0x5c,0x5f,0x5a,0x59,0x48,0x4b,0x4e,0x4d,0x44,0x47,0x42,0x41 ...
    0xc0,0xc3,0xc6,0xc5,0xcc,0xcf,0xca,0xc9,0xd8,0xdb,0xde,0xdd,0xd4,0xd7,0xd2,0xd1 ...
    0xf0,0xf3,0xf6,0xf5,0xfc,0xff,0xfa,0xf9,0xe8,0xeb,0xee,0xed,0xe4,0xe7,0xe2,0xe1 ...
    0xa0,0xa3,0xa6,0xa5,0xac,0xaf,0xaa,0xa9,0xb8,0xbb,0xbe,0xbd,0xb4,0xb7,0xb2,0xb1 ...
    0x90,0x93,0x96,0x95,0x9c,0x9f,0x9a,0x99,0x88,0x8b,0x8e,0x8d,0x84,0x87,0x82,0x81	...
    0x9b,0x98,0x9d,0x9e,0x97,0x94,0x91,0x92,0x83,0x80,0x85,0x86,0x8f,0x8c,0x89,0x8a ...
    0xab,0xa8,0xad,0xae,0xa7,0xa4,0xa1,0xa2,0xb3,0xb0,0xb5,0xb6,0xbf,0xbc,0xb9,0xba ...
    0xfb,0xf8,0xfd,0xfe,0xf7,0xf4,0xf1,0xf2,0xe3,0xe0,0xe5,0xe6,0xef,0xec,0xe9,0xea	 ...
    0xcb,0xc8,0xcd,0xce,0xc7,0xc4,0xc1,0xc2,0xd3,0xd0,0xd5,0xd6,0xdf,0xdc,0xd9,0xda	 ...
    0x5b,0x58,0x5d,0x5e,0x57,0x54,0x51,0x52,0x43,0x40,0x45,0x46,0x4f,0x4c,0x49,0x4a ...
    0x6b,0x68,0x6d,0x6e,0x67,0x64,0x61,0x62,0x73,0x70,0x75,0x76,0x7f,0x7c,0x79,0x7a	 ...
    0x3b,0x38,0x3d,0x3e,0x37,0x34,0x31,0x32,0x23,0x20,0x25,0x26,0x2f,0x2c,0x29,0x2a ...
    0x0b,0x08,0x0d,0x0e,0x07,0x04,0x01,0x02,0x13,0x10,0x15,0x16,0x1f,0x1c,0x19,0x1a]';

rcon =[0x8d, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1b, 0x36, 0x6c, 0xd8 ...
    0xab, 0x4d, 0x9a, 0x2f, 0x5e, 0xbc, 0x63, 0xc6, 0x97, 0x35, 0x6a, 0xd4, 0xb3, 0x7d ...
    0xfa, 0xef, 0xc5, 0x91, 0x39, 0x72, 0xe4, 0xd3, 0xbd, 0x61, 0xc2, 0x9f, 0x25, 0x4a ...
    0x94, 0x33, 0x66, 0xcc, 0x83, 0x1d, 0x3a, 0x74, 0xe8, 0xcb, 0x8d, 0x01, 0x02, 0x04 ...
    0x08, 0x10, 0x20, 0x40, 0x80, 0x1b, 0x36, 0x6c, 0xd8, 0xab, 0x4d, 0x9a, 0x2f, 0x5e ...
    0xbc, 0x63, 0xc6, 0x97, 0x35, 0x6a, 0xd4, 0xb3, 0x7d, 0xfa, 0xef, 0xc5, 0x91, 0x39 ...
    0x72, 0xe4, 0xd3, 0xbd, 0x61, 0xc2, 0x9f, 0x25, 0x4a, 0x94, 0x33, 0x66, 0xcc, 0x83 ...
    0x1d, 0x3a, 0x74, 0xe8, 0xcb, 0x8d, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80 ...
    0x1b, 0x36, 0x6c, 0xd8, 0xab, 0x4d, 0x9a, 0x2f, 0x5e, 0xbc, 0x63, 0xc6, 0x97, 0x35 ...
    0x6a, 0xd4, 0xb3, 0x7d, 0xfa, 0xef, 0xc5, 0x91, 0x39, 0x72, 0xe4, 0xd3, 0xbd, 0x61 ...
    0xc2, 0x9f, 0x25, 0x4a, 0x94, 0x33, 0x66, 0xcc, 0x83, 0x1d, 0x3a, 0x74, 0xe8, 0xcb ...
    0x8d, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1b, 0x36, 0x6c, 0xd8, 0xab ...
    0x4d, 0x9a, 0x2f, 0x5e, 0xbc, 0x63, 0xc6, 0x97, 0x35, 0x6a, 0xd4, 0xb3, 0x7d, 0xfa ...
    0xef, 0xc5, 0x91, 0x39, 0x72, 0xe4, 0xd3, 0xbd, 0x61, 0xc2, 0x9f, 0x25, 0x4a, 0x94 ...
    0x33, 0x66, 0xcc, 0x83, 0x1d, 0x3a, 0x74, 0xe8, 0xcb, 0x8d, 0x01, 0x02, 0x04, 0x08 ...
    0x10, 0x20, 0x40, 0x80, 0x1b, 0x36, 0x6c, 0xd8, 0xab, 0x4d, 0x9a, 0x2, 0x5e, 0xbc ...
    0x63, 0xc6, 0x97, 0x35, 0x6a, 0xd4, 0xb3, 0x7d, 0xfa, 0xef, 0xc5, 0x91, 0x39, 0x72 ...
    0xe4, 0xd3, 0xbd, 0x61, 0xc2, 0x9f, 0x25, 0x4a, 0x94, 0x33, 0x66, 0xcc, 0x83, 0x1d ...
    0x3a, 0x74, 0xe8, 0xcb, 0x8d]';
%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
padnum = 16 - mod(length(Image),16);
if padnum == 16
    padnum = 0;
end
if 0 < padnum 
    Image = padarray(Image,[padnum 0],'post');
    keyAll = padarray(keyAll,[padnum 0],'post');
end
numberOfRounds = 10;
Image = reshape(Image,4,[]);
keyAll =reshape(keyAll,4,[]);
encrypted = zeros(size(Image),"uint8");
for qq = 1:4:size(Image,2)-3
    state = Image(:,qq:qq+3);
    key = keyAll(:,qq:qq+3);
    expandedKeys = KeyExpansion(key);
    
    state = AddRoundKey(state,key);
    for i = 5:4:numberOfRounds*4
        state = SubBytes(state);
        state = ShiftRows(state);
        state = MixColumns(state);
        state = AddRoundKey(state,expandedKeys(:,i:i+3));
    end
    state = SubBytes(state);
    state = ShiftRows(state);
    state = AddRoundKey(state,expandedKeys(:,end-3:end));
    encrypted(:,qq:qq+3) = state;
end
encrypted = encrypted(:);

%%%%%%%%%%%%%%%%%%%%%%%%
    function state = SubBytes(state16bit)
        state16bit = uint16(state16bit);
        state = sBox(state16bit+1);
    end

    function state = Mul2(state16bit)
        state16bit = uint16(state16bit);
        state = mul2num(state16bit+1);
    end

    function state = Mul3(state16bit)
        state16bit = uint16(state16bit);
        state = mul3num(state16bit+1);
    end

    function iii = RCon(state16bit)
        state16bit = uint16(state16bit);
        iii = rcon(state16bit+1);
    end


    function state = ShiftRows(state)
        state = [state(1,:)
            circshift(state(2,:),[0 -1])
            circshift(state(3,:),[0 -2])
            circshift(state(4,:),[0 -3])];
    end

    function State = MixColumns(state)
        tmp =zeros(16,1,'uint8');
        for ii = 1:4:16
            tmp(ii) = bitxor(bitxor(bitxor(Mul2(state(ii)), Mul3(state(ii+1))),state(ii+2)),state(ii+3));
            tmp(ii+1) =  bitxor(bitxor(bitxor(state(ii), Mul2(state(ii+1))), Mul3(state(ii+2))),state(ii+3));
            tmp(ii+2) =  bitxor(bitxor(bitxor(state(ii),state(ii+1)), Mul2(state(ii+2))), Mul3(state(ii+3)));
            tmp(ii+3) =  bitxor(bitxor(bitxor(Mul3(state(ii)),state(ii+1)),state(ii+2)), Mul2(state(ii+3)));
        end
        State = reshape(tmp,4,4);
    end

    function state = AddRoundKey(state,roundKey)
        state=bitxor(state,roundKey);
    end

    function in = KeyExpansionCore(in,i) %in is uint16
        in = [in(2:4); in(1)];
        in = SubBytes(in);
        in(1) = bitxor(in(1),RCon(i));
    end

    function expandedKeys = KeyExpansion(inputKey)
        expandedKeys = zeros((numberOfRounds+1)*16,1,'uint8');
        expandedKeys(1:16) = inputKey(:);
        bytesGenerated = 16;
        rconIteration = 1;
        while bytesGenerated < (numberOfRounds+1)*16
            temp = expandedKeys(bytesGenerated-3:bytesGenerated);
            if (mod(bytesGenerated,16) ==0)
                temp = KeyExpansionCore(temp,rconIteration);
                rconIteration = rconIteration+1;
            end
            for a = 1:4
                expandedKeys(bytesGenerated+1) = bitxor(expandedKeys(bytesGenerated - 15),temp(a));
                bytesGenerated = bytesGenerated+1;
            end
        end
        expandedKeys = reshape(expandedKeys,4,[]);
    end
end