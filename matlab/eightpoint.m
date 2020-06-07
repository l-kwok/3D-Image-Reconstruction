function F = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

%Scalar Matrix
M = [1/M 0 0; 0 1/M 0; 0 0 1];

%normalize points
p1n = [pts1 ones(size(pts1,1),1)]';
p1n = (M*p1n)';
p2n = [pts2 ones(size(pts2,1),1)]';
p2n = (M*p2n)';


%seperate x and y coordinates into Mx1 columns
p1nx = p1n(:,1);
p1ny = p1n(:,2);
p2nx = p2n(:,1);
p2ny = p2n(:,2);

%create the A matrix: 
%[x1*x1' x1y1' x1 y1x1' y1y1' y1 x1' y1' 1]
A = [p1nx.*p2nx p1nx.*p2ny p1nx p1ny.*p2nx p1ny.*p2ny p1ny p2nx p2ny ones(size(p1nx,1),1)];
 
%use SVD to solve
[~, ~, V] = svd(A);

%reshape V into a 3 by 3 matrix
V = reshape(V(:,9),3,3);

%enforce Rank 2 condition
[U, S, V] = svd(V);
S(3,3) = 0;
F = U*S*V';

F = refineF(F, p1n, p2n);


%unormalize
F = (M')*F*M;

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'
