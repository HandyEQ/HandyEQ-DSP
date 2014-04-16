/*
 * _coder_testiir_info.c
 *
 * Code generation for function 'testiir'
 *
 * C source code generated on: Fri Mar 28 11:25:03 2014
 *
 */

/* Include files */
#include "_coder_testiir_info.h"

/* Function Declarations */
static void info_helper(const mxArray **info);
static const mxArray *emlrt_marshallOut(const char * u);
static const mxArray *b_emlrt_marshallOut(uint32_T u);

/* Function Definitions */
const mxArray *emlrtMexFcnResolvedFunctionsInfo(void)
{
  const mxArray *nameCaptureInfo;
  nameCaptureInfo = NULL;
  emlrtAssign(&nameCaptureInfo, mxCreateStructMatrix(33, 1, 0, NULL));
  info_helper(&nameCaptureInfo);
  emlrtNameCapturePostProcessR2013b(&nameCaptureInfo);
  return nameCaptureInfo;
}

static void info_helper(const mxArray **info)
{
  const mxArray *rhs0 = NULL;
  const mxArray *lhs0 = NULL;
  const mxArray *rhs1 = NULL;
  const mxArray *lhs1 = NULL;
  const mxArray *rhs2 = NULL;
  const mxArray *lhs2 = NULL;
  const mxArray *rhs3 = NULL;
  const mxArray *lhs3 = NULL;
  const mxArray *rhs4 = NULL;
  const mxArray *lhs4 = NULL;
  const mxArray *rhs5 = NULL;
  const mxArray *lhs5 = NULL;
  const mxArray *rhs6 = NULL;
  const mxArray *lhs6 = NULL;
  const mxArray *rhs7 = NULL;
  const mxArray *lhs7 = NULL;
  const mxArray *rhs8 = NULL;
  const mxArray *lhs8 = NULL;
  const mxArray *rhs9 = NULL;
  const mxArray *lhs9 = NULL;
  const mxArray *rhs10 = NULL;
  const mxArray *lhs10 = NULL;
  const mxArray *rhs11 = NULL;
  const mxArray *lhs11 = NULL;
  const mxArray *rhs12 = NULL;
  const mxArray *lhs12 = NULL;
  const mxArray *rhs13 = NULL;
  const mxArray *lhs13 = NULL;
  const mxArray *rhs14 = NULL;
  const mxArray *lhs14 = NULL;
  const mxArray *rhs15 = NULL;
  const mxArray *lhs15 = NULL;
  const mxArray *rhs16 = NULL;
  const mxArray *lhs16 = NULL;
  const mxArray *rhs17 = NULL;
  const mxArray *lhs17 = NULL;
  const mxArray *rhs18 = NULL;
  const mxArray *lhs18 = NULL;
  const mxArray *rhs19 = NULL;
  const mxArray *lhs19 = NULL;
  const mxArray *rhs20 = NULL;
  const mxArray *lhs20 = NULL;
  const mxArray *rhs21 = NULL;
  const mxArray *lhs21 = NULL;
  const mxArray *rhs22 = NULL;
  const mxArray *lhs22 = NULL;
  const mxArray *rhs23 = NULL;
  const mxArray *lhs23 = NULL;
  const mxArray *rhs24 = NULL;
  const mxArray *lhs24 = NULL;
  const mxArray *rhs25 = NULL;
  const mxArray *lhs25 = NULL;
  const mxArray *rhs26 = NULL;
  const mxArray *lhs26 = NULL;
  const mxArray *rhs27 = NULL;
  const mxArray *lhs27 = NULL;
  const mxArray *rhs28 = NULL;
  const mxArray *lhs28 = NULL;
  const mxArray *rhs29 = NULL;
  const mxArray *lhs29 = NULL;
  const mxArray *rhs30 = NULL;
  const mxArray *lhs30 = NULL;
  const mxArray *rhs31 = NULL;
  const mxArray *lhs31 = NULL;
  const mxArray *rhs32 = NULL;
  const mxArray *lhs32 = NULL;
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/shared/system/coder/+matlab/+system/+coder/System.p"),
                "context", 0);
  emlrtAddField(*info, emlrt_marshallOut("matlab.system.coder.SystemProp"),
                "name", 0);
  emlrtAddField(*info, emlrt_marshallOut("unknown"), "dominantType", 0);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/shared/system/coder/+matlab/+system/+coder/SystemProp.p"),
                "resolved", 0);
  emlrtAddField(*info, b_emlrt_marshallOut(1373635994U), "fileTimeLo", 0);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 0);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 0);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 0);
  emlrtAssign(&rhs0, emlrtCreateCellArray(0));
  emlrtAssign(&lhs0, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs0), "rhs", 0);
  emlrtAddField(*info, emlrtAliasP(lhs0), "lhs", 0);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/shared/system/coder/+matlab/+system/+coder/System.p"),
                "context", 1);
  emlrtAddField(*info, emlrt_marshallOut("matlab.system.coder.SystemCore"),
                "name", 1);
  emlrtAddField(*info, emlrt_marshallOut("unknown"), "dominantType", 1);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/shared/system/coder/+matlab/+system/+coder/SystemCore.p"),
                "resolved", 1);
  emlrtAddField(*info, b_emlrt_marshallOut(1373635994U), "fileTimeLo", 1);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 1);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 1);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 1);
  emlrtAssign(&rhs1, emlrtCreateCellArray(0));
  emlrtAssign(&lhs1, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs1), "rhs", 1);
  emlrtAddField(*info, emlrtAliasP(lhs1), "lhs", 1);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/dsp/dsp/+dspcodegen/BiquadFilter.p"), "context",
                2);
  emlrtAddField(*info, emlrt_marshallOut("matlab.system.coder.System"), "name",
                2);
  emlrtAddField(*info, emlrt_marshallOut("unknown"), "dominantType", 2);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/shared/system/coder/+matlab/+system/+coder/System.p"),
                "resolved", 2);
  emlrtAddField(*info, b_emlrt_marshallOut(1373305796U), "fileTimeLo", 2);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 2);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 2);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 2);
  emlrtAssign(&rhs2, emlrtCreateCellArray(0));
  emlrtAssign(&lhs2, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs2), "rhs", 2);
  emlrtAddField(*info, emlrtAliasP(lhs2), "lhs", 2);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/dsp/dsp/+dspcodegen/BiquadFilter.p"), "context",
                3);
  emlrtAddField(*info, emlrt_marshallOut("matlab.System"), "name", 3);
  emlrtAddField(*info, emlrt_marshallOut("unknown"), "dominantType", 3);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/matlab/system/+matlab/System.p"), "resolved", 3);
  emlrtAddField(*info, b_emlrt_marshallOut(1373300594U), "fileTimeLo", 3);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 3);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 3);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 3);
  emlrtAssign(&rhs3, emlrtCreateCellArray(0));
  emlrtAssign(&lhs3, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs3), "rhs", 3);
  emlrtAddField(*info, emlrtAliasP(lhs3), "lhs", 3);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/dsp/dsp/+dspcodegen/BiquadFilter.p"), "context",
                4);
  emlrtAddField(*info, emlrt_marshallOut("matlab.system.mixin.coder.Nondirect"),
                "name", 4);
  emlrtAddField(*info, emlrt_marshallOut("unknown"), "dominantType", 4);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/shared/system/coder/+matlab/+system/+mixin/+coder/Nondirect.p"),
                "resolved", 4);
  emlrtAddField(*info, b_emlrt_marshallOut(1373305798U), "fileTimeLo", 4);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 4);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 4);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 4);
  emlrtAssign(&rhs4, emlrtCreateCellArray(0));
  emlrtAssign(&lhs4, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs4), "rhs", 4);
  emlrtAddField(*info, emlrtAliasP(lhs4), "lhs", 4);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/dsp/dsp/+dspcodegen/BiquadFilter.p"), "context",
                5);
  emlrtAddField(*info, emlrt_marshallOut("matlab.system.mixin.Nondirect"),
                "name", 5);
  emlrtAddField(*info, emlrt_marshallOut("unknown"), "dominantType", 5);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/matlab/system/+matlab/+system/+mixin/Nondirect.p"),
                "resolved", 5);
  emlrtAddField(*info, b_emlrt_marshallOut(1373300594U), "fileTimeLo", 5);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 5);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 5);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 5);
  emlrtAssign(&rhs5, emlrtCreateCellArray(0));
  emlrtAssign(&lhs5, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs5), "rhs", 5);
  emlrtAddField(*info, emlrtAliasP(lhs5), "lhs", 5);
  emlrtAddField(*info, emlrt_marshallOut(
    "[E]/Users/Johan/Documents/MATLAB/testiir.m"), "context", 6);
  emlrtAddField(*info, emlrt_marshallOut("dspcodegen.BiquadFilter"), "name", 6);
  emlrtAddField(*info, emlrt_marshallOut("int32"), "dominantType", 6);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/dsp/dsp/+dspcodegen/BiquadFilter.p"), "resolved",
                6);
  emlrtAddField(*info, b_emlrt_marshallOut(1375996936U), "fileTimeLo", 6);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 6);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 6);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 6);
  emlrtAssign(&rhs6, emlrtCreateCellArray(0));
  emlrtAssign(&lhs6, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs6), "rhs", 6);
  emlrtAddField(*info, emlrtAliasP(lhs6), "lhs", 6);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/shared/system/coder/+matlab/+system/+coder/SystemProp.p"),
                "context", 7);
  emlrtAddField(*info, emlrt_marshallOut("matlab.system.coder.SystemProp"),
                "name", 7);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 7);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/shared/system/coder/+matlab/+system/+coder/SystemProp.p"),
                "resolved", 7);
  emlrtAddField(*info, b_emlrt_marshallOut(1373635994U), "fileTimeLo", 7);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 7);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 7);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 7);
  emlrtAssign(&rhs7, emlrtCreateCellArray(0));
  emlrtAssign(&lhs7, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs7), "rhs", 7);
  emlrtAddField(*info, emlrtAliasP(lhs7), "lhs", 7);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/dsp/dsp/+dspcodegen/BiquadFilter.p"), "context",
                8);
  emlrtAddField(*info, emlrt_marshallOut("createsystemobjectv2"), "name", 8);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 8);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/scomp/createsystemobjectv2.m"),
                "resolved", 8);
  emlrtAddField(*info, b_emlrt_marshallOut(1343830358U), "fileTimeLo", 8);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 8);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 8);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 8);
  emlrtAssign(&rhs8, emlrtCreateCellArray(0));
  emlrtAssign(&lhs8, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs8), "rhs", 8);
  emlrtAddField(*info, emlrtAliasP(lhs8), "lhs", 8);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/scomp/createsystemobjectv2.m"),
                "context", 9);
  emlrtAddField(*info, emlrt_marshallOut("length"), "name", 9);
  emlrtAddField(*info, emlrt_marshallOut("cell"), "dominantType", 9);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elmat/length.m"), "resolved", 9);
  emlrtAddField(*info, b_emlrt_marshallOut(1303146206U), "fileTimeLo", 9);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 9);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 9);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 9);
  emlrtAssign(&rhs9, emlrtCreateCellArray(0));
  emlrtAssign(&lhs9, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs9), "rhs", 9);
  emlrtAddField(*info, emlrtAliasP(lhs9), "lhs", 9);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/shared/system/coder/+matlab/+system/+coder/SystemProp.p"),
                "context", 10);
  emlrtAddField(*info, emlrt_marshallOut("matlab.system.isSystemObject"), "name",
                10);
  emlrtAddField(*info, emlrt_marshallOut("char"), "dominantType", 10);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXE]$matlabroot$/toolbox/matlab/system/+matlab/+system/isSystemObject.p"),
                "resolved", 10);
  emlrtAddField(*info, b_emlrt_marshallOut(1373300594U), "fileTimeLo", 10);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 10);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 10);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 10);
  emlrtAssign(&rhs10, emlrtCreateCellArray(0));
  emlrtAssign(&lhs10, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs10), "rhs", 10);
  emlrtAddField(*info, emlrtAliasP(lhs10), "lhs", 10);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/shared/system/coder/+matlab/+system/+coder/SystemProp.p"),
                "context", 11);
  emlrtAddField(*info, emlrt_marshallOut("length"), "name", 11);
  emlrtAddField(*info, emlrt_marshallOut("cell"), "dominantType", 11);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elmat/length.m"), "resolved", 11);
  emlrtAddField(*info, b_emlrt_marshallOut(1303146206U), "fileTimeLo", 11);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 11);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 11);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 11);
  emlrtAssign(&rhs11, emlrtCreateCellArray(0));
  emlrtAssign(&lhs11, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs11), "rhs", 11);
  emlrtAddField(*info, emlrtAliasP(lhs11), "lhs", 11);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/shared/system/coder/+matlab/+system/+coder/SystemProp.p"),
                "context", 12);
  emlrtAddField(*info, emlrt_marshallOut("matlab.system.pvParse"), "name", 12);
  emlrtAddField(*info, emlrt_marshallOut("dspcodegen.BiquadFilter"),
                "dominantType", 12);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXE]$matlabroot$/toolbox/matlab/system/+matlab/+system/pvParse.p"),
                "resolved", 12);
  emlrtAddField(*info, b_emlrt_marshallOut(1373300594U), "fileTimeLo", 12);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 12);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 12);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 12);
  emlrtAssign(&rhs12, emlrtCreateCellArray(0));
  emlrtAssign(&lhs12, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs12), "rhs", 12);
  emlrtAddField(*info, emlrtAliasP(lhs12), "lhs", 12);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXE]$matlabroot$/toolbox/matlab/system/+matlab/+system/pvParse.p"),
                "context", 13);
  emlrtAddField(*info, emlrt_marshallOut("length"), "name", 13);
  emlrtAddField(*info, emlrt_marshallOut("cell"), "dominantType", 13);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elmat/length.m"), "resolved", 13);
  emlrtAddField(*info, b_emlrt_marshallOut(1303146206U), "fileTimeLo", 13);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 13);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 13);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 13);
  emlrtAssign(&rhs13, emlrtCreateCellArray(0));
  emlrtAssign(&lhs13, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs13), "rhs", 13);
  emlrtAddField(*info, emlrtAliasP(lhs13), "lhs", 13);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXE]$matlabroot$/toolbox/matlab/system/+matlab/+system/pvParse.p"),
                "context", 14);
  emlrtAddField(*info, emlrt_marshallOut("rem"), "name", 14);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 14);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/rem.m"), "resolved", 14);
  emlrtAddField(*info, b_emlrt_marshallOut(1363713854U), "fileTimeLo", 14);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 14);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 14);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 14);
  emlrtAssign(&rhs14, emlrtCreateCellArray(0));
  emlrtAssign(&lhs14, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs14), "rhs", 14);
  emlrtAddField(*info, emlrtAliasP(lhs14), "lhs", 14);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/rem.m"), "context", 15);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.isBuiltInNumeric"),
                "name", 15);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 15);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXE]$matlabroot$/toolbox/shared/coder/coder/+coder/+internal/isBuiltInNumeric.m"),
                "resolved", 15);
  emlrtAddField(*info, b_emlrt_marshallOut(1363714556U), "fileTimeLo", 15);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 15);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 15);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 15);
  emlrtAssign(&rhs15, emlrtCreateCellArray(0));
  emlrtAssign(&lhs15, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs15), "rhs", 15);
  emlrtAddField(*info, emlrtAliasP(lhs15), "lhs", 15);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/rem.m"), "context", 16);
  emlrtAddField(*info, emlrt_marshallOut("eml_scalar_eg"), "name", 16);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 16);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalar_eg.m"), "resolved",
                16);
  emlrtAddField(*info, b_emlrt_marshallOut(1286818796U), "fileTimeLo", 16);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 16);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 16);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 16);
  emlrtAssign(&rhs16, emlrtCreateCellArray(0));
  emlrtAssign(&lhs16, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs16), "rhs", 16);
  emlrtAddField(*info, emlrtAliasP(lhs16), "lhs", 16);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/rem.m"), "context", 17);
  emlrtAddField(*info, emlrt_marshallOut("eml_scalexp_alloc"), "name", 17);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 17);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalexp_alloc.m"),
                "resolved", 17);
  emlrtAddField(*info, b_emlrt_marshallOut(1358186140U), "fileTimeLo", 17);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 17);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 17);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 17);
  emlrtAssign(&rhs17, emlrtCreateCellArray(0));
  emlrtAssign(&lhs17, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs17), "rhs", 17);
  emlrtAddField(*info, emlrtAliasP(lhs17), "lhs", 17);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/dsp/dsp/+dspcodegen/BiquadFilter.p"), "context",
                18);
  emlrtAddField(*info, emlrt_marshallOut("dspcodegen.BiquadFilter"), "name", 18);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 18);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/dsp/dsp/+dspcodegen/BiquadFilter.p"), "resolved",
                18);
  emlrtAddField(*info, b_emlrt_marshallOut(1375996936U), "fileTimeLo", 18);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 18);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 18);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 18);
  emlrtAssign(&rhs18, emlrtCreateCellArray(0));
  emlrtAssign(&lhs18, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs18), "rhs", 18);
  emlrtAddField(*info, emlrtAliasP(lhs18), "lhs", 18);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/dsp/dsp/+dspcodegen/BiquadFilter.p"), "context",
                19);
  emlrtAddField(*info, emlrt_marshallOut("get"), "name", 19);
  emlrtAddField(*info, emlrt_marshallOut("dsp.BiquadFilter"), "dominantType", 19);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/fixedpoint/get.m"), "resolved", 19);
  emlrtAddField(*info, b_emlrt_marshallOut(1373632316U), "fileTimeLo", 19);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 19);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 19);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 19);
  emlrtAssign(&rhs19, emlrtCreateCellArray(0));
  emlrtAssign(&lhs19, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs19), "rhs", 19);
  emlrtAddField(*info, emlrtAliasP(lhs19), "lhs", 19);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/shared/system/coder/+matlab/+system/+coder/SystemCore.p"),
                "context", 20);
  emlrtAddField(*info, emlrt_marshallOut("matlab.system.coder.SystemCore"),
                "name", 20);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 20);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/shared/system/coder/+matlab/+system/+coder/SystemCore.p"),
                "resolved", 20);
  emlrtAddField(*info, b_emlrt_marshallOut(1373635994U), "fileTimeLo", 20);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 20);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 20);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 20);
  emlrtAssign(&rhs20, emlrtCreateCellArray(0));
  emlrtAssign(&lhs20, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs20), "rhs", 20);
  emlrtAddField(*info, emlrtAliasP(lhs20), "lhs", 20);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/dsp/dsp/+dspcodegen/BiquadFilter.p"), "context",
                21);
  emlrtAddField(*info, emlrt_marshallOut("getNumInputs"), "name", 21);
  emlrtAddField(*info, emlrt_marshallOut("dsp.BiquadFilter"), "dominantType", 21);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/scomp/getNumInputs.m"), "resolved", 21);
  emlrtAddField(*info, b_emlrt_marshallOut(1349878748U), "fileTimeLo", 21);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 21);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 21);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 21);
  emlrtAssign(&rhs21, emlrtCreateCellArray(0));
  emlrtAssign(&lhs21, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs21), "rhs", 21);
  emlrtAddField(*info, emlrtAliasP(lhs21), "lhs", 21);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/scomp/getNumInputs.m"), "context", 22);
  emlrtAddField(*info, emlrt_marshallOut("checkSystemObjectInput"), "name", 22);
  emlrtAddField(*info, emlrt_marshallOut("dsp.BiquadFilter"), "dominantType", 22);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/scomp/checkSystemObjectInput.m"),
                "resolved", 22);
  emlrtAddField(*info, b_emlrt_marshallOut(1349878746U), "fileTimeLo", 22);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 22);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 22);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 22);
  emlrtAssign(&rhs22, emlrtCreateCellArray(0));
  emlrtAssign(&lhs22, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs22), "rhs", 22);
  emlrtAddField(*info, emlrtAliasP(lhs22), "lhs", 22);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/dsp/dsp/+dspcodegen/BiquadFilter.p"), "context",
                23);
  emlrtAddField(*info, emlrt_marshallOut("setup"), "name", 23);
  emlrtAddField(*info, emlrt_marshallOut("dsp.BiquadFilter"), "dominantType", 23);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/scomp/setup.m"), "resolved", 23);
  emlrtAddField(*info, b_emlrt_marshallOut(1349878750U), "fileTimeLo", 23);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 23);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 23);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 23);
  emlrtAssign(&rhs23, emlrtCreateCellArray(0));
  emlrtAssign(&lhs23, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs23), "rhs", 23);
  emlrtAddField(*info, emlrtAliasP(lhs23), "lhs", 23);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/scomp/setup.m"), "context", 24);
  emlrtAddField(*info, emlrt_marshallOut("checkSystemObjectInput"), "name", 24);
  emlrtAddField(*info, emlrt_marshallOut("dsp.BiquadFilter"), "dominantType", 24);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/scomp/checkSystemObjectInput.m"),
                "resolved", 24);
  emlrtAddField(*info, b_emlrt_marshallOut(1349878746U), "fileTimeLo", 24);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 24);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 24);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 24);
  emlrtAssign(&rhs24, emlrtCreateCellArray(0));
  emlrtAssign(&lhs24, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs24), "rhs", 24);
  emlrtAddField(*info, emlrtAliasP(lhs24), "lhs", 24);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/dsp/dsp/+dspcodegen/BiquadFilter.p"), "context",
                25);
  emlrtAddField(*info, emlrt_marshallOut("reset"), "name", 25);
  emlrtAddField(*info, emlrt_marshallOut("dsp.BiquadFilter"), "dominantType", 25);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/scomp/reset.m"), "resolved", 25);
  emlrtAddField(*info, b_emlrt_marshallOut(1349878750U), "fileTimeLo", 25);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 25);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 25);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 25);
  emlrtAssign(&rhs25, emlrtCreateCellArray(0));
  emlrtAssign(&lhs25, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs25), "rhs", 25);
  emlrtAddField(*info, emlrtAliasP(lhs25), "lhs", 25);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/scomp/reset.m"), "context", 26);
  emlrtAddField(*info, emlrt_marshallOut("checkSystemObjectInput"), "name", 26);
  emlrtAddField(*info, emlrt_marshallOut("dsp.BiquadFilter"), "dominantType", 26);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/scomp/checkSystemObjectInput.m"),
                "resolved", 26);
  emlrtAddField(*info, b_emlrt_marshallOut(1349878746U), "fileTimeLo", 26);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 26);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 26);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 26);
  emlrtAssign(&rhs26, emlrtCreateCellArray(0));
  emlrtAssign(&lhs26, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs26), "rhs", 26);
  emlrtAddField(*info, emlrtAliasP(lhs26), "lhs", 26);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/dsp/dsp/+dspcodegen/BiquadFilter.p"), "context",
                27);
  emlrtAddField(*info, emlrt_marshallOut("getNumOutputs"), "name", 27);
  emlrtAddField(*info, emlrt_marshallOut("dsp.BiquadFilter"), "dominantType", 27);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/scomp/getNumOutputs.m"), "resolved", 27);
  emlrtAddField(*info, b_emlrt_marshallOut(1349878748U), "fileTimeLo", 27);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 27);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 27);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 27);
  emlrtAssign(&rhs27, emlrtCreateCellArray(0));
  emlrtAssign(&lhs27, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs27), "rhs", 27);
  emlrtAddField(*info, emlrtAliasP(lhs27), "lhs", 27);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/scomp/getNumOutputs.m"), "context", 28);
  emlrtAddField(*info, emlrt_marshallOut("checkSystemObjectInput"), "name", 28);
  emlrtAddField(*info, emlrt_marshallOut("dsp.BiquadFilter"), "dominantType", 28);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/scomp/checkSystemObjectInput.m"),
                "resolved", 28);
  emlrtAddField(*info, b_emlrt_marshallOut(1349878746U), "fileTimeLo", 28);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 28);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 28);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 28);
  emlrtAssign(&rhs28, emlrtCreateCellArray(0));
  emlrtAssign(&lhs28, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs28), "rhs", 28);
  emlrtAddField(*info, emlrtAliasP(lhs28), "lhs", 28);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/dsp/dsp/+dspcodegen/BiquadFilter.p"), "context",
                29);
  emlrtAddField(*info, emlrt_marshallOut("output"), "name", 29);
  emlrtAddField(*info, emlrt_marshallOut("dsp.BiquadFilter"), "dominantType", 29);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/scomp/output.m"), "resolved", 29);
  emlrtAddField(*info, b_emlrt_marshallOut(1349878748U), "fileTimeLo", 29);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 29);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 29);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 29);
  emlrtAssign(&rhs29, emlrtCreateCellArray(0));
  emlrtAssign(&lhs29, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs29), "rhs", 29);
  emlrtAddField(*info, emlrtAliasP(lhs29), "lhs", 29);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/scomp/output.m"), "context", 30);
  emlrtAddField(*info, emlrt_marshallOut("checkSystemObjectInput"), "name", 30);
  emlrtAddField(*info, emlrt_marshallOut("dsp.BiquadFilter"), "dominantType", 30);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/scomp/checkSystemObjectInput.m"),
                "resolved", 30);
  emlrtAddField(*info, b_emlrt_marshallOut(1349878746U), "fileTimeLo", 30);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 30);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 30);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 30);
  emlrtAssign(&rhs30, emlrtCreateCellArray(0));
  emlrtAssign(&lhs30, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs30), "rhs", 30);
  emlrtAddField(*info, emlrtAliasP(lhs30), "lhs", 30);
  emlrtAddField(*info, emlrt_marshallOut(
    "[IXC]$matlabroot$/toolbox/dsp/dsp/+dspcodegen/BiquadFilter.p"), "context",
                31);
  emlrtAddField(*info, emlrt_marshallOut("update"), "name", 31);
  emlrtAddField(*info, emlrt_marshallOut("dsp.BiquadFilter"), "dominantType", 31);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/scomp/update.m"), "resolved", 31);
  emlrtAddField(*info, b_emlrt_marshallOut(1349878752U), "fileTimeLo", 31);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 31);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 31);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 31);
  emlrtAssign(&rhs31, emlrtCreateCellArray(0));
  emlrtAssign(&lhs31, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs31), "rhs", 31);
  emlrtAddField(*info, emlrtAliasP(lhs31), "lhs", 31);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/scomp/update.m"), "context", 32);
  emlrtAddField(*info, emlrt_marshallOut("checkSystemObjectInput"), "name", 32);
  emlrtAddField(*info, emlrt_marshallOut("dsp.BiquadFilter"), "dominantType", 32);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/scomp/checkSystemObjectInput.m"),
                "resolved", 32);
  emlrtAddField(*info, b_emlrt_marshallOut(1349878746U), "fileTimeLo", 32);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 32);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 32);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 32);
  emlrtAssign(&rhs32, emlrtCreateCellArray(0));
  emlrtAssign(&lhs32, emlrtCreateCellArray(0));
  emlrtAddField(*info, emlrtAliasP(rhs32), "rhs", 32);
  emlrtAddField(*info, emlrtAliasP(lhs32), "lhs", 32);
  emlrtDestroyArray(&rhs0);
  emlrtDestroyArray(&lhs0);
  emlrtDestroyArray(&rhs1);
  emlrtDestroyArray(&lhs1);
  emlrtDestroyArray(&rhs2);
  emlrtDestroyArray(&lhs2);
  emlrtDestroyArray(&rhs3);
  emlrtDestroyArray(&lhs3);
  emlrtDestroyArray(&rhs4);
  emlrtDestroyArray(&lhs4);
  emlrtDestroyArray(&rhs5);
  emlrtDestroyArray(&lhs5);
  emlrtDestroyArray(&rhs6);
  emlrtDestroyArray(&lhs6);
  emlrtDestroyArray(&rhs7);
  emlrtDestroyArray(&lhs7);
  emlrtDestroyArray(&rhs8);
  emlrtDestroyArray(&lhs8);
  emlrtDestroyArray(&rhs9);
  emlrtDestroyArray(&lhs9);
  emlrtDestroyArray(&rhs10);
  emlrtDestroyArray(&lhs10);
  emlrtDestroyArray(&rhs11);
  emlrtDestroyArray(&lhs11);
  emlrtDestroyArray(&rhs12);
  emlrtDestroyArray(&lhs12);
  emlrtDestroyArray(&rhs13);
  emlrtDestroyArray(&lhs13);
  emlrtDestroyArray(&rhs14);
  emlrtDestroyArray(&lhs14);
  emlrtDestroyArray(&rhs15);
  emlrtDestroyArray(&lhs15);
  emlrtDestroyArray(&rhs16);
  emlrtDestroyArray(&lhs16);
  emlrtDestroyArray(&rhs17);
  emlrtDestroyArray(&lhs17);
  emlrtDestroyArray(&rhs18);
  emlrtDestroyArray(&lhs18);
  emlrtDestroyArray(&rhs19);
  emlrtDestroyArray(&lhs19);
  emlrtDestroyArray(&rhs20);
  emlrtDestroyArray(&lhs20);
  emlrtDestroyArray(&rhs21);
  emlrtDestroyArray(&lhs21);
  emlrtDestroyArray(&rhs22);
  emlrtDestroyArray(&lhs22);
  emlrtDestroyArray(&rhs23);
  emlrtDestroyArray(&lhs23);
  emlrtDestroyArray(&rhs24);
  emlrtDestroyArray(&lhs24);
  emlrtDestroyArray(&rhs25);
  emlrtDestroyArray(&lhs25);
  emlrtDestroyArray(&rhs26);
  emlrtDestroyArray(&lhs26);
  emlrtDestroyArray(&rhs27);
  emlrtDestroyArray(&lhs27);
  emlrtDestroyArray(&rhs28);
  emlrtDestroyArray(&lhs28);
  emlrtDestroyArray(&rhs29);
  emlrtDestroyArray(&lhs29);
  emlrtDestroyArray(&rhs30);
  emlrtDestroyArray(&lhs30);
  emlrtDestroyArray(&rhs31);
  emlrtDestroyArray(&lhs31);
  emlrtDestroyArray(&rhs32);
  emlrtDestroyArray(&lhs32);
}

