#include "mex.h"

void 
mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) 
{
	double cum;
    int i, j, k;
	int* align = (int*)mxGetPr(prhs[0]);
	double* theta = mxGetPr(prhs[1]);
	int N = (int)mxGetDimensions(prhs[0])[0];
	int L = (int)mxGetDimensions(prhs[0])[1];
    
	plhs[0] = mxCreateDoubleMatrix(N, 1, mxREAL);
	double* out = mxGetPr(plhs[0]);

	for(i=0;i<N;i++) 
    {
		out[i]+=1;
		for(j=i+1;j<N;j++) 
        {
			cum=0;
			for(k=0;k<L;k++) 
            {
				if(align[k*N+i]==align[k*N+j]) 
                {
					cum+=1;
				}	
			}
			if(cum/L>=1-theta[0]) 
            {
				out[i]+=1;
				out[j]+=1;
			}	
		}	
    }	
}
