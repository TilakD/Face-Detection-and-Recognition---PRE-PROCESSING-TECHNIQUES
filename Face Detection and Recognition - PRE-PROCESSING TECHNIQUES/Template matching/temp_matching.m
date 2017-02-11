clc;
clear all
close all

%% Prepare the image for analysis

j = randperm(40,1);
k = randperm(10,1);
F = imread('Cyclone_big.png');  %4,5,7,8
T = imread('171.jpg'); % read template image
%         end
% end
%% display frame and template
figure, subplot(2,2,1),imshow(F),title('Sample Image');
subplot(2,2,2),imshow(T),title('Eye Template');
%% correlation matching
[corrScore, boundingBox] = corrMatching(F,T,0.5);
%% show results
% figure,imagesc(abs(corrScore)),axis image, axis off, colorbar,
% title('Corr Measurement Space')

bY = [boundingBox(1),boundingBox(1)+boundingBox(3),boundingBox(1)+boundingBox(3),boundingBox(1),boundingBox(1)];
bX = [boundingBox(2),boundingBox(2),boundingBox(2)+boundingBox(4),boundingBox(2)+boundingBox(4),boundingBox(2)];
subplot(2,2,3:4),imshow(F),line(bX,bY),title('Detected Area');