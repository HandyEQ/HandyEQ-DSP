%% Testbench for eq/shelving+notch filters
% For frequency and impulse response analysis and
%
% by Preben Thorød - Gr 6 DAT096 - HandyEq - Chalmers University of Technology
% Using shelving() function by Jeff Tackett 08/22/05, Based on DAFX book
% and Zölner calculations and formulas for biquad filters.

%% System and analyzis parameters
Fs = 41000; %Hz
N = 1024; %FFt window size

%% Filter specification/ input parameters
fc = 500; % Cutoff frequency
G = 12;  % Gain in db
Q = 1; % Q-factor
type = 'Base_Shelf'; % 'Base_Shelf' or 'Treble_Shelf'


% fc and G is dependent, if fc = 500, and G = 12  "damping_band = -12db
% until 500Hz, then magnitude is -12db+3db  (Need to check out this logic
% closer!!!!

Q = 1; % Q-factor
type = 'Base_Shelf'; % 'Base_Shelf' or 'Treble_Shelf'



%% Generate filter coefficient 
[b,a] = shelving(G, fc, Fs, Q, type);



%% Generate plot
%[H, f] = freqz(a,b,N,Fs);
freqz(a,b,N,Fs);


%% Output and save plot
