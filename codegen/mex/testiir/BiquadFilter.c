/*
 * BiquadFilter.c
 *
 * Code generation for function 'BiquadFilter'
 *
 * C source code generated on: Fri Mar 28 11:25:03 2014
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "testiir.h"
#include "BiquadFilter.h"
#include "System1.h"
#include "testiir_data.h"

/* Variable Definitions */
static emlrtRTEInfo d_emlrtRTEI = { 43, 20, "output",
  "/Applications/MATLAB_R2013b.app/toolbox/eml/lib/scomp/output.m" };

/* Function Definitions */
dspcodegen_BiquadFilter *BiquadFilter_BiquadFilter(dspcodegen_BiquadFilter *obj)
{
  dspcodegen_BiquadFilter *b_obj;
  dsp_BiquadFilter_0 *c_obj;
  int32_T i;
  static const real_T dv0[18] = { 1.0, -1.95515678116816, 1.0, 1.0,
    -1.94959565490724, 1.0, 1.0, -1.93343149926218, 1.0, 1.0, -1.87097873948293,
    1.0, 1.0, -1.21794669549873, 1.0, 1.0, -1.95703252596479, 1.0 };

  static const real_T dv1[12] = { -1.95710613431623, 0.993903605412116,
    -1.95291495051979, 0.985782161284043, -1.94565425618805, 0.970827701839167,
    -1.93495131413634, 0.948472817394871, -1.92544404963282, 0.928550095361849,
    -1.95995719484952, 0.998332138364963 };

  static const real_T dv2[7] = { 0.794903495809914, 0.819175105281139,
    0.651057676900563, 0.38101615361831, 0.125112834203882, 0.00331724234955245,
    0.0 };

  static const boolean_T bv0[7] = { TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE };

  b_obj = obj;
  System_System(b_obj);
  c_obj = &b_obj->cSFunObject;

  /* System object Constructor function: dsp.BiquadFilter */
  c_obj->S0_isInitialized = FALSE;
  c_obj->S1_isReleased = FALSE;
  c_obj->P0_ICRTP = 0.0;
  for (i = 0; i < 18; i++) {
    c_obj->P1_RTP1COEFF[i] = dv0[i];
  }

  for (i = 0; i < 12; i++) {
    c_obj->P2_RTP2COEFF[i] = dv1[i];
  }

  for (i = 0; i < 7; i++) {
    c_obj->P3_RTP3COEFF[i] = dv2[i];
    c_obj->P4_RTP_COEFF3_BOOL[i] = bv0[i];
  }

  return b_obj;
}

