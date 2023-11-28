%solving 10 degree of freedon struss reaction force at the hinged point.
clear; clc;
%declering all data, all in SI unit
A=.02; %cross sectional area of each element
E=100000000000;  %Youngs Modulous for all element 
L1=2;theta1=60;%lenth of the first element is 2 & angle is 60 degree
L2=2;theta2=120; %lenth of the second element is 2 & angle is 120 degree
L3=3.01;theta3=4.67;%lenth of the third element is 2 & angle is 4.67 degree
L4=2.83;theta4=45;%lenth of the fourth element is 2.83 & angle is 45 degree
L5=2;theta5=90; %lenth of the fifth element is 2 & angle is 90 degree


% local_stiffness_matrix(E,A,L,theta)from individual function. 
k1= local_stiffness_matrix(E,A,L1,theta1);%stiffness matrix for elemetn 1; node 3 to 1
k2= local_stiffness_matrix(E,A,L2,theta2);%stiffness matrix for elemetn 2;node 4 to 1
k3= local_stiffness_matrix(E,A,L3,theta3);%stiffness matrix for elemetn 3;node 1 to 2
k4= local_stiffness_matrix(E,A,L4,theta4);%stiffness matrix for elemetn 4;node 4 to 2
k5= local_stiffness_matrix(E,A,L5,theta5);%stiffness matrix for elemetn 5;node 5 to 2
fprintf('Local stiffness matrix')
k1
k2
k3
k4
k5
%ending of local stiffness matrix part

%assembly process of global stiffness matrix K= assembly (K,k,i,j)
%Here uppercase K is global and lower case k is local stiffness matirix
K=zeros(10,10); %5nodes*2=10 degree of freedom. so 10*10 zeros matrix
K=assembly(K,k1,3,1);%connect the stiffeness between node i=3 to j=1 or element 1
K=assembly(K,k2,4,1);%connect the stiffeness between node i=4 to j=1 or element 2
K=assembly(K,k3,1,2);%connect the stiffeness between node i=1 to j=2 or element 3
K=assembly(K,k4,4,2);%connect the stiffeness between node i=4 to j=2 or element 4
K=assembly(K,k5,5,2);%connect the stiffeness between node i=5 to j=2 or element 5
fprintf('Golobal stiffness matrix K')
K
%fprintf('10*10 global stifness matrix is %.4f\n', K);
%elmenating 5,6,7,8,9,10 row and columns and getting
%reduced_global_stifness matrix(M)
M=[K(1:4);K(2,1:4);K(3,1:4);K(4,1:4)];
fprintf('Boundary Condition')
f=[0;0;1000;0]%boundary conditions
u=M\f; %backslash operator used for gauss elimination technique, here u is deflection value of node 1 and 2 (Ux1,Uy1,Ux2,uy2)
%10 deflection value of the nodes
fprintf('deflection matrix')
U=[u(1:4); 0;0;0;0;0;0]
%now for reaction force (R)of each point in x and y
%direction,R1x=R1y=R2x=R2y=0; only three hinged point have 6 reactin force.
fprintf('Reaction force')
R=K*U
%stress in each element (sigma1,-----,sigma5)
u1=[U(5);U(6);U(1);U(2)];%U3x=5,U3y=6,U1x=1,U1y=2 are the connecting node deflection
u2=[U(7);U(8);U(1);U(2)];%U4x=7,U4y=8,U1x=1,U1y=2 are the connecting node deflection
u3=[U(1);U(2);U(3);U(4)];%U1x=,U1y=2,U2x=3,U2y=4 are the connecting node deflection
u4=[U(7);U(8);U(3);U(4)];%U4x=7,U4y=8,U2x=3,U2y=4 are the connecting node deflection
u5=[U(9);U(10);U(3);U(4)];%U5x=9,U5y=10,U2x=3,U2y=4 are the connecting node deflection
fprintf('Stress in element 1')
sigma1=stress_in_each_element(E,L1,theta1,u1)
fprintf('Stress in element 2')
sigma2=stress_in_each_element(E,L2,theta2,u2)
fprintf('Stress in element 3')
sigma3=stress_in_each_element(E,L3,theta3,u3)
fprintf('Stress in element 4')
sigma4=stress_in_each_element(E,L4,theta4,u4)
fprintf('Stress in element 5')
sigma5=stress_in_each_element(E,L5,theta5,u5)
%--------------------------- Plot drawing-------------------------
%Plot structure
f1=figure();
Co_ordinate =[0 0; 3 0.268; -1 -1.732; 1 -1.732; 3 -1.732]; %node coordinate. node 1 is in center point
Connection_point = [3 1; 4 1; 1 2; 4 2; 5 2]; %element conncting node
df = [1 2; 3 4; 5 6; 7 8; 9 10];%each node deflection serial.1=Ux1;2=Uy1;3=Ux2;4=Uy2;5=Ux3;6=Uy3;7=Ux4;8=Uy4;9=Ux5;10=Uy5
NN = size(Co_ordinate,1); %no of nodes
NE = size(Connection_point,1);%no of elements
NCOORD = zeros(size(Co_ordinate));%deformed co-ordinate generation through zero matrix
scale = 100;
for n =1:NN
    NCOORD(n,1) = Co_ordinate(n,1) +scale*U(df(n,1));
    NCOORD(n,2) = Co_ordinate(n,2) +scale*U(df(n,2));
end

for k =1:NE
     i=Connection_point(k,1);%first starting point of local node
     j=Connection_point(k,2);%ending point of local node
     x=[Co_ordinate(i,1) Co_ordinate(j,1)];
     y=[Co_ordinate(i,2) Co_ordinate(j,2)];
     xlim([-1.5 4]);
     ylim([-2 1]);
     plot(x,y,'k-');
     hold on
     ux=[NCOORD(i,1) NCOORD(j,1)];
     uy=[NCOORD(i,2) NCOORD(j,2)];
     xlim([-1.5 4]);
     ylim([-2 1]);
     plot(ux,uy,'r--');
     hold on
end
