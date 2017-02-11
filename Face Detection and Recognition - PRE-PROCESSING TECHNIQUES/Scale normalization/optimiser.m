function [ ex ] = optimiser( Imag )
%% skin extractor
lk=size(Imag,1);
kl=size(Imag,2);
[~,bin]=skinner(Imag);

%% reduce the dImagmensImagon to get only skImagn

[row,col]=(find(bin==1));

%% row adjustment
mrow=max(row)+1;
counter=0;
while(counter~=25)
    counter=0;mrow=mrow-1;
    for i=1:25
        if(find(row==(mrow-i)))
            counter=counter+1;
        end
    end
end
mrow=mrow+1;
Imag(1:min(row),:,:)=[];
% Imagmage(Imag);
Imag(mrow-min(row)-50:size(Imag,1),:,:)=[];
% imshow(Imag);

%% column adjustment

mcol=max(col)+1;
counter=0;
while(counter~=25)
    counter=0;mcol=mcol-1;
    for i=1:25
        if(find(col==(mcol-i)))
            counter=counter+1;
        end
    end
end
mcol=mcol+1;

micol=min(col)+1;
counter=0;
while(counter~=25)
    counter=0;micol=micol+1;
    for i=1:25
        if(find(col==(micol+i)))
            counter=counter+1;
        end
    end
end
micol=micol+1;
Imag(:,1:micol,:)=[];
% Imagmage(Imag);
Imag(:,mcol-micol:size(Imag,2),:)=[];
% imshow(Imag)
%% resize it to last
ex(:,:,1)=imresize(Imag(:,:,1),[lk,kl]);
ex(:,:,2)=imresize(Imag(:,:,2),[lk,kl]);
ex(:,:,3)=imresize(Imag(:,:,3),[lk,kl]);
end

