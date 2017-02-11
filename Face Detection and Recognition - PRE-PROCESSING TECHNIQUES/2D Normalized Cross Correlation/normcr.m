clear all;close all;clc;

%% get a gaussian model

a=gaussian_filter(40,0.12,0.02);

% surf(a);

%% crop the image of 2d gaussian 

d=imcrop(a,[8 10 25 24]);

%% to disect the circle exactly

d(1:2,:)=0;
d(22:26,:)=0;

[x y]=size(d);

%% for orl

j = randperm(40,1);
k = randperm(10,1);          
F = imread(strcat('D:\workspace\mat2012b\Orl database\s',num2str(j),'\',num2str(k),'.pgm'));

%% gamma adjusted can be either 1/2 or 1/1.8

F=imadjust(F,[],[],1/2);

C = normxcorr2(d, F);
[m n]=size(F);
D=imresize(C,[m n]);


% figure, imshow(F),axis on
% figure,surf(D)
%% to find first peak

[max_cc, imax] = max(D(:));
[ypeak, xpeak] = ind2sub(size(D),imax(1));

% corr_offset = [ (ypeak-size(template,1)) (xpeak-size(template,2)) ];
% isequal(corr_offset,offset)

%% The first peak is removed out to detect the second peak

D((ypeak-10):(ypeak+10),(xpeak-10):(xpeak+10))=0;

% D((imax-x/2):(imax+x/2),(imax-y/2):(imax+y/2))=0;

% D(imax)=0;

%% The second peak detection assuming its a eye
E=D;
[max_cc2, imax2] = max(E(:));
[ypeak2, xpeak2] = ind2sub(size(E),imax2(1));
figure,surf(D)
%% plotting the eyes
figure, imshow(F);
hold on;
plot(xpeak,ypeak,'+');
hold on
plot(xpeak2,ypeak2,'+');
% corr_offset = [ (ypeak-size(template,1)) (xpeak-size(template,2)) ];
% isequal(corr_offset,offset) % 1 means offset was recovered