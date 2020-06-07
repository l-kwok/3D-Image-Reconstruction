function depthM = get_depth(dispM, K1, K2, R1, R2, t1, t2)
% GET_DEPTH creates a depth map from a disparity map (DISPM).
c1 = -inv(R1)*t1;
c2 = -inv(R2)*t2;

b = sqrt(sum((c1-c2).*(c1-c2)));
f = K1(1,1);

depthM = f*b*(1./(dispM));