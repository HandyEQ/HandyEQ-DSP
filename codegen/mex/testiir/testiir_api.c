/*
 * testiir_api.c
 *
 * Code generation for function 'testiir_api'
 *
 * C source code generated on: Fri Mar 28 11:25:03 2014
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "testiir.h"
#include "testiir_api.h"

/* Function Declarations */
static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[512];
static real_T (*c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[512];
static real_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *x, const
  char_T *identifier))[512];
static const mxArray *emlrt_marshallOut(real_T u[512]);

/* Function Definitions */
static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[512]
{
  real_T (*y)[512];
  y = c_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static real_T (*c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[512]
{
  real_T (*ret)[512];
  int32_T iv7[1];
  iv7[0] = 512;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", FALSE, 1U, iv7);
  ret = (real_T (*)[512])mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static real_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *x, const
  char_T *identifier))[512]
{
  real_T (*y)[512];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  y = b_emlrt_marshallIn(sp, emlrtAlias(x), &thisId);
  emlrtDestroyArray(&x);
  return y;
}
  static const mxArray *emlrt_marshallOut(real_T u[512])
{
  const mxArray *y;
  static const int32_T iv5[1] = { 0 };

  const mxArray *m1;
  static const int32_T iv6[1] = { 512 };

  y = NULL;
  m1 = mxCreateNumericArray(1, (int32_T *)&iv5, mxDOUBLE_CLASS, mxREAL);
  mxSetData((mxArray *)m1, (void *)u);
  mxSetDimensions((mxArray *)m1, iv6, 1);
  emlrtAssign(&y, m1);
  return y;
}

void testiir_api(emlrtStack *sp, const mxArray * const prhs[1], const mxArray
                 *plhs[1])
{
  real_T (*y)[512];
  real_T (*x)[512];
  y = (real_T (*)[512])mxMalloc(sizeof(real_T [512]));

  /* Marshall function inputs */
  x = emlrt_marshallIn(sp, emlrtAlias(prhs[0]), "x");

  /* Invoke the target function */
  testiir(sp, *x, *y);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(*y);
}

/* End of code generation (testiir_api.c) */
