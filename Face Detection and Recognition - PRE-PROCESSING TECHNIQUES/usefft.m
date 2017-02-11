clear all;close all; clc;
I=imread('D:\workspace\nitin database\New folder\FERET\s1\1.ppm');
I=rgb2gray(I);
figure,imshow(I);
%% background removal technique
% I=im2bw(I);
% figure,imshow(I);
% I=im2double(I);
%D:\workspace\nitin database\New folder\faces\image_0001.jpg
% % fft
% H=fft2(I);
% % l=ifft2((H));
% % figure,imshow(l);
% % figure,image(abs(H));
% k=fftshift(H);
% figure,image(abs(k));
% % % p=k(20:70,20:70);
% % o=ifft2(k);
% % % figure,imshowpair(o,l);
% % figure,imshow(o);
% % figure,image(abs(k));
% % figure,mesh((abs(k)));
% % figure,mesh((abs(H)));
% 
% %% noise
% % 
% % J = imnoise(I,'gaussian',0,0.001);
% % figure, imshow(I)
% % figure, imshow(J)

% %% dct
% figure,imshow(I);
% s=dct2(I);                   %dont apply after im2double
% figure,image(s);
% d=idct2(s);
% figure,image(uint8(d));
% d=uint8(d);
% a=(4*uint8(d)+I)./2;
% figure,imshow(a);
% f=dct2(a);
% figure,image(f);

%% diff dct sequential
%  figure,imshow(I);
% s=dct2(I);                   %dont apply after im2double
% figure,image(s);
% d=idct2(s);
% figure,image(uint8(d));
% d=uint8(d);
% a=(uint8(d)+I)*2;
% figure,imshow(a);


 %% dct another
%  
%  figure,imshow(I);
% s=dct2(I);                   %dont apply after im2double
% figure,image(s);
% d=idct2(s);
% figure,image(uint8(d));
% d=uint8(d);
% a=(1*(d)-I)./2;
% figure,imshow(a);
% f=dct2(a);
% figure,image(f);             % the dimensions decreases
% h=idct2(f);
% figure,image((h));
% a1=(uint8(h)-a)./2;
% figure,imshow(a1);
% %% remove background
% 
% a2=dct2(I);
% figure,image(a2);
% a3=idct2(a2);
% figure,imshow(mat2gray(a3));
% imshowpair(a3,I)
% 
% 
% k=(im2uint8(a3)-I)./2;
% imshow((k))
% figure,imshow(I);
%% remove

s=dct2(I);                   %dont apply after im2double
figure,image(s);
d=idct2(s);
figure,image(uint8(d));
d=im2uint8(d);
a=(1*(d)-I)./2;
figure,imshow(a);
f=dct2(a);
figure,image(f);             % the dimensions decreases
h=idct2(f);
figure,image((h));
a1=(im2uint8(h)-a)./2;
figure,imshow(a1);
% % 
% a2=dct2(I);
% figure,image(a2);
% a3=idct2(a2);
% figure,image(a3);
% 
% %% dct based background removal
% 
% 
% I=im2double(I);
% s=dct2(I);                   %dont apply after im2double
% figure,image(s);
% d=idct2(s);
% figure,image(d);
% % d=uint8(d);
% 
% a=((d)+(I))./2;
% 
%  figure,imshow(mat2gray(a));
% a(:,:)=0.*(a<1)+1.*(a>=1);
% figure,imshow(a);
% figure,imshow((a));
% I=I.*a;
% figure,imshow(I);
% 
% % edging=edge(I,'sobel');
% % imshow(edging);
% 
% a=dct2(I);
% s=idct2(a);
% figure,image(s);
% k=dwt2(a,'db1');
% k1=dct2(k);
% k2=idct2(k1);
% figure,image(k2)
















