function circle(R,i,j)
alpha=0:pi/50:2*pi;%�Ƕ�[0,2*pi] 
%R=2;%�뾶 
x=R*cos(alpha); 
y=R*sin(alpha); 
plot(x+i,y+j,'-') 
axis equal 
