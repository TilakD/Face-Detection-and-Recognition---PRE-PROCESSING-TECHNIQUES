%87 for bior and haar
%88 for haar

clear all
clc
close all
global classmeanarray totalmeanarray GlobalBestP;
%% Generalised Variables
countsum=0;
percentsum=0;
DatbNumber=2;  %input('Please specify the number corresponding to database:\n1 for ORL ,\n2 for FERET,\n3 for ExtYaleB \n');%ORL for orl database,FERET for FERET database,ExtYaleB for ExtYaleB database
%1 for ORL ,2 for FERET,3 for ExtYaleB
WLetNo= 1; %input('Please specify the number corresponding to required wavelet to be applied:\n1-db1,\n2-db4,\n3-sym4,\n4-bior1.3,\n5-rbio1.3,\n6-coif1\n');                              %1-db1,2-db4,3-sym4,4-bior1.3,5-rbio1.3,6-coif1
TotNoIter=6 ; %input('Number of iterations please: ');%Total no of iterations

switch DatbNumber
    case 1                               %For ORL
        switch WLetNo
            case 1
                ImgSize=[1 322];
                WLet='db1';
            case 2
                ImgSize=[1 322];
                WLet='db4';
            case 3
                ImgSize=[1 322];
                WLet='sym4';
            case 4
                ImgSize=[1 322];
                WLet='bior1.3';
            case 5
                ImgSize=[1 322];
                WLet='rbio1.3';
            case 6
                ImgSize=[1 322];
                WLet='coif1';
        end
        Formt='.pgm';                   %Format of images
        TClasses=40;                    %Total number of distinct classes
        TImgPerClass=10;                %Total images per class
        NoOfTrImg=4;                    %No of training images per class
        locstr='ORL\s';
    case 2                              %For FERET
        switch WLetNo
            case 1
                ImgSize=[1 192];
                DctSize=[1 384];
                WLet='haar';
            case 2
                ImgSize=[1 384];
                WLet='db4';
            case 3
                ImgSize=[1 384];
                DctSize=[1 192];
                WLet='sym4';
            case 4
                ImgSize=[1 384];
                DctSize=[1 192];                
                WLet='bior1.3';
            case 5
                ImgSize=[1 384];
                DctSize=[1 192];
                WLet='rbio1.3';
            case 6
                ImgSize=[1 192];
                DctSize=[1 192];
                WLet='coif1';
        end
        TClasses=35;
        Formt='.ppm';
        TImgPerClass=20;
        NoOfTrImg=8;
        locstr='C:\Users\Tilak\Documents\MATLAB\IMAGE_DATABASE\Color FERET Custom\s'; %'C:\Users\PRASHANTH-GL\Desktop\M-codes\DWT1\s'; 
end
TTrImg=NoOfTrImg*TClasses;              %Total Training images
XDct=DctSize(1); YDct=DctSize(2); TDctSize=XDct*YDct;


