/*
 * testiir_initialize.c
 *
 * Code generation for function 'testiir_initialize'
 *
 * C source code generated on: Fri Mar 28 11:25:03 2014
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "testiir.h"
#include "testiir_initialize.h"

/* Variable Definitions */
static const volatile char_T *emlrtBreakCheckR2012bFlagVar;

/* Function Declarations */
static void testiir_once(void);

/* Function Definitions */
static void testiir_once(void)
{
  Hd_not_empty_init();
}

void testiir_initialize(emlrtStack *sp, emlrtContext *aContext)
{
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2012b();
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, aContext, NULL, 1);
  sp->tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(sp, FALSE, 0U, 0);
  emlrtEnterRtStackR2012b(sp);
  if (emlrtFirstTimeR2012b(emlrtRootTLSGlobal)) {
    testiir_once();
  }
}

/* End of code generation (testiir_initialize.c) */
