% A test script using templeCoords.mat
%
% Write your code here
%

im1 = imread("../data/im1.png");
im2 = imread("../data/im2.png");
load('../data/someCorresp.mat');

%3.1.1
F = eightpoint(pts1, pts2, M);
%For Debugging Eight Point Algorithm
%displayEpipolarF(im1, im2, F);


% %3.1.2
 load('../data/templeCoords.mat');
 pts2 = epipolarCorrespondence(im1, im2, F, pts1);
% %Use for output verification of epipolarCorrespondence
% %[coordsIM1, coordsIM2] = epipolarMatchGUI(im1, im2, F);

%3.1.3
load('../data/intrinsics.mat');
E = essentialMatrix(F, K1, K2);

%3.1.4
load('../data/templeCoords.mat');
%For Debugging Reprojection Error
%load('../data/someCorresp.mat');

%Calculate extrinsic matrices
p1 = [eye(3) zeros(3,1)];
p2 = camera2(E);


%Test potential projection matrices 
for i=1:size(p2,2)
    p1_intr = K1*p1;
    p2_intr = K2*p2(:,:,i);
    points = triangulate(p1_intr, pts1, p2_intr, pts2);
    if all(points(:,3) > 0)
       p2_final = p2(:,:,i);
       Points3D = points;
    end
end
R1 = eye(3);
t1 = zeros(3,1);
R2 = p2_final(:,1:3);
t2 = p2_final(:,4);

plot3(Points3D(:,1), Points3D(:,2), Points3D(:,3),'o');
% save extrinsic parameters for dense reconstruction
save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');
