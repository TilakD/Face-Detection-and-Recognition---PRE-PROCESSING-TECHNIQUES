function [ I ] = etch_background( I)

% I=imread('D:\workspace\nitin database\New folder\FERET\s1\12.ppm');
% figure,image(I);
edging=edge(rgb2gray(I),'sobel');
% figure,imshow(edging);


%% to remove background and any discontinities
count=1;
for i=1:floor(size(I,1))
    for j=1:floor(size(I,2)/3)   % scan one/third the image only
        if((edging(i,j))==1)
            lg(count)=i;
            
            if(count==1)
                I(1:(i-1),:)=0;
                I(i,1:(j-1),:)=0;
                count=count+1;
                break;
                
            else
                
                if(lg(count)~=(lg(count-1)+1))
                    for op=(lg(count-1)+1):(lg(count)-1)
                        I(op,1:(j-1),:)=0;
                    end
                    I(i,1:(j-1),:)=0; count=count+1;break;
                    
                else
                    
                    I(i,1:(j-1),:)=0;   count=count+1;break;
                    
                end
                
            end
            
            
            
            
        end
    end
end
% figure,image(I);
count1=1;
%% d as above for column wise
for i=1:floor(size(I,1))
    for j=1:floor(size(I,2)/3)
        if((edging(i,(size(I,2)-j)))==1)
            lg(count1)=i;
            
            if(count1==1)
                I(1:(i-1),:)=0;
                I(i,((size(I,2)-j)-1):size(I,2),:)=0;
                count1=count1+1;
                break;
                
            else
                
                if(lg(count1)~=(lg(count1-1)+1))
                    for op=(lg(count1-1)+1):(lg(count1)-1)
                        I(op,((size(I,2)-j)-1):size(I,2),:)=0;
                    end
                    I(i,((size(I,2)-j)-1):size(I,2),:)=0; count1=count1+1;break;
                    
                else
                    
                    I(i,((size(I,2)-j)-1):size(I,2),:)=0;   count1=count1+1;break;
                    
                end
                
            end
            
            
            
            
        end
    end
end
% figure,image(I);


end

