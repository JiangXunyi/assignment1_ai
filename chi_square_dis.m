function [dis] = chi_square_dis(x,y)


subMatrix = x-y;
subMatrix2 = subMatrix.^2;
addMatrix = x+y; 
 
% addMatrix(addMatrix==0) = 1;
DistMat = subMatrix2./addMatrix;
DistMat(isnan(DistMat)) = 0;
dis = 0.5*sum(DistMat); 