for NoOfTimes=1:TotNoIter
    tic
    TTotal=zeros(DctSize(1),DctSize(2));
    k=1;
    for TotClasses=1:TClasses
        b{TotClasses}=randperm(TImgPerClass,NoOfTrImg);
        TSum=zeros(DctSize(1),DctSize(2));
        for TotTrImg = 1:NoOfTrImg
            FacRead=imread(strcat(locstr,num2str(TotClasses),'\',num2str(b{TotClasses}(TotTrImg)),Formt));
            FacRead=imadjust(FacRead,[],[],1/1.8);
            h = fspecial('gaussian', 10,3);
            FacRead=imfilter(FacRead,h);
%            FacRead=imresize(FacRead,.25,'bicubic');
%            FacRead=impyramid(FacRead,'reduce');
%            FacRead=impyramid(FacRead,'reduce');

            if  DatbNumber==2     %For FERET images
                %                 FacRead=impyramid(FacRead,'reduce');
                FacRead=rgb2gray(FacRead);
                FacRead=reshape(FacRead',1,384*256);
            end
            FacRead=double(FacRead);
            
            [aa, dd]=dwt(FacRead,'db1');
            for ii=1:7
                [aa dd]=dwt(aa,'db1');
            end
            DctToFace=dct2(aa);
            %             FinDctMat=DctToFace(1:XDct,1:YDct);
            FaceGal{k}=reshape(DctToFace,1,TDctSize);
            k=k+1;
            TSum=double(TSum)+double(DctToFace);
            TTotal=double(TTotal)+double(DctToFace);
        end
        
        
        Avg=(TSum./NoOfTrImg);
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
    MaxIterations = 30;
    C2 = 1.618;
    C1 = .618;
    
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
            Particles{p}.Velocity = 3.4* Particles{p}.Velocity* ((((MaxIterations-p)*(InerMax-InerMin))/MaxIterations)+InerMin)+ ...
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
    
    Count=0;opti=0;
    for q=1:TDctSize
        if GlobalBestP(q)==1
            Count=Count+1;
            opti(Count)=q;
        end
    end
    disp('The number of selected features');
    disp(Count);
    temp(NoOfTimes)=Count;
    
    for t= 1:TTrImg
        FaceGallery{t}(1:TDctSize)=0;
        for bpopti=1:Count
            
            FaceGallery{t}(opti(bpopti))= FaceGal{t}(opti(bpopti)).*GlobalBestP(opti(bpopti));
            FaceGallery_size{t}(bpopti)=FaceGallery{t}((opti(bpopti)));
            
        end
    end
    clear FaceGal
    %% Recognition of images
    TrainingTime(NoOfTimes)=toc;
    tic
    rec=0;
    tests=TClasses*(TImgPerClass-NoOfTrImg);
    for n=1:tests
        c{n}=randperm(TClasses,1);
        b2=[1:TImgPerClass];
        b1=setdiff(b2,b{c{n}});
        Testimg=imread(strcat(locstr,num2str(c{n}),'\',num2str(randsample(b1,1)),Formt));
        Testimg=imadjust(Testimg,[],[],1/1.8);
        h = fspecial('gaussian', 10,3);
        Testimg=imfilter(Testimg,h);
        %         Testimg=rgb2gray(Testimg);
        %         Testimg=im2double(Testimg);
        %         Testimg=fft2(Testimg);
        %         Testimg=fftshift(Testimg);
        %         Testimg=impyramid(Testimg,'reduce');
%         Testimg=imresize(Testimg,.25,'bicubic');
%         Testimg=impyramid(Testimg,'reduce');
%         Testimg=impyramid(Testimg,'reduce');
        
        imshow(Testimg);
        if DatbNumber==1
            Testimg=reshape(Testimg',1,2576);
        end
        if  DatbNumber==2     %For FERET images
            %             Testimg=impyramid(Testimg,'reduce');
            Testimg=rgb2gray(Testimg);
            Testimg=reshape(Testimg',1,384*256);
        end
        Testimg=double(Testimg);
        [aa dd]=dwt(Testimg,'db1');
        for i=1:7
            %         [aa dd]=dwt(aa,'db1');
            [aa dd]=dwt(aa,'db1');
        end
        
        [XS YS]=size(aa);
        Pic_dct=reshape(aa,1,(XS*YS));
        %         aa=Testimg(20:75,15:55);
        %                     aa=ifft2(ifftshift(aa));
        
        DctTstImg=dct2(aa);
        Pic_dct=reshape(DctTstImg(1:XDct,1:YDct),1,TDctSize);
        
        %         pict_dct=reshape(TstImgGal,XDct,YDct);
        
        TstImgGal=Pic_dct.*GlobalBestP;
        
        for bpopti=1:Count
            TstImgGal(bpopti)=Pic_dct(opti(bpopti));
        end
        d=zeros(1,TTrImg);
        for p=1:TTrImg
            for bpopti=1:Count
                d(p)=d(p)+((TstImgGal(bpopti)-FaceGallery_size{p}(bpopti)).^2);
            end
            d(p)=sqrt(d(p));
        end
        [val,index]=min(d);
        if((ceil(index/NoOfTrImg))==c{n})
            rec=rec+1;
        end
    end
    TestingTime(NoOfTimes)=toc;
    disp('The recognition rate');
    percent=(rec/tests)*100;
    disp(percent);
    percentsum(NoOfTimes)=percent;
    
end
disp('Average number of selected features =')
disp(sum(temp)/max(NoOfTimes));
disp('Average Recognition Rate:')
disp(sum(percentsum)/max(NoOfTimes));
disp('testing time');
disp(sum(TestingTime)/( max(NoOfTimes)*tests));
disp('training time')
disp(sum(TrainingTime)/( max(NoOfTimes)*TClasses* NoOfTrImg));
disp('size of face gallery before bpso in bytes')
disp(TDctSize)
disp('size of face gallery after bpso in bytes')
disp(ceil(sum(temp)/max(NoOfTimes)))

