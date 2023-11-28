%obtaining local stiffness matrix for each element
function x = local_stiffness_matrix(E,A,L,theta)
t=theta*pi/180; %converting theta degree to radian
c=cos(t); %t is in radian angle value
s=sin(t);
x=A*E/L *[c*c  c*s  -c*c  -c*s;
          c*s  s*s  -c*s  -s*s;
         -c*c -c*s   c*c   c*s;
         -c*s -s*s   c*s  s*s];
    
          