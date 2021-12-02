# UndersamplingCoevolution
Containing computational routines to support article titled "Undersampling and the inference of coevolution in proteins"

## Install
To use the SBM on Matlab one must perform Mex operation on the c++ files in the Functions folder.
in matlab, when in the Functions folder run 
```
mex C_MSA_MonteCarlo.cpp
mex C_InverseWeights.cpp
```

In MacOs machines there might be a compatability issue with the compiler (Clang), this will menifest in Matlab crashing when running this.
To overcome this we must force the compilation to use gcc. In the file mex_cpp.sh change the `MATLABROOT` value to whatever the matlabroot is,
you can see that by running `matlabroot` in matlab. Afterwards, in the terminal, with appropriate permissions, run 
```
./mex_cpp.sh C_MSA_MonteCarlo.cpp
``` 

## Contents
### Create Toy Alignment
Running the matlab script Create_Toy_Align.m will produce a toy alignment dictated by the input model parameters (J,h) and the MonteCarlo burn time delta_t. 
The alignment will have L position per sequence, for each of N sequences. Every position can have q different values (1:q).
Defining the model, we use a list of pairwise contacts given as a list of pairs. In addition there are separate vector units (sectors), who all have the same number of components (which sometimes repeat, to remove effective number of components) and they are later translated into a list of interconnected pairs between every two components in the unit. The magnitude 
In addition a field may be introduced to prefer a=1 amino acid in positions notated as "conserved", which is also given as a list of positions. This was not used in the main text of the paper.

### ExactDCA
Running the matlab script Run_ExactDCA.m will produce the result J,h which is the inferred model parameters for the given alignment and inference parameters. This is done without approximation and can only be applied to small systems (very small q~2,3 and small L).


