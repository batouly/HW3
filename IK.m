function q=IK(T,d1,a2)
Pos=T(1:3,4); 

r=sqrt(Pos(1)^2+Pos(2)^2);
s=d1-Pos(3);
d3=sqrt(r^2+s^2)-a2;

q11=atan2(Pos(2),Pos(1));
q12=pi+atan2(Pos(2),Pos(1));

q31=d3;
q32=-d3-2*a2;

q21=atan2(s,r);
q22=atan2(s,-r);
q23=atan2(-s,-r);
q24=atan2(-s,r);

q=[q11 q21 q31 ;
    q12 q22 q31 ;
    q11 q23 q32;
    q12 q24 q32];
end