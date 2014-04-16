/*
 * testiir_types.h
 *
 * Code generation for function 'testiir'
 *
 * C source code generated on: Fri Mar 28 11:25:03 2014
 *
 */

#ifndef __TESTIIR_TYPES_H__
#define __TESTIIR_TYPES_H__

/* Include files */
#include "rtwtypes.h"

/* Type Definitions */
#ifndef struct_dsp_BiquadFilter_0
#define struct_dsp_BiquadFilter_0
struct dsp_BiquadFilter_0
{
    boolean_T S0_isInitialized;
    boolean_T S1_isReleased;
    real_T W0_FILT_STATES[12];
    real_T P0_ICRTP;
    real_T P1_RTP1COEFF[18];
    real_T P2_RTP2COEFF[12];
    real_T P3_RTP3COEFF[7];
    boolean_T P4_RTP_COEFF3_BOOL[7];
};
#endif /*struct_dsp_BiquadFilter_0*/
#ifndef typedef_dsp_BiquadFilter_0
#define typedef_dsp_BiquadFilter_0
typedef struct dsp_BiquadFilter_0 dsp_BiquadFilter_0;
#endif /*typedef_dsp_BiquadFilter_0*/
#ifndef typedef_dspcodegen_BiquadFilter
#define typedef_dspcodegen_BiquadFilter
typedef struct
{
    boolean_T isInitialized;
    boolean_T isReleased;
    uint32_T inputVarSize1[8];
    boolean_T inputDirectFeedthrough1;
    dsp_BiquadFilter_0 cSFunObject;
} dspcodegen_BiquadFilter;
#endif /*typedef_dspcodegen_BiquadFilter*/

#endif
/* End of code generation (testiir_types.h) */