void BiquadFilter_outputImpl(const emlrtStack *sp, dspcodegen_BiquadFilter *obj,
  const real_T varargin_1[512], real_T varargout_1[512])
{
  dsp_BiquadFilter_0 *b_obj;
  int32_T ioIdx;
  int32_T i;
  real_T stageIn;
  real_T numAccum;
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &f_emlrtRSI;
  b_obj = &obj->cSFunObject;
  if (!b_obj->S0_isInitialized) {
    b_obj->S0_isInitialized = TRUE;
    if (b_obj->S1_isReleased) {
      emlrtErrorWithMessageIdR2012b(&st, &d_emlrtRTEI,
        "MATLAB:system:runtimeMethodCalledWhenReleasedCodegen", 0);
    }

    /* System object Initialization function: dsp.BiquadFilter */
    for (ioIdx = 0; ioIdx < 12; ioIdx++) {
      b_obj->W0_FILT_STATES[ioIdx] = b_obj->P0_ICRTP;
    }
  }

  /* System object Outputs function: dsp.BiquadFilter */
  ioIdx = 0;
  for (i = 0; i < 512; i++) {
    stageIn = b_obj->P3_RTP3COEFF[0U] * varargin_1[ioIdx];
    stageIn -= b_obj->P2_RTP2COEFF[0] * b_obj->W0_FILT_STATES[0];
    stageIn -= b_obj->P2_RTP2COEFF[1] * b_obj->W0_FILT_STATES[1];
    numAccum = b_obj->P1_RTP1COEFF[0] * stageIn;
    numAccum += b_obj->P1_RTP1COEFF[1] * b_obj->W0_FILT_STATES[0];
    numAccum += b_obj->P1_RTP1COEFF[2] * b_obj->W0_FILT_STATES[1];
    b_obj->W0_FILT_STATES[1] = b_obj->W0_FILT_STATES[0];
    b_obj->W0_FILT_STATES[0] = stageIn;
    stageIn = b_obj->P3_RTP3COEFF[1U] * numAccum;
    stageIn -= b_obj->P2_RTP2COEFF[2] * b_obj->W0_FILT_STATES[2];
    stageIn -= b_obj->P2_RTP2COEFF[3] * b_obj->W0_FILT_STATES[3];
    numAccum = b_obj->P1_RTP1COEFF[3] * stageIn;
    numAccum += b_obj->P1_RTP1COEFF[4] * b_obj->W0_FILT_STATES[2];
    numAccum += b_obj->P1_RTP1COEFF[5] * b_obj->W0_FILT_STATES[3];
    b_obj->W0_FILT_STATES[3] = b_obj->W0_FILT_STATES[2];
    b_obj->W0_FILT_STATES[2] = stageIn;
    stageIn = b_obj->P3_RTP3COEFF[2U] * numAccum;
    stageIn -= b_obj->P2_RTP2COEFF[4] * b_obj->W0_FILT_STATES[4];
    stageIn -= b_obj->P2_RTP2COEFF[5] * b_obj->W0_FILT_STATES[5];
    numAccum = b_obj->P1_RTP1COEFF[6] * stageIn;
    numAccum += b_obj->P1_RTP1COEFF[7] * b_obj->W0_FILT_STATES[4];
    numAccum += b_obj->P1_RTP1COEFF[8] * b_obj->W0_FILT_STATES[5];
    b_obj->W0_FILT_STATES[5] = b_obj->W0_FILT_STATES[4];
    b_obj->W0_FILT_STATES[4] = stageIn;
    stageIn = b_obj->P3_RTP3COEFF[3U] * numAccum;
    stageIn -= b_obj->P2_RTP2COEFF[6] * b_obj->W0_FILT_STATES[6];
    stageIn -= b_obj->P2_RTP2COEFF[7] * b_obj->W0_FILT_STATES[7];
    numAccum = b_obj->P1_RTP1COEFF[9] * stageIn;
    numAccum += b_obj->P1_RTP1COEFF[10] * b_obj->W0_FILT_STATES[6];
    numAccum += b_obj->P1_RTP1COEFF[11] * b_obj->W0_FILT_STATES[7];
    b_obj->W0_FILT_STATES[7] = b_obj->W0_FILT_STATES[6];
    b_obj->W0_FILT_STATES[6] = stageIn;
    stageIn = b_obj->P3_RTP3COEFF[4U] * numAccum;
    stageIn -= b_obj->P2_RTP2COEFF[8] * b_obj->W0_FILT_STATES[8];
    stageIn -= b_obj->P2_RTP2COEFF[9] * b_obj->W0_FILT_STATES[9];
    numAccum = b_obj->P1_RTP1COEFF[12] * stageIn;
    numAccum += b_obj->P1_RTP1COEFF[13] * b_obj->W0_FILT_STATES[8];
    numAccum += b_obj->P1_RTP1COEFF[14] * b_obj->W0_FILT_STATES[9];
    b_obj->W0_FILT_STATES[9] = b_obj->W0_FILT_STATES[8];
    b_obj->W0_FILT_STATES[8] = stageIn;
    stageIn = b_obj->P3_RTP3COEFF[5U] * numAccum;
    stageIn -= b_obj->P2_RTP2COEFF[10] * b_obj->W0_FILT_STATES[10];
    stageIn -= b_obj->P2_RTP2COEFF[11] * b_obj->W0_FILT_STATES[11];
    numAccum = b_obj->P1_RTP1COEFF[15] * stageIn;
    numAccum += b_obj->P1_RTP1COEFF[16] * b_obj->W0_FILT_STATES[10];
    numAccum += b_obj->P1_RTP1COEFF[17] * b_obj->W0_FILT_STATES[11];
    b_obj->W0_FILT_STATES[11] = b_obj->W0_FILT_STATES[10];
    b_obj->W0_FILT_STATES[10] = stageIn;
    varargout_1[ioIdx] = numAccum;
    ioIdx++;
  }
}

/* End of code generation (BiquadFilter.c) */
