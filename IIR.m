%% Start by simulating analog filter behaviour. First order of the filter by using buttord, cheb1ord, cheb2ord, ellipord.
%% Then besself, butter, cheby1, cheby2, ellip.

fs = 480e3; %Sampling frequency
f = 15e3; %Frequency of signal
nf = f/(fs/2) %Normalizied frequency