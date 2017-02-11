%%enter ORL for orl database , FERET for feret database and ExtYaleB for
%%extended yale b database
%%consistently 77% for coif1 and approximately 822 features getting
%%selected and for nothing also

clear all
clc
close all
global classmeanarray totalmeanarray GlobalBestP;
%% Generalised Variables
FTrue=0;
countsum=0;
percentsum=0;
Database='FERET';                         % ORL for orl database,FERET for FERET database,ExtYaleB for ExtYaleB database
locstr='C:\Users\Tilak\Documents\MATLAB\IMAGE_DATABASE\Color FERET Custom\s'; %Location
TotNoIter=10;                            %Total no of iterations
if strcmp(Database, 'FERET')
    ImgSize=[30 20];
    DctSize=[30 20];
    TClasses=35;
    Formt='.ppm';
    TImgPerClass=20;
    NoOfTrImg=8;
    FTrue=1;
end
TTrImg=NoOfTrImg*TClasses;              %Total Training images
XDct=DctSize(1); YDct=DctSize(2); TDctSize=XDct*YDct;

%%Training
tic
for NoOfTimes=1:TotNoIter
    TTotal=zeros(ImgSize(1),ImgSize(2));
    k=1;
    for TotClasses=1:TClasses
        b{TotClasses}=randperm(TImgPerClass,NoOfTrImg);
        TSum=zeros(ImgSize(1),ImgSize(2));
        for TotTrImg = 1:NoOfTrImg
            FacRead=imread(strcat(locstr,num2str(TotClasses),'\',num2str(b{TotClasses}(TotTrImg)),Formt));
            FacRead=1.618.*(FacRead);
            %             FacRead=rgb2gray(FacRead);
            %             FacRead=(FacRead+fliplr(FacRead(:,:)))./2;
            %             H = fspecial('motion',10,0);
            %             MotionBlur = imfilter(FacRead,H,'replicate');
            %             H = fspecial('motion',10,90);
            %             MotionBlur = imfilter(MotionBlur,H,'replicate');
            %             H = fspecial('motion',10,270);
            %             MotionBlur = imfilter(MotionBlur,H,'replicate');
            %             H = fspecial('motion',10,180);
            %             MotionBlur = imfilter(MotionBlur,H,'replicate');
            %             FacRead = MotionBlur;
            % figure,imshow(mat2gray(FacRead));
            %  FacRead(:,50:200,:)=[];
            
            %   imshow(FacRead);
            % FacRead=rgb2gray(FacRead);
            % FacRead=imresize(FacRead,[min(size(FacRead,1),size(FacRead,2)),min(size(FacRead,1),size(FacRead,2))]);
            % FacRead=(FacRead+imrotate(FacRead,90)+imrotate(FacRead))./2;
            %imshow(FacRead);
            % FacRead=optimiser(FacRead);
            %             FacRead=fft2(FacRead);
            %             FacRead=fftshift(FacRead);
            %             FacRead=ifft2(FacRead);
            %  FacRead=rgb2gray(FacRead);
            % %% dct as pre-processing
            % % figure,imshow(I);
            % s=dct2(FacRead);                   %dont apply after im2double
            % %figure,image(s);
            % d=idct2(s);
            % %figure,image(uint8(d));
            % d=uint8(d);
            % a=(uint8(d)+FacRead)./2;
            % %figure,imshow(a);
            % f=dct2(a);
            % %figure,image(f);             % the dimensions decreases
            % h=idct2(f);
            % %figure,image(h);
            % FacRead1=(uint8(h)+a)./2;
            % s1=dct2(FacRead1);
            % d1=idct2(s1);
            % FacRead2=(uint8(d1)+FacRead1)./2;
            %
            % s2=dct2(FacRead2);
            % d2=idct2(s2);
            % FacRead3=(uint8(d2)+FacRead2)./2;
            %
            % s3=dct2(FacRead3);
            % d3=idct2(s3);
            % FacRead=(uint8(d3)+FacRead3)./2;
            % %imshow(FacRead);
            %  FacRead=rgb2gray(FacRead);
            %   s=dct2(FacRead);                   %dont apply after im2double
            % % figure,image(s);
            % d=idct2(s);
            % % figure,image(d);
            % d=uint8(d);
            % a=(3*(d)+FacRead);
            
            FacRead=imadjust(FacRead,[],[],1/1.8);
            h = fspecial('gaussian', 10,3);
            FacRead=imfilter(FacRead,h);
            %   FacRead = imnoise(FacRead,'salt & pepper');
            %             FacRead=background_remove(FacRead);
            FacRead=impyramid(FacRead,'reduce');
            if FTrue==1;    %For FERET images
                %                 FacRead=impyramid(FacRead,'reduce');
                FacRead=rgb2gray(FacRead);
            end
            % FacRead=histeq(FacRead);
            %             [aa bb cc dd]=dwt2(FacRead,'coif1');
            %              [aa bb cc dd]=dwt2(aa,'coif1');
            %            imshow(mat2gray(aa));
            % aa=fft2(aa);
            % image(abs(aa));
            % %ab=(fftshift(aa));
            % %image(abs(ab));
            % aa=aa(15:40,10:30);
            % image(abs(aa));
            % k1=ifft2(aa);
            % image(abs(k1));
            aa=FacRead;
            %aa=histeq(aa);
            for po=1:2
                jh=dct2(aa);
                is1=idct2(jh);
                aa=(uint8(jh)+aa)./2 ;
            end
            
            DctToFace=dct2(aa);
            %             figure,imshow(FacRead);
            %              figure, image(DctToFace);
            % figure,mesh(DctToFace);
            % [a1,b1,c1,d1]=dwt2(DctToFace,'db1');
            % % figure,imshow(([a1,b1,c1,d1]));
            %  DctToFace=dct2(a1);
            %figure,image(DctToFace);
            FinDctMat=DctToFace(1:XDct,1:YDct);
            FaceGal{k}=reshape(FinDctMat,1,TDctSize);
            k=k+1;
            TSum=double(TSum)+double(FinDctMat);
            TTotal=double(TSum)+double(FinDctMat);
        end
        
        
        Avg=(TSum./NoOfTrImg);
        % image(Avg);
        %         a=idct2(Avg);
        %         figure,imshow(mat2gray(a));
        %         nop
        
        %      a=imresize(a,[100,100],'bicubic');
        %    imwrite(mat2gray(a),strcat('D:\workspace\mat2012b\30-3-13\FERET4\',num2str(TotClasses),'.pgm'));
        %% blur
        %          H = fspecial('motion',10,0);
        %             MotionBlur = imfilter(a,H,'replicate');
        %             H = fspecial('motion',10,90);
        %             MotionBlur = imfilter(MotionBlur,H,'replicate');
        %             H = fspecial('motion',10,270);
        %             MotionBlur = imfilter(MotionBlur,H,'replicate');
        %             H = fspecial('motion',10,180);
        %             MotionBlur = imfilter(MotionBlur,H,'replicate');
        %             a = MotionBlur;
        %         figure,imshow(mat2gray(a));
        %         nop
        %
        
        
        
        
        
        
        
        classmeanarray{TotClasses}=reshape(Avg(1:XDct,1:YDct),1,TDctSize);
    end
    TotAvg=TTotal./TTrImg;
    totalmeanarray=reshape(TotAvg(1:XDct,1:YDct),1,TDctSize);
    
    
    
    %% Initialization of Parameters
    
    NumofParticles = 30;
    NPar = TDctSize; % Number of Optimization Parameters
    FitFn='fitness1work';
    GlobalBestP = rand(1,NPar); % Global Best Position
    GlobalBestC = 0; % Global Best Cost
    MaxIterations = 10;
    C1 = 0.618;
    C2 = 1.618;
    InerMax        = 0.9;
    InerMin        = 0.4;
    %% Particles initialization
    
    for m = 1:NumofParticles
        Particles{m}.Velocity = (rand(1,NPar));
        R = rand(1,NPar);
        Particles{m}.Position = R < .5618./(1 + exp(-Particles{m}.Velocity));
        Particles{m}.Cost = feval(FitFn,Particles{m}.Position,TClasses,NPar);
        Particles{m}.LocalBestPosition = Particles{m}.Position;
        Particles{m}.LocalBestCost = Particles{m}.Cost;
        
        if Particles{m}.Cost > GlobalBestC
            GlobalBestP = Particles{m}.Position;
            GlobalBestC = Particles{m}.Cost;
        end
    end
    %% Main loop
    
    for t = 1:MaxIterations
        for p = 1:NumofParticles
            r1 = rand(1,NPar);
            r2 = rand(1,NPar);
            w = rand(1,NPar);
            Particles{p}.Velocity =  3.4*Particles{p}.Velocity* ((((MaxIterations-p)*(InerMax-InerMin))/MaxIterations)+InerMin)+ ...
                r1*C1.*(Particles{p}.LocalBestPosition - Particles{p}.Position) + ...
                r2*C2.*(GlobalBestP - Particles{p}.Position);
            R = rand(1,NPar);
            Particles{p}.Position = R < .618./(1 + exp(-Particles{p}.Velocity));
            Particles{p}.Cost =feval(FitFn,Particles{p}.Position,TClasses,NPar);
            
            
            if Particles{p}.Cost > Particles{p}.LocalBestCost;
                Particles{p}.LocalBestPosition = Particles{p}.Position;
                Particles{p}.LocalBestCost = Particles{p}.Cost;
                if Particles{p}.Cost > GlobalBestC
                    GlobalBestP = Particles{p}.Position;
                    GlobalBestC = Particles{p}.Cost;
                end
            end
            
            
        end
        
    end
    
    %% Counting the number of features
    
    Count=0;
    for q=1:TDctSize
        if GlobalBestP(q)==1
            Count=Count+1;
        end
    end
    disp('The number of selected features');
    disp(Count);
    temp(NoOfTimes)=Count;
    
    for t= 1:TTrImg
        FaceGal{t}= FaceGal{t}.*GlobalBestP;
    end
    %% Recognition of images
    
    rec=0;
    tests=TClasses*(TImgPerClass-NoOfTrImg);
    for n=1:tests
        c{n}=randperm(TClasses,1);
        b2=[1:TImgPerClass];
        b1=setdiff(b2,b{c{n}});
        Testimg=imread(strcat(locstr,num2str(c{n}),'\',num2str(randsample(b1,1)),Formt));
        Testimg=1.618.*(Testimg);
        %         Testimg=rgb2gray(Testimg);
        %         Testimg=(Testimg+fliplr(Testimg(:,:)))./2;
        %  Testimg(:,50:200,:)=[];
        % Testimg=rgb2gray(Testimg);
        % Testimg=imresize(Testimg,[min(size(Testimg,1),size(Testimg,2)),min(size(Testimg,1),size(Testimg,2))]);
        % Testimg=(Testimg+imrotate(Testimg,90))./2;
        %         Testimg=optimiser(Testimg);
        %  Testimg=rgb2gray(Testimg);
        %         s=dct2(Testimg);                   %dont apply after im2double
        % % figure,image(s);
        % d=idct2(s);
        % % figure,image(d);
        % d=uint8(d);
        % a=(3*(d)+Testimg);
        
        %          FacRead=fft2(FacRead);
        %             FacRead=fftshift(FacRead);
        %             FacRead=ifft2(FacRead);
        %  Testimg=rgb2gray(Testimg);
        % s=dct2(Testimg);                   %dont apply after im2double
        % %figure,image(s);
        % d=idct2(s);
        % %figure,image(uint8(d));
        % d=uint8(d);
        % a=(uint8(d)+Testimg)./2;
        % %figure,imshow(a);
        % f=dct2(a);
        % %figure,image(f);             % the dimensions decreases
        % h=idct2(f);
        %figure,image(h);
        % Testimg1=(uint8(h)+a)./2;
        %
        % s1=dct2(Testimg1);
        % d1=idct2(s1);
        % Testimg2=(uint8(d1)+Testimg1)./2;
        %
        % s2=dct2(Testimg2);
        % d2=idct2(s2);
        % Testimg3=(uint8(d2)+Testimg2)./2;
        %
        % s3=dct2(Testimg3);
        % d3=idct2(s3);
        % Testimg=(uint8(d3)+Testimg3)./2;
        
        
        
        Testimg=imadjust(Testimg,[],[],1/1.8);
        h = fspecial('gaussian', 10,3);
        
        Testimg=imfilter(Testimg,h);
        %  Testimg = imnoise(Testimg,'salt & pepper');
        %         Testimg=background_remove(Testimg);
        Testimg=impyramid(Testimg,'reduce');
        if FTrue==1           %For FERET images
            %             Testimg=impyramid(Testimg,'reduce');
            Testimg=rgb2gray(Testimg);
        end
        %         imshow(Testimg);
        %         [aa bb cc dd]=dwt2(Testimg,'coif1');
        %              [aa bb cc dd]=dwt2(aa,'coif1');
        % %              imshow(aa)
        %
        aa=Testimg;
        for po=1:2
            jh=dct2(aa);
            is1=idct2(jh);
            aa=(uint8(jh)+aa)./2;
        end
        % aa=histeq(aa);
        DctTstImg=dct2(aa);
        Pic_dct=reshape(DctTstImg(1:XDct,1:YDct),1,TDctSize);
        TstImgGal=Pic_dct.*GlobalBestP;
        pict_dct=reshape(TstImgGal,XDct,YDct);
        
        d=zeros(1,TTrImg);
        for t=1:TTrImg
            r=FaceGal{t};
            image1(:,:,t)=reshape(r,XDct,YDct);
        end
        
        for p=1:TTrImg
            
            for TotTrImg=1:XDct
                for TotClasses=1:YDct
                    
                    d(p)=d(p)+((image1(TotTrImg,TotClasses,p) - pict_dct(TotTrImg,TotClasses) ).^2);
                end
            end
            d(p)=sqrt(d(p));
            
        end
        [val,index]=min(d);
        if((ceil(index/NoOfTrImg))==c{n})
            rec=rec+1;
        end
    end
    disp('The recognition rate');
    percent=(rec/tests)*100;
    disp(percent);
    percentsum(NoOfTimes)=percent;
end
disp('Average number of selected features =')
disp(sum(temp)/max(NoOfTimes));
disp('Average Recognition Rate:')
disp(sum(percentsum)/max(NoOfTimes));
toc