static const mxArray *emlrt_marshallOut(const char * u)
{
  const mxArray *y;
  const mxArray *m0;
  y = NULL;
  m0 = mxCreateString(u);
  emlrtAssign(&y, m0);
  return y;
}

static const mxArray *b_emlrt_marshallOut(uint32_T u)
{
  const mxArray *y;
  const mxArray *m1;
  y = NULL;
  m1 = mxCreateNumericMatrix(1, 1, mxUINT32_CLASS, mxREAL);
  *(uint32_T *)mxGetData(m1) = u;
  emlrtAssign(&y, m1);
  return y;
}

MEXFUNCTION_LINKAGE mxArray *emlrtMexFcnProperties(void);
mxArray *emlrtMexFcnProperties()
{
  const char *mexProperties[] = {
    "Version",
    "ResolvedFunctions",
    "EntryPoints",
    "CoverageInfo",
    NULL };

  const char *epProperties[] = {
    "Name",
    "NumberOfInputs",
    "NumberOfOutputs",
    "ConstantInputs" };

  mxArray *xResult = mxCreateStructMatrix(1,1,4,mexProperties);
  mxArray *xEntryPoints = mxCreateStructMatrix(1,1,4,epProperties);
  mxArray *xInputs = NULL;
  xInputs = mxCreateLogicalMatrix(1, 1);
  mxSetFieldByNumber(xEntryPoints, 0, 0, mxCreateString("testiir"));
  mxSetFieldByNumber(xEntryPoints, 0, 1, mxCreateDoubleScalar(1));
  mxSetFieldByNumber(xEntryPoints, 0, 2, mxCreateDoubleScalar(1));
  mxSetFieldByNumber(xEntryPoints, 0, 3, xInputs);
  mxSetFieldByNumber(xResult, 0, 0, mxCreateString("8.2.0.701 (R2013b)"));
  mxSetFieldByNumber(xResult, 0, 1, (mxArray*)emlrtMexFcnResolvedFunctionsInfo());
  mxSetFieldByNumber(xResult, 0, 2, xEntryPoints);
  return xResult;
}

/* End of code generation (_coder_testiir_info.c) */
