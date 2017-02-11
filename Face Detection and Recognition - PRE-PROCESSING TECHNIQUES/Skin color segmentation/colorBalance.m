function out = colorBalance(I)
%Color Balancing using the Gray World Assumption
% to compensate the images with bad light interference
%   I - 24 bit RGB Image
%   out - Color Balanced 24-bit RGB Image
%
%   Gaurav Jain, 2010.

    out = uint8(zeros(size(I,1), size(I,2), size(I,3)));
    
    %R,G,B components of the input image
    R = I(:,:,1);
    G = I(:,:,2);
    B = I(:,:,3);

    %Inverse of the Avg values of the R,G,B
    mR = (mean(mean(R)));
    mG = (mean(mean(G)));
    mB = (mean(mean(B)));
    
    k=(mR+mG+mB)/3;
    
    %Calculate the scaling factors
    mR = k/mR;
    mG = k/mG;
    mB = k/mB;
   
    %Scale the values
     out(:,:,1) = R*mR;
     out(:,:,2) = G*mG;
     out(:,:,3) = B*mB;
end