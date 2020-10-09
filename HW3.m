clear; clc;
d1=20;
a2=10;
 syms q1 q2 q3
 q = sym('q',[1 3]);
 T=FK(q,d1,a2) ;
% Geometrical Jacobian
disp('Geometrical Method')
O0 = [0 0 0]';
z0 = [0 0 1]';
O=T(1:3,4);
R2=T(1:3,1:3);
T1=Tz(d1)*Rz(q1);
O1=T1(1:3,4);
R1=T1(1:3,1:3);
z1 = R1*[0 1 0]';
z2 = R2*[1 0 0]';

% The first joint (revolute)
Jv1 = cross(z0, O - O0);
Jw1 = z0;

% The second joint (revolute)
Jv2 = cross(z1, O - O1);
Jw2 = z1;

% The third joint (prismatic)
Jv3 = z2;
Jw3 = 0;
Jv = simplify([Jv1, Jv2, Jv3]);
Jw = simplify([Jw1, Jw2, Jw3]);
Jg = [Jv; Jw]

disp('determinant:')
D=simplify(det(Jv))
 
%Analytical Jacobian
 disp('Analytical Method')
 f=T(1:3,4);
 Jv = [diff(f,q1), diff(f,q2), diff(f,q3)];
 Ja = [Jv; Jw]
 
%Numerical derivatives 
disp('Numerical Method')
R=T(1:3,1:3);
j1=Tz(d1)*Rzd(q1)*Ry(q2)*Tx(a2+q3)*[inv(R) zeros(3,1); 0 0 0 1];
j1=simplify(j1);
J1=[j1(1,4);j1(2,4);j1(3,4);j1(3,2);j1(1,3);j1(2,1)];
j2=Tz(d1)*Rz(q1)*Ryd(q2)*Tx(a2+q3)*[inv(R) zeros(3,1); 0 0 0 1];
j2=simplify(j2);
J2=[j2(1,4);j2(2,4);j2(3,4);j2(3,2);j2(1,3);j2(2,1)];
j3=Tz(d1)*Rz(q1)*Ry(q2)*Txd(a2+q3)*[inv(R) zeros(3,1); 0 0 0 1];
j3=simplify(j3);
J3=[j3(1,4);j3(2,4);j3(3,4);j3(3,2);j3(1,3);j3(2,1)];
Jn=[J1 J2 J3]
dif=Ja-Jn
dif=Jn-Jg
dif=Ja-Jg

% Plot velosities

syms t q1_t q2_t q3_t real

q1_t = sin(t);
q2_t = cos(2*t);
q3_t = sin(3*t);

J_time = simplify(subs(Jn, {q1, q2, q3}, {q1_t, q2_t, q3_t}));

q = [q1_t q2_t q3_t]';
qdot = diff(q);

xi = simplify(J_time * qdot);

time = 0:0.01:10;
xi_time = subs(xi, {t}, {time});

fig = figure(1);
set(gcf,'color','w');
plot(time, xi_time(1:3, :), 'LineWidth', 2)
grid on
xlabel('Time')
ylabel('Velocity value')
title('Linear velocity plot')
legend('v_x', 'v_y', 'v_z', 'Fontsize', 14)


fig = figure(2);
set(gcf,'color','w');
plot(time, xi_time(4:6, :), 'LineWidth', 2)
grid on
xlabel('Time')
ylabel('Velocity value')
title('Angular velocity plot')
legend('\omega_x', '\omega_y', '\omega_z', 'Fontsize', 14)


