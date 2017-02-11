function [ Output ] = adapt_gamma( Input )

%% edit for rgb images

if(size(Input,3)==3)
    I=rgb2gray(Input);
else
    
    I=Input;
end
% figure,imhist(I);
hg=imhist(I);

%% take second peak

k=find(max(hg)==hg);

hg(k)=0;

k1=find(max(hg)==hg);

count=0;
%% thresholded to get the peak in the region specified
while((k1<120 || k1>140) && count <25)
    
    count=count+1;
%     counter=0;
    % for i=1:20
    %    if(hg(k1+i)>500)
    %        counter=counter+1;
    %    end
    %    if(hg(k1-i)>500)
    %        counter=counter+1;
    %    end
    % end
    
    if(k1<128)
        
        I=imadjust(I,[],[],0.5-(count/50));
        
    end
    
    if(k1>128)
        
        I=imadjust(I,[],[],1.5+(count/25));
        
    end
    hg=imhist(I);
    
    k=find(max(hg)==hg);
    hg(k)=0;
    k1=find(max(hg)==hg);
    
end
% figure,imhist(I);
Output=I;
end

