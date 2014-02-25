%% Testbench for eq/shelving+notch filters
% For frequency and impulse response analysis and
%
% by Preben Thorød - 
% Gr 6 DAT096 - HandyEq - Chalmers University of Technology
% Using shelving() function by Jeff Tackett 08/22/05, Based on DAFX book
% and Zölner calculations and formulas for biquad filters.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Testbench options
N = 1024;       %fft window size for freq analysis
single = 1;     % Single(1) or multiple filter curves
bodegen = 1;    % Bodeplot(1) or freqz (0)
FreqScale = 'log'; %'linear' or 'log'

%% System parameters
Fs = 41000;     %Hz
Fsw = Fs*2*pi;  %sample rate rad/s
Ts=1/Fs;

%% Filter specification input parameters
    %% Treble shelving filter
    fcTreb = 4500;       % Cutoff frequency
    GsTreb = 12;        % Single coeffisient set, gain in dB
    GmTreb = [-12 -9 -6 -3 0 3 6 9 12];  % Coeffisient vector, multiple gain levels
    QTreb = 1.0;                  % Q-factor
    typeTreb = 'Treble_Shelf';      % 'Base_Shelf' or 'Treble_Shelf'
    
    %% Bass shelving filter
    fcBass = 500;       % Cutoff frequency
    GsBass = 12;        % Single coeffisient set, gain in dB
    GmBass = [-12 -9 -6 -3 0 3 6 9 12];  % Coeffisient vector, multiple gain levels
    QBass = 0.8;                  % Q-factor
    typeBass = 'Base_Shelf';      % 'Base_Shelf' or 'Treble_Shelf'


%% SINGLE COEFFISIENT SET
if single == 1 
    %% Generate filter coefficient         
        [ATreb,BTreb] = shelving(GsTreb, fcTreb, Fs, QTreb, typeTreb);
        [ABass,BBass] = shelving(GsBass, fcBass, Fs, QBass, typeBass);
    %% Generate plot
    if bodegen ==1
        %bodeplot
        tfdBass = tf(ABass,BBass,Ts)   %Discrete transfer function
        tfdTreb = tf(ATreb,BTreb,Ts)   %Discrete transfer function       
        tfdTot = series(tfdBass,tfdTreb)
        hbode = bodeplot(tfdTot);  
        setoptions(hbode,'FreqUnits', 'Hz','FreqScale', FreqScale, 'Xlim',[10 Fs/2]);
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
