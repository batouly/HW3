function T=FK(q,d1,a2)
T=Tz(d1)*Rz(q(1))*Ry(q(2))*Tx(a2+q(3));
end