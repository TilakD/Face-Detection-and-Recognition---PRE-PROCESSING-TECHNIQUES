function [ Mirrored ] = ImMirror( Image )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if(size(Image,3)==3)
    for i=1:3
        Mirrored(:,:,i)=fliplr(Image(:,:,i));
    end
else
    Mirrored=fliplr(Image);
end


end


%% another method

% Mirrored=flipdim(Image,2); % shift columns
