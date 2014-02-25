%% Testbench for eq/shelving+notch filters
% For frequency and impulse response analysis and
%
% by Preben Thorød - 
% Gr 6 DAT096 - HandyEq - Chalmers University of Technology
% Using shelving() function by Jeff Tackett 08/22/05, Based on DAFX book
% and Zölner calculations and formulas for biquad filters.
%%


%% 0225 TODO: for multiple:
% Freqz not fixed, 
% Way to plot total transferfunction, simplified
% - Uneven nr of coeff vectors for the different filters
% multiple transferfunction (just max/min/neutral)
% 
% ..later: Split coeffisient generation from plot functions (make actual
% functions?)
% 
% Notch filter -> test in own file first.
% Verify tf(), etc for order of num and dec.


%% Testbench options
N = 1024;       %fft window size for freq analysis
single = 0;     % Single(1) or multiple filter curves
bodegen = 1;    % Bodeplot(1) or freqz (0)
FreqScale = 'log'; %'linear' or 'log'

%% System parameters
Fs = 41000;     %Hz
Fsw = Fs*2*pi;  %sample rate rad/s
Ts=1/Fs;

%% Filter specification input parameters
    
    
    %% Treble shelving filter
    %NB: Uneven number of filter coefficient is not handled yet!!!
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
        [BTreb,ATreb] = shelving(GsTreb, fcTreb, Fs, QTreb, typeTreb);
        [BBass,ABass] = shelving(GsBass, fcBass, Fs, QBass, typeBass);
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
    ATreb = cell(1,length(GmTreb));
    BTreb = cell(1,length(GmTreb));
    ABass = cell(1,length(GmBass));
    BBass = cell(1,length(GmBass));
    HTreb = cell(1,length(GmTreb));
    HBass = cell(1,length(GmBass));
    tfdTreb = cell(1,length(GmTreb));
    tfdBass = cell(1,length(GmBass));  
    GmTotLength = max([length(GmBass) length(GmTreb)])
    tftTot = cell(1,GmTotLength); 
    if bodegen == 1
        %bodeplot
        for i = 1:GmTotLength %!!!!!!!!!!!!!!!!!!!
            % Generate coefficients 
            [BTreb{i}, ATreb{i}] = shelving(GmTreb(i), fcTreb, Fs, QTreb, 'Treble_Shelf');
            [BBass{i}, ABass{i}] = shelving(GmBass(i), fcBass, Fs, QBass, 'Base_Shelf');                            
            tfdTreb{i} = tf(ATreb{i},BTreb{i},Ts);
            tfdBass{i} = tf(ABass{i},BBass{i},Ts);
            hold on;
            % test: treble plot
            hbodeTreb = bodeplot(tfdTreb{i},'b');            
            % test: treble plot
            hbodeBass = bodeplot(tfdBass{i},'g');            
        end
        setoptions(hbodeBass,'FreqUnits', 'Hz','FreqScale', FreqScale, 'Xlim',[10 Fs/2]); %doc plotoptions
        
        % TEST, neutral position: 
        tfdNull = series(tfdBass{5},tfdTreb{5}); % Not dynamic!!!!!
        hnull = bodeplot(tfdNull, 'r');
        
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
