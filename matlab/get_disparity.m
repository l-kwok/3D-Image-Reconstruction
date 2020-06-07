function dispM = get_disparity(im1, im2, maxDisp, windowSize)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.
mask = ones(windowSize, windowSize);
[row_size, col_size] = size(im1);
disp = zeros(row_size, col_size, maxDisp+1);
dist = zeros(row_size, col_size);

for i=0:maxDisp
    dist(1:(row_size * (col_size-i))) = (im1((1:(row_size * (col_size-i))) + row_size*i) - im2(1:(row_size * (col_size-i)))).^2;
    disp(:,:,i+1) = conv2(dist, mask, 'same');
end

[~, index] = min(disp, [], 3);
dispM = index-1;