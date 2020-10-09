function test_IK(T)
d1=20;
a2=10;
q=IK(T,d1,a2);
%q=[pi/3 pi/6 10];
if (sin(q(2))==1)||(sin(q(2))==-1)
    disp('singularity')
else
 T=FK(q,d1,a2)
 disp('solutions')
 q=IK(T,d1,a2)
 disp('substituting 1st solution') 
 T=FK(q(1,:),d1,a2)
 disp('substituting 2nd solution')
 T=FK(q(2,:),d1,a2)
  disp('substituting 3rd solution') 
 T=FK(q(3,:),d1,a2)
 disp('substituting 4th solution') 
T=FK(q(4,:),d1,a2)
end