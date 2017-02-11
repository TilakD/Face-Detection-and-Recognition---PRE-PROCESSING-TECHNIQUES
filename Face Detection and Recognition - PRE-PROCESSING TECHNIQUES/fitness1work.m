function fit=fitness1work(position,classnum,totsize)
global classmeanarray totalmeanarray
for i=1:totsize
    modct(i)=double(position(i)).*double(totalmeanarray(i));
end
sum=0;
for i=1:classnum
   str = int2str(i);
       for j=1:totsize
        midct(j)=double(position(j)).*double(classmeanarray{i}(j));
   end
    diff=abs(midct-modct);
    tpose=diff';
    mul=mtimes(diff,tpose);
    sum=double(sum)+double(mul);
end
 fit=sqrt(sum);
