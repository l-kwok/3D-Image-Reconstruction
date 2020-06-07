# 3D Image Reconstruction
In this project the goal was to take 2 images of the same object from different angles and attempt to build a simple 3D model from the 2 images. This is achieved by first taking the image and using the eight-point algorithm to generate epipolar correspondence points. From this we can generate depth and disparity maps which give us a broad view of the 3D reconstruction of the image. 


## Prerequisites
MATLAB

## Data
![Image 1](data/im1.png | width=250)
![Image 2](data/im2.png | width=250)

## Results
![8 point](Results/'3.1.1 Eight Point Result.png')


