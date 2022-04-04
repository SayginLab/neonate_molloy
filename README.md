# Personalized neonatal parcellations
Repository for 

> Molloy, M. F., & Saygin, Z. M. (2022). Individual Variability in Functional Organization of the Neonatal Brain. NeuroImage, 119101. https://doi.org/10.1016/j.neuroimage.2022.119101

## PersonalizeSolution 
<a href="subjs" target="blank"><img align="left" src="https://user-images.githubusercontent.com/81258963/159369484-55bb4f46-4fec-4ca1-a6ae-8bf07d46549e.png" height="200" /></a>

This folder contains the script and necessary data to define the functional organization for a single neonate. The function `personalize_atlas.m` computes an individualized parcellation given a subject's functional connectivity matrix. The functional connectivity matrix should be in neonatal template space [(Schuh et al. 2018)](https://gin.g-node.org/BioMedIA/dhcp-volumetric-atlas-groupwise) downsampled to 2x2x2 mm voxels, and masked by the gray matter voxels. The whole-brain 2x2x2 mm gray matter mask is in the [Masks subfolder](https://github.com/SayginLab/neonate_molloy/tree/main/PersonalizeSolution/Masks). The final functional connectivity matrix should be a 23,841 x 23,841 matrix (as a .mat file, 4.4 GB). These parcellations are informed by group-level centroids for 3 solutions that fit the underlying data well and generalize to the independent test set. These optimal solutions (pictured below) are for the k = 5-network solution (cortex-only and whole-brain) and the 8-network solution (cortex-only). 


Analyses were completed using MATLAB R2020a (The MathWorks Inc., Natick, USA), FSL 5.0.10, and the Ohio Supercomputer (https://www.osc.edu). MATLAB, including the [Image Processing Toolbox](https://www.mathworks.com/help/images/index.html?s_tid=CRUX_topnav), is necessary to run `personalize_atlas`. Calculating an individual's k = 5-network whole-brain solution (`personalize_atlas(fc,'5','n','out.nii')`) required approximately 9.5 GB memory (including loading the connectome) and completed in 1 minute and 20 seconds.

## OptimalSolutions
This folder contains nifti files in neonatal template space [(Schuh et al. 2018)](https://gin.g-node.org/BioMedIA/dhcp-volumetric-atlas-groupwise)  and corresponding legends for the three optimal solutions identified. Both the training set and test set solutions (within the Test subfolder) are included.  Note the personalized solutions are based on the centroids of the training set's solution.  
![optimal](https://user-images.githubusercontent.com/81258963/159385102-eba1168d-9656-48aa-ac8c-e1989dbf2286.jpg)


## AllSolutions 
     
While the k = 5 and 8 solutions were found to be optimal, all solutions from k = 2 to 25 networks are included in this folder as nifti files. Whole-brain and cortex-only solutions are included for both the training and the test set.
 
 <a href="" target="blank"><img align="center" src="https://user-images.githubusercontent.com/81258963/159382159-12b067dc-0336-4914-b022-866f1497ceb6.jpg" /></a>

## Supplement
Supplemental data including full functional enrichment output (with complete lists of genes and all categories), ids of subjects and sessions assigned to the training and test sets, and a gif demonstrating hierarchical emergence of networks. 
  
 
