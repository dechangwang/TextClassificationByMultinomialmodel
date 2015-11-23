function [clfresult,accuracyrate,p] = bayesclassifier(samples,dimen,sum,sd,mode1,model2)

clfresult=zeros(dimen,2);
if ((mode1(1,1)~=0)&&(mode1(1,2)~=0)&&(mode1(1,3)==0))
    compareN=[1,2];
end
if ((mode1(1,1)~=0)&&(mode1(1,2)==0)&&(mode1(1,3)~=0))
    compareN=[1,3];
end
if ((mode1(1,1)==0)&&(mode1(1,2)~=0)&&(mode1(1,3)~=0))
    compareN=[2,3];
end
compare1=compareN(1,1);
compare2=compareN(1,2);
class=zeros(1,3);
la=zeros(1,4);
lb=zeros(1,4);
for i=1:1:dimen
if samples(i,5)==1
    class(1,1)=class(1,1)+1;
end
if samples(i,5)==2
    class(1,2)=class(1,2)+1; 
end
if samples(i,5)==3
    class(1,3)=class(1,3)+1;
end
end
n=class(1,compare2)/class(1,compare1);
for i=1:1:dimen
la(1,1)=1/sqrt(sd(compare1,1))*exp(-(samples(i,1)-sum(compare1,1))^2/(2*sd(compare1,1)));
la(1,2)=1/sqrt(sd(compare1,2))*exp(-(samples(i,2)-sum(compare1,2))^2/(2*sd(compare1,2)));
la(1,3)=1/sqrt(sd(compare1,3))*exp(-(samples(i,3)-sum(compare1,3))^2/(2*sd(compare1,3)));
la(1,4)=1/sqrt(sd(compare1,4))*exp(-(samples(i,4)-sum(compare1,4))^2/(2*sd(compare1,4)));
lb(1,1)=1/sqrt(sd(compare2,1))*exp(-(samples(i,1)-sum(compare2,1))^2/(2*sd(compare2,1)));
lb(1,2)=1/sqrt(sd(compare2,2))*exp(-(samples(i,2)-sum(compare2,2))^2/(2*sd(compare2,2)));
lb(1,3)=1/sqrt(sd(compare2,3))*exp(-(samples(i,3)-sum(compare2,3))^2/(2*sd(compare2,3)));
lb(1,4)=1/sqrt(sd(compare2,4))*exp(-(samples(i,4)-sum(compare2,4))^2/(2*sd(compare2,4)));
for j=1:1:4
    if(model2(1,j)==0)
        la(1,j)=1;
        lb(1,j)=1;
    end
end
lx=la(1,1)*la(1,2)*la(1,3)*la(1,4)/(lb(1,1)*lb(1,2)*lb(1,3)*lb(1,4));
clfresult(i,1)=i;
clfresult(i,3)=samples(i,5);


if lx>=n
    clfresult(i,2)=compare1;
else
    clfresult(i,2)=compare2;
end

end
accuracyrate=0;
for i=1:1:dimen
if clfresult(i,2)==samples(i,5)
    accuracyrate=accuracyrate+1;
end
end

p=0;
for i=1:1:20
if clfresult(i,2)==samples(i,5)
    p=p+1;
end
end
%clfresult=clfresult';
accuracyrate=accuracyrate/dimen;
p=p/20;

distance=[];
for i = 1:dimen
    if i<=50
        temp = sqrt((samples(i,3)-sum(1,3))^2+(samples(i,4)-sum(1,4))^2);
        distance=[distance;temp];
    elseif i<=100
        temp = sqrt((samples(i,3)-sum(2,3))^2+(samples(i,4)-sum(2,4))^2);
        distance=[distance;temp];
    else
        temp = sqrt((samples(i,3)-sum(3,3))^2+(samples(i,4)-sum(3,4))^2);
        distance=[distance;temp];
    end
end

hold on;
%plot(samples(1:50,3),samples(1:50,4),'r.');
plot(samples(1:50,3),samples(1:50,4),'o','MarkerFaceColor','r');
hold on;
%plot(sum(1,3),sum(1,4),'d');

maxD = max(distance(1:50,1));
minD = min(distance(1:50,1));
space = (maxD-minD)/10;
for i = minD:space:maxD
    circle(i,sum(1,3),sum(1,4));
end
hold on;
%plot(samples(51:100,3),samples(51:100,4),'g.');
plot(samples(51:100,3),samples(51:100,4),'o','MarkerFaceColor','g');
maxD = max(distance(51:100,1));
minD = min(distance(51:100,1));
space = (maxD-minD)/10;
for i = minD:space:maxD
    circle(i,sum(2,3),sum(2,4));
end


hold on;
%plot(samples(101:150,3),samples(101:150,4),'b.');
plot(samples(101:150,3),samples(101:150,4),'o','MarkerFaceColor','b');
maxD = max(distance(101:150,1));
minD = min(distance(101:150,1));
space = (maxD-minD)/10;
for i = minD:space:maxD
    circle(i,sum(3,3),sum(3,4));
end
end

