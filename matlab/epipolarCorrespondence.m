function [pts2] = epipolarCorrespondence(im1, im2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
%

%Compute Epipolar Line
p1 =  [pts1(:,1) pts1(:,2) ones(size(pts1,1),1)];
ep_lines = zeros(size(pts1,1), 3);
for i=1:size(pts1,1)
   ep_lines(i,:) = reshape(F*reshape(p1(i,:), [3 1]), [1 3]);
   scale = norm(ep_lines(1:2));
   ep_lines(i,:) = ep_lines(i,:)/scale;
end

if(ndims(im1) == 3)
    im1 = rgb2gray(im1);
end

if(ndims(im2) == 3)
    im2 = rgb2gray(im2);
end


%candidate points
for j=1:size(ep_lines(:,1),1)
    cp = zeros(size(im2,2),2);
    for i=1:size(im2,2)
        cp(i,:) = [i (-ep_lines(j,3)-i*ep_lines(j,1))/ep_lines(j,2)];
    end
    
    %Find Similarities
    [f1, ~] = extractFeatures(im1, pts1(j,:));
    [f2, l2] = extractFeatures(im2, cp);
    indexPairs = matchFeatures(f1, f2, 'MatchThreshold', 100, 'MaxRatio', 0.99);
    mp2 = l2(indexPairs(:,2),:);
   
    if(size(mp2,1)==0)
        %No Feature Found
        pts2(j,:) = pts1(j,:);
    else
        pts2(j,:) = mp2;
    end
end


