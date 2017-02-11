clear all;close all;clc;

a=gaussian_filter(40,0.12,0.02);

%  imshow(mat2gray(a));
%  b=imcrop(a,[8 10 25 23]);

d=imcrop(a,[8 10 25 24]);
d(1:2,:)=0;
d(22:26,:)=0;
[x,y]=size(d);

j = randperm(40,1);
k = randperm(10,1);

F = imread(strcat('C:\Users\Tilak\Documents\MATLAB\IMAGE_DATABASE\ORL\s',num2str(j),'\',num2str(k),'.pgm'));
F=  imadjust(F,[],[],1/2);
C = normxcorr2(d, F);
% mesh(C)
[m n]=size(F);
D=imresize(C,[m n]);

% figure, imshow(F),axis on
% figure,surf(D)
%% peak detectors

[max_cc, imax] = max(D(:));
[ypeak, xpeak] = ind2sub(size(D),imax(1));

% corr_offset = [ (ypeak-size(template,1)) (xpeak-size(template,2)) ];
% isequal(corr_offset,offset)

D((ypeak-10):(ypeak+10),(xpeak-10):(xpeak+10))=0;
% figure,imshow(D);
% figure,surf(D);

% D((imax-x/2):(imax+x/2),(imax-y/2):(imax+y/2))=0;

% D(imax)=0;
E=D;
[max_cc2, imax2] = max(E(:));
[ypeak2, xpeak2] = ind2sub(size(E),imax2(1));
figure,surf(D)

figure, imshow(F);
hold on;
plot(xpeak,ypeak,'+');
hold on
plot(xpeak2,ypeak2,'+');

m = (ypeak2-ypeak)/(xpeak2-xpeak);
d = atand(m);
newface = imrotate(F,d,'crop');
figure,imshow(newface);
