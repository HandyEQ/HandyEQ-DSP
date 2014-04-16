/*
 * System1.c
 *
 * Code generation for function 'System1'
 *
 * C source code generated on: Fri Mar 28 11:25:03 2014
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "testiir.h"
#include "System1.h"

/* Function Definitions */
void System_System(dspcodegen_BiquadFilter *obj)
{
  dspcodegen_BiquadFilter *b_obj;
  b_obj = obj;
  b_obj->isInitialized = FALSE;
  b_obj->isReleased = FALSE;
  b_obj->inputDirectFeedthrough1 = FALSE;
}

/* End of code generation (System1.c) */
