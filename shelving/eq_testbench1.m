%% Testbench for eq/shelving+notch filters
% For frequency and impulse response analysis and
%
% by Preben Thorød - 
% Gr 6 DAT096 - HandyEq - Chalmers University of Technology
% Using shelving() function by Jeff Tackett 08/22/05, Based on DAFX book
% and Zölner calculations and formulas for biquad filters.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% System and analyzis parameters
Fs = 41000;     %Hz
Fsw = Fs*2*pi;  %sample rate rad/s
Ts=1/Fs;

%Testbench options
N = 1024;       %fft window size for freq analysis
single = 1;     % Single(1) or multiple filter curves
bodegen = 1;    % Bodeplot(1) or freqz (0)
FreqScale = 'linear'; %'linear' or 'log'

%% Filter specification/ input parameters
fc = 800;       % Cutoff frequency
Gs = 12;        % Single coeffisient set, gain in dB
Gm = [-12 -9 -6 -3 0 3 6 9 12];  % Coeffisient vektor, multiple gain levels
Q = 0.8;                  % Q-factor
type = 'Base_Shelf';      % 'Base_Shelf' or 'Treble_Shelf'

% fc and G is dependent, if fc = 500, and G = 12  "damping_band = -12db
% until 500Hz, then magnitude is -12db+3db  
% Need to check out this logic closer!!!!


%% SINGLE COEFFISIENT SET
if single == 0 
    %% Generate filter coefficient 
        [b,a] = shelving(Gs, fc, Fs, Q, type);
    %% Generate plot
    if bodegen ==1
        %bodeplot
        tfd = tf(a,b,Ts);   %Discrete transfer function
        hbode = bodeplot(tfd);  
        setoptions(hbode,'FreqUnits', 'Hz','FreqScale', FreqScale, 'Xlim',[0 Fs/2]);
    else
        %freqz plot
        freqz(a,b,N,Fs);
    end
    
%% MULTIPLE COEFFISIENT SET
else 
    B = cell(1,length(Gm));
    A = cell(1,length(Gm));
    H = cell(1,length(Gm));
    tfd = cell(1,length(Gm));
    if bodegen == 1
        %bodeplot
        for i = 1:length(Gm)
            % Generate coefficients 
            [B{i}, A{i}] = shelving(Gm(i), fc, Fs, Q, 'Base_Shelf');        
            tfd = tf(A{i},B{i},Ts);
            hold on;
            hbode = bodeplot(tfd);
            setoptions(hbode,'FreqUnits', 'Hz','FreqScale', FreqScale, 'Xlim',[0 Fs/2]); %doc plotoptions
        end
    else
        %freqz plot
        for i = 1:length(Gm)
            % Generate coefficient vector
            [B{i}, A{i}] = shelving(Gm(i), fc, Fs, Q, 'Base_Shelf');            
            hold on;            
            freqz(A{i},B{i},N,Fs);            
        end         
    end 
end 



%% Output and save plot
