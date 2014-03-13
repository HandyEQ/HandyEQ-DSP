function [ b, a ] = peak( G, fc, fs, Q )
% Function for generation of peak/notch filter coefficients for second
% order billinear IIR filter. Preben Thorød 2014
% Based on transferfunctions and formulas given in "Digital Audio Signal
% Processing" - //Author

% Tested in simulink, working.

K = tan((pi * fc)/fs);
V0 = 10^(G/20);
root2 = 1/Q; %sqrt(2)

%!!DAFX, Natås, matlab and shelving script uses H(z) (b0 +b1z-1 + b2z-1 / 1 + a1z-1 a2z-2) 
%(Canonical filter), but DSP book is using opposite.

if ( G > 0 )
    %Peak boost:
    b0 =   (1 + V0*root2*K + K^2) / (1 + root2*K + K^2);  %a0 in book
    b1 =         (2 * (K^2 - 1) ) / (1 + root2*K + K^2);
    b2 =   (1 - V0*root2*K + K^2) / (1 + root2*K + K^2);
    a1 =         (2 * (K^2 - 1) ) / (1 + root2*K + K^2);
    a2 =      (1 - root2*K + K^2) / (1 + root2*K + K^2);
elseif ( G < 0 )
    %Peak cut:
    b0 =        (1 + root2*K + K^2) / (1 + (root2*K)/V0 + K^2);  %a0 in book
    b1 =           (2 * (K^2 - 1) ) / (1 + (root2*K)/V0 + K^2);
    b2 =        (1 - root2*K + K^2) / (1 + (root2*K)/V0 + K^2);
    a1 =           (2 * (K^2 - 1) ) / (1 + (root2*K)/V0 + K^2);
    a2 =   (1 - (root2*K)/V0 + K^2) / (1 + (root2*K)/V0 + K^2);
else
    %Allpass
    b0 = V0;
    b1 = 0;
    b2 = 0;
    a1 = 0;
    a2 = 0;
end
a = [  1, a1, a2];
b = [ b0, b1, b2];



