#include "mex.h"
#include "pcg_random.hpp"
#include <iostream>
#include <math.h>
#include <omp.h>
#include <random>
#include <stdlib.h>
#include <time.h>

void
mexFunction(int nlhs, mxArray* plhs[], int nrhs, const mxArray* prhs[])
{
  int seed = (int)mxGetScalar(prhs[0]);
  double* w = mxGetPr(prhs[1]);
  int N = (int)mxGetScalar(prhs[2]);
  int q = (int)mxGetScalar(prhs[3]);
  int L = (int)mxGetScalar(prhs[4]);
  int delta_t = (int)mxGetScalar(prhs[5]);

  // plhs[0] = mxCreateNumericMatrix(N, L, mxINT32_CLASS, mxREAL);
  plhs[0] = mxCreateNumericMatrix(L, N, mxINT32_CLASS, mxREAL);
  int* align_out = static_cast<int*>(mxGetData(plhs[0]));

#pragma omp parallel for
  for (int n = 0; n < N; n++) {

    pcg32 rng;
    rng.seed(seed + n);
    std::uniform_real_distribution<double> uniform(0, 1);

    int* align_tmp = (int*)malloc(sizeof(int) * L);

    /* get initial seq */
    for (int i = 0; i < L; i++) {
      align_tmp[i] = (int)(q * uniform(rng)) + 1;
    }

    for (int k = 0; k < delta_t; k++) {
      int pos = (int)(uniform(rng) * L) + 1;
      int dq = 1 + (int)(uniform(rng) * (q - 1));
      int cur_aa = align_tmp[pos - 1];
      int new_aa = (cur_aa + dq - 1) % q + 1;

      double dE = w[L * (L - 1) / 2 * q * q + (pos - 1) * q + new_aa - 1] -
                  w[L * (L - 1) / 2 * q * q + (pos - 1) * q + cur_aa - 1];

      for (int other_pos = pos + 1; other_pos < L + 1; other_pos++) {
        // int other_aa = align_tmp[other_pos - 1];
        dE +=
          w[q * q * ((pos - 1) * (L * 2 - pos) / 2 + (other_pos - pos - 1)) +
            (new_aa - 1) * q + align_tmp[other_pos - 1] - 1] -
          w[q * q * ((pos - 1) * (L * 2 - pos) / 2 + (other_pos - pos - 1)) +
            (cur_aa - 1) * q + align_tmp[other_pos - 1] - 1];
      }

      for (int other_pos = 1; other_pos < pos; other_pos++) {
        // int other_aa = align_tmp[other_pos - 1];
        dE += w[q * q *
                  ((other_pos - 1) * (L * 2 - other_pos) / 2 +
                   (pos - other_pos - 1)) +
                (align_tmp[other_pos - 1] - 1) * q + new_aa - 1] -
              w[q * q *
                  ((other_pos - 1) * (L * 2 - other_pos) / 2 +
                   (pos - other_pos - 1)) +
                (align_tmp[other_pos - 1] - 1) * q + cur_aa - 1];
      }

      double r = uniform(rng);
      if (exp(dE) > r) {
        align_tmp[pos - 1] = new_aa;
      }
    }

    for (int i = 0; i < L; i++) {
      align_out[n * L + i] = align_tmp[i];
      // align_out[i*N+n] = align_tmp[i]; // matlab does column-major order
    }

    free(align_tmp);
  }
  return;
}
