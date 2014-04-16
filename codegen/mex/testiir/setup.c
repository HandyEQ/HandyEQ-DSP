/*
 * setup.c
 *
 * Code generation for function 'setup'
 *
 * C source code generated on: Fri Mar 28 11:25:03 2014
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "testiir.h"
#include "setup.h"

/* Function Definitions */
void Destructor(dsp_BiquadFilter_0 *obj)
{
  /* System object Destructor function: dsp.BiquadFilter */
  if (obj->S0_isInitialized) {
    obj->S0_isInitialized = FALSE;
    if (!obj->S1_isReleased) {
      obj->S1_isReleased = TRUE;
    }
  }
}

/* End of code generation (setup.c) */
