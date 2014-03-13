%% Testbench for eq/shelving+notch filters
% For frequency and impulse response analysis and
%
% by Preben Thorød - 
% Gr 6 DAT096 - HandyEq - Chalmers University of Technology
% Using peak() function  Based on DAFX book
% and Zölner calculations and formulas for biquad filters.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% TODO:
% Change root locus plot to zplane()

% 0313: Next to do: Make structured testbench and generator for 3-stage
% signal chain

%% Return values:
%   a = [  1, a1, a2];
%   b = [ b0, b1, b2];

%% Testbench options
N = 128;       %fft window size for freq analysis
single = 0;     % Single(1) or multiple filter curves and coefficients
bodegen = 1;    % Bodeplot(1) or freqz (0)
rootlocus = 0;  % Show root locus plot
FreqScale = 'log'; %'linear' or 'log'

%% System parameters
Fs = 41000;     %Hz
Fsw = Fs*2*pi;  %sample rate rad/s
Ts=1/Fs;

%% Filter specification/ input parameters
    %Peak filter, different gain, constant fc
    fc = 2500;         % Cutoff frequency
    Gs = -12;        % Single coeffisient set, gain in dB
    Gm = [12 9 6 3 0 -3 -6 -9 -12 -18]; % Coeffisient vector, multiple gain levels
    %Q = 1.25;                  % Q-factor
     Q = 3.25;
%% SINGLE COEFFISIENT SET
if single == 1 
    %% Generate filter coefficient 
        [b,a] = peak(Gs, fc, Fs, Q);
    %% Generate plot
    if bodegen ==1
        %bodeplot
        tfd = tf(b,a,Ts);   %Discrete transfer function 
        filt(b,a)           %Print transfer function on DSP-format
        hbode = bodeplot(tfd);  
        %setoptions(hbode,'FreqUnits', 'Hz','FreqScale', FreqScale, 'Xlim',[10 Fs/2]);
        setoptions(hbode,'FreqUnits', 'Hz','FreqScale', FreqScale, 'Xlim',[10 10*Fs/2]);
        sos = [b a]         % SOS 1x6 Matrix for simulink model
    else
        %freqz plot
        freqz(a,b,N,Fs); %verify that this a,b input parameter makes sense, "works, but not mentioned in doc"
    end    
    if rootlocus == 1
         figure
         rlocus(b,a)     
    end
%% MULTIPLE COEFFISIENT SET
else
    % Generate coefficients and transferfunctions:
    N_coeff = length(Gm);
    B = cell(1,N_coeff);
    A = cell(1,N_coeff);
    H = cell(1,N_coeff);
    tfd = cell(1,N_coeff);
    if length(fc) > 1
        for i = 1:N_coeff        
            [B{i}, A{i}] = peak(Gm(i), fc(i), Fs, Q);        
            tfd{i} = tf(B{i},A{i},Ts);
        end
    else
        for i = 1:N_coeff
            [B{i}, A{i}] = peak(Gm(i), fc, Fs, Q);        
            tfd{i} = tf(B{i},A{i},Ts);
        end
    end
    
    % Plot:
    if bodegen == 1    
        % Bode plot
        for i = 1:length(Gm)
            hbode = bodeplot(tfd{i});
            hold on;
            setoptions(hbode,'FreqUnits', 'Hz','FreqScale', FreqScale, 'Xlim',[10 Fs/2]); %doc plotoptions
        end
        hold off;
    else
        %freqz plot
        for i = 1:length(Gm)
            hold on;            
            freqz(A{i},B{i},N,Fs);            
        end         
    end 
    
    if rootlocus == 1
        figure
        for i = 1:N_coeff 
            rlocus(B{i},A{i})  
            hold on;           
        end
        hold off;
    end
end 



%% Output and save plot
