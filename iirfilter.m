function Hd = iirfilter
%IIRFILTER Returns a discrete-time filter System object.

% MATLAB Code
% Generated by MATLAB(R) 8.2 and the DSP System Toolbox 8.5.
% Generated on: 28-Mar-2014 11:00:47

Fpass = 15000;   % Passband Frequency
Fstop = 16000;   % Stopband Frequency
Apass = 1;       % Passband Ripple (dB)
Astop = 85;      % Stopband Attenuation (dB)
Fs    = 480000;  % Sampling Frequency

h = fdesign.lowpass('fp,fst,ap,ast', Fpass, Fstop, Apass, Astop, Fs);

Hd = design(h, 'ellip', ...
    'MatchExactly', 'both', ...
    'SystemObject', true);



