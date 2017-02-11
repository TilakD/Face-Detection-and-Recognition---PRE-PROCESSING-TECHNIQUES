aa=imread('D:\workspace\nitin database\New folder\FERET\s1\3.ppm');
aa=rgb2gray(aa);
 for po=1:2
                jh=dct2(aa);
                is1=idct2(jh);
                aa=(uint8(jh)+aa)./2 ;
                
 end 
 as=dct2(aa);
 image(as);
 
 % i am able to see the image face in above image i.e in freq domain
 
 %% dwt to the freq domain dct signal
 
 [a,h,v,d]=dwt2(as,'db1');
 imshow(([a,h,v,d]));
 
 %% swt to freq domain
 
 [a1,h1,v1,d1]=swt2(as,7,'db1');
 imshow([[a1,h1,v1,d1]]);