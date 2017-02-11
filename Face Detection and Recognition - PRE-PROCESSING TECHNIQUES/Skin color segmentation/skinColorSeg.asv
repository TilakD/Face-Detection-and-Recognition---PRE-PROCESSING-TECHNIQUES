

% normxcorr2

clc,clear all,close all
%I=imread('C:\Users\PRASHANTH-GL\Desktop\DATABASES\FERET\s14\1.ppm');

I=imread('group-buy.jpg');
iii=I;
% g = graythresh(I);
% G = im2bw(I,g);
% figure,imshow(G);

I=colorBalance(I);
figure,imshow(I);
T1=[16.0; 128.0; 128.0];
T2=[65.481 128.553 24.966; -81.085 112 -30.915; 112 -93.786 -18.214];
I=im2double(I);
for i=1:size(I,1)
    for j=1:size(I,2)
        
        T3=[T2]*[I(i,j,1); I(i,j,2); I(i,j,3)];
        [y]=T1+T3;
        
        y1(i,j)=y(1,1);
        cg1(i,j)=y(2,1);
        cr1(i,j)=y(3,1);
        
    end
end

I2=rgb2hsv(I);
BW1=zeros(size(I,1),size(I,2));
BW2=zeros(size(I,1),size(I,2));

for i=1:size(I,1)
    for j=1:size(I,2)
        if((y1(i,j)>80)&&((cg1(i,j)>100)&&(cg1(i,j)<130))&&((cr1(i,j)>135)&&(cr1(i,j)<175)))
            BW1(i,j)=1;
        else
            BW1(i,j)=0;
        end
    end
end
figure,imshow(BW1);
I1=rgb2gray(I).*BW1;
% figure,imshow(I1);
%%
% BW4=im2bw(BW1,.6);
%  figure,imshow(BW4);
%
% binaryImage = imfill(BW4, 'holes');
% figure, imshow(binaryImage);
%%
for i=1:size(I,1)
    for j=1:size(I,2)
        if I2(i,j,1)>.05 && I2(i,j,1)<.9412
            BW2(i,j)=1;
        else
            BW2(i,j)=0;
        end
    end
end

% figure,imshow(BW2);
I2=rgb2gray(I).*BW2;
% figure,imshow(I2);
BW3=BW1 & BW2;
% figure,imshow(BW3);

I3=rgb2gray(I).*BW3;
% figure,imshow(I3);

% BW4=im2bw(BW3,.6);
% figure,imshow(BW4);

binaryImage = imfill(BW3, 'holes');
figure, imshow(binaryImage);


binaryImage = bwareaopen(binaryImage,1890);
figure,imshow(binaryImage);
labeledImage = bwlabel(binaryImage, 8);
blobMeasurements = regionprops(labeledImage, BW3, 'all');
numberOfPeople = size(blobMeasurements, 1)
imagesc(iii); title('Outlines, from bwboundaries()');
%axis square;
hold on;
boundaries = bwboundaries(binaryImage);
for k = 1 : numberOfPeople
    thisBoundary = boundaries{k};
    plot(thisBoundary(:,2), thisBoundary(:,1), 'g', 'LineWidth', 2);
end
% hold off;


imagesc(iii);
hold on;
title('Original with bounding boxes');
%fprintf(1,'Blob # x1 x2 y1 y2\n');
for k = 1 : numberOfPeople 
   
    thisBlobsBox = blobMeasurements(k).BoundingBox; 
    x1 = thisBlobsBox(1);
    y1 = thisBlobsBox(2);
    x2 = x1 + thisBlobsBox(3);
    y2 = y1 + thisBlobsBox(4);
    
    
    % fprintf(1,'#%d %.1f %.1f %.1f %.1f\n', k, x1, x2, y1, y2);
    x = [x1 x2 x2 x1 x1];
    y = [y1 y1 y2 y2 y1];
    %subplot(3,4,2);
    plot(x, y, 'LineWidth', 2);
    
    
    
    %figure, imshow(labeledImage);
    %B = bwboundaries(binaryImage);
    %imshow(B);
    %text(10,10,strcat('\color{green}Objects Found:',num2str(length(B))))
    %hold on
    %for k = 1:length(B)
    %boundary = B{k};
    %plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 0.2)
    %end
end