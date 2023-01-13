clear all;
close all;
clc;
format short g;

%% Initializations
block_len=16;

key_ascii1='One Piece exists';
nonce_key_ascii='For The NewWorld';

key = double(key_ascii1);
nonce_key = double(nonce_key_ascii);

plaintext_ascii='HackMe IfYouDare';

nonce = randi(255, [1, 16]);

IV = cipher(nonce, nonce_key);

ciphertext=[];
recovered_plaintext=[];

%% add padding
len = length(plaintext_ascii);
pad_len=16-rem(len,16);

padded_plaintext=double([plaintext_ascii,repmat(pad_len,1, pad_len)]);
num_chain=length(padded_plaintext)/block_len;

%% encryption

previous_block = IV;
for i=1:block_len:length(padded_plaintext)
    block = bitxor(padded_plaintext(i:i+block_len-1),previous_block);
    previous_block = cipher(block,key);
    ciphertext = [ciphertext previous_block];
end

%% decryption

previous_block = IV;
for i=1:block_len:length(ciphertext)
    uncipher_block = inv_cipher(ciphertext(i:i+block_len-1),key);
    recovered_plaintext = [recovered_plaintext bitxor(previous_block,uncipher_block)];
    block = ciphertext(i:i+block_len-1);
end

recovered_plaintext_ascii = char(recovered_plaintext);




