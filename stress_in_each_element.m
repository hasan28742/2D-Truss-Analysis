function z= stress_in_each_element (E,L,theta,U)
%Here U is the global displacement vector
t=theta*pi/180; %converting theta degree to radian
c=cos(t); %t is in radian angle value
s=sin(t);
z = E/L*[-c -s c s]*U;