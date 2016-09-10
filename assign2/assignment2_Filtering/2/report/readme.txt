In bilateral filtering, a weighted average is done of the neighboring pixels. The way the weights of the terms are calculated, makes the approach interesing. The contribution to the weights comes from both the spatial and the intensity domains.

The code operates with a window size of 5x5 and the parameter optimisations have been done with respect to this window size. A space gaussian is computed with standard deviation 1.5 which is around 1/3 rd of the window size. The intensity mask also is Gaussian in nature with a standard deviation of 9.7, around 2 times the window size. The minimum RMSD error comes out to be 3.300 which is a local minima with respect to the neighboring parameter values as asked by the problem statement. A square 5x5 window runs over the entire image with the exception of boundary points, where a similar window operation has been used but the "imaginary" points outside the image region are all set to zero, effectively rendering their contribution as null.

The optimal parameters were figured out using running an iterative loop over the two parameters. Both varied from 1 to 10 with a step size of 1. This initial search found the parameters to be 2(space) and 9(range). For a more refined search, we searched for space in the interval 1:0.1:3 and range in 8:0.1:10 (in matlab syntax). This gave the minimum value of the RMSD.

Optimal parameters
------------------
sigma_space = 1.5
sigma_range = 9.7

optimal: dist: 3.300023e+00
0.9 space: dist: 3.313036e+00
1.1 space: dist: 3.305919e+00
0.9 range: dist: 3.338741e+00
1.1 range: dist: 3.306026e+00

The gaussian noise added to the image indeed makes it look distorted and the fitering process clearly shows the robustness of the algorithm.