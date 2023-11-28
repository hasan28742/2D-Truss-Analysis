%assembling global stiffness matrix
function y = assembly(K,k,i,j)
%i and j are the connceting node number of the element
%Here capital K value is 10*10 golbal stifness matix, small k(row,column)is the local stiffness corresponding position value
% every iteration, the global sitffness matrix will be updated
K(2*i-1, 2*i-1) = K(2*i-1, 2*i-1) + k(1,1);%for k1:i=3,j=1,K(2*3-1=5, 2*3-1=5)  Ux3,Ux3 
K(2*i-1, 2*i  ) = K(2*i-1, 2*i  ) + k(1,2);%for k1:i=3,j=1,K(2*3-1=5, 2*3  =6)  Uy3,Ux3  
K(2*i-1, 2*j-1) = K(2*i-1, 2*j-1) + k(1,3);%for k1:i=3,j=1,K(2*3-1=5, 2*1-1=1)  Ux1,Ux3  
K(2*i-1, 2*j  ) = K(2*i-1, 2*j  ) + k(1,4);%for k1:i=3,j=1,K(2*3-1=5, 2*1  =2)  Uy1,Ux3  
K(2*i,   2*i-1) = K(2*i,   2*i-1) + k(2,1);%for k1:i=3,j=1,K(2*3=  6, 2*3-1=5)  Ux3,Uy3  
K(2*i,   2*i  ) = K(2*i,   2*i  ) + k(2,2);%for k1:i=3,j=1,K(2*3=  6, 2*3  =6)  Uy3,Uy3  
K(2*i,   2*j-1) = K(2*i,   2*j-1) + k(2,3);%for k1:i=3,j=1,K(2*3=  6, 2*1-1=1)  Ux1,Uy3  
K(2*i,   2*j  ) = K(2*i,   2*j  ) + k(2,4);%for k1:i=3,j=1,K(2*3=  6, 2*1  =2)  Uy1,Uy3  
K(2*j-1, 2*i-1) = K(2*j-1, 2*i-1) + k(3,1);%for k1:i=3,j=1,K(2*1-1=1, 2*3-1=5)  Ux3,Ux1  
K(2*j-1, 2*i  ) = K(2*j-1, 2*i  ) + k(3,2);%for k1:i=3,j=1,K(2*1-1=1, 2*3  =6)  Uy3,Ux1  
K(2*j-1, 2*j-1) = K(2*j-1, 2*j-1) + k(3,3);%for k1:i=3,j=1,K(2*1-1=1, 2*1-1=1)  Ux1,Ux1  
K(2*j-1, 2*j  ) = K(2*j-1, 2*j  ) + k(3,4);%for k1:i=3,j=1,K(2*1-1=1, 2*1  =2)  Uy1,Ux1  
K(2*j,   2*i-1) = K(2*j,   2*i-1) + k(4,1);%for k1:i=3,j=1,K(2*1=  2, 2*3-1=5)  Ux3,Uy1  
K(2*j,   2*i  ) = K(2*j,   2*i  ) + k(4,2);%for k1:i=3,j=1,K(2*1=  2, 2*3  =6)  Uy3,Uy1  
K(2*j,   2*j-1) = K(2*j,   2*j-1) + k(4,3);%for k1:i=3,j=1,K(2*1=  2, 2*1-1=1)  Ux1,Uy1  
K(2*j,   2*j  ) = K(2*j,   2*j  ) + k(4,4);%for k1:i=3,j=1,K(2*1=  2, 2*1  =2)  Uy1,Uy1  
y= K;
