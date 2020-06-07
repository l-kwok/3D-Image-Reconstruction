function pts3d = triangulate(P1, pts1, P2, pts2 )
% triangulate estimate the 3D positions of points from 2d correspondence
%   Args:
%       P1:     projection matrix with shape 3 x 4 for image 1
%       pts1:   coordinates of points with shape N x 2 on image 1
%       P2:     projection matrix with shape 3 x 4 for image 2
%       pts2:   coordinates of points with shape N x 2 on image 2
%
%   Returns:
%       Pts3d:  coordinates of 3D points with shape N x 3
%

pts1h = [pts1'; ones(1,size(pts1,1))];
pts2h = [pts2'; ones(1,size(pts2,1))];

P = zeros(4, size(pts1,1));

for i=1:size(pts1,1)
    A = [pts1h(2,i)*P1(3,:)-P1(2,:); P1(1,:)-pts1h(1,i)*P1(3,:); pts2h(2,i)*P2(3,:)-P2(2,:); P2(1,:)-pts2h(1,i)*P2(3,:)];
    [~,~,V] = svd(A);
	z = V(:,end);
    P(:,i) = z/z(4);
end

pts3d = P(1:3,:)';

%Reprojected Points
pts1_reproj = P1*P;
pts2_reproj = P2*P;

%Convert to Homogeneous
for i=1:size(pts1_reproj,2)
   pts1_reproj(:,i) = [pts1_reproj(1,i)/pts1_reproj(3,i); pts1_reproj(2,i)/pts1_reproj(3,i); 1];
   pts2_reproj(:,i) = [pts2_reproj(1,i)/pts2_reproj(3,i); pts2_reproj(2,i)/pts2_reproj(3,i); 1]; 
end

%Reprojection Error 
%Image 1
error = mean(sum(sqrt((pts1h-pts1_reproj).^2)));
%Image 2
error2 = mean(sum(sqrt((pts2h-pts2_reproj).^2)));



