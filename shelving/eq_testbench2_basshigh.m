%% Testbench for eq/shelving+notch filters
% For frequency and impulse response analysis and
%
% by Preben Thor�d - 
% Gr 6 DAT096 - HandyEq - Chalmers University of Technology
% Using shelving() function by Jeff Tackett 08/22/05, Based on DAFX book
% and Z�lner calculations and formulas for biquad filters.

%% 0302 TODO: 
% Way to plot total transferfunction, simplified ( OR extreme cases,
% combined series transferfunction
% - Uneven nr of coeff vectors for the different filters
% Notch filter -> test in own file first.
% Make unique plot of combined series transferfuction "red line" / own
% plot

% Coeff control for testbench(testbench1 first)
% Need to verify coeff order for root locus plot
% Change root locus plot to "plane()

%% Testbench options
N = 1024;       %fft window size for freq analysis
single = 0;     % Single(1) or multiple filter curves
bodegen = 1;    % Bodeplot(1) or freqz (0)
rootlocus = 0;  % Show root locus plot
FreqScale = 'log'; %'linear' or 'log'

%% System parameters
Fs = 41000;     %Hz
Fsw = Fs*2*pi;  %sample rate rad/s
Ts=1/Fs;

%% Filter specification input parameters
    
    
    %% Treble shelving filter
    %NB: Uneven number of filter coefficient is not handled yet!!!
    fcTreb = 5000;       % Cutoff frequency
    GsTreb = 12;        % Single coeffisient set, gain in dB
    %GmTreb = [0 0 0 0 0 3 6 9 12];  % Coeffisient vector, multiple gain levels
    GmTreb = [-12 -9 -6 -3 0 3 6 9 12];  % Coeffisient vector, multiple gain levels
    QTreb = 1.0;                  % Q-factor
    typeTreb = 'Treble_Shelf';      % 'Base_Shelf' or 'Treble_Shelf'
    
    %% Bass shelving filter
    fcBass = 200;       % Cutoff frequency
    GsBass = -12;        % Single coeffisient set, gain in dB
    GmBass = [-12 -9 -6 -3 0 3 6 9 12];  % Coeffisient vector, multiple gain levels
    QBass = 1.0;                  % Q-factor
    typeBass = 'Base_Shelf';      % 'Base_Shelf' or 'Treble_Shelf'


%% SINGLE COEFFISIENT SET
if single == 1 
    %% Generate filter coefficient         
        [BTreb,ATreb] = shelving(GsTreb, fcTreb, Fs, QTreb, typeTreb);
        [BBass,ABass] = shelving(GsBass, fcBass, Fs, QBass, typeBass);
    %% Generate plot
    if bodegen ==1
        %bodeplot
        tfdBass = tf(BBass,ABass,Ts)   %Discrete transfer function
        tfdTreb = tf(BTreb,ATreb,Ts)   %Discrete transfer function       
        tfdTot = series(tfdBass,tfdTreb)
        hbode = bodeplot(tfdTot);  
        setoptions(hbode,'FreqUnits', 'Hz','FreqScale', FreqScale, 'Xlim',[10 Fs/2]);
    else
        %freqz plot 
        %freqz(a,b,N,Fs);
    end
    
    if rootlocus == 1
         figure
         rlocus(ABass,BBass)     
    end
    
%% MULTIPLE COEFFISIENT SET
else
    % Generate Coefficients and transferfunctions:
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
    
    for i = 1:GmTotLength %!!!!!
        [BTreb{i}, ATreb{i}] = shelving(GmTreb(i), fcTreb, Fs, QTreb, 'Treble_Shelf');
        [BBass{i}, ABass{i}] = shelving(GmBass(i), fcBass, Fs, QBass, 'Base_Shelf');                            
        tfdTreb{i} = tf(BTreb{i},ATreb{i},Ts);
        tfdBass{i} = tf(BBass{i},ABass{i},Ts);                     
    end
    
    if bodegen == 1
        % Separete graphs for each filter
        for i = 1:GmTotLength %!!!!!!!!!!!!!!!!!!!
            hold on;
            % Treble plot:
            hbodeTreb = bodeplot(tfdTreb{i},'b');            
            % Bass plot:
            hbodeBass = bodeplot(tfdBass{i},'g');            
        end
        setoptions(hbodeBass,'FreqUnits', 'Hz','FreqScale', FreqScale, 'Xlim',[10 Fs/2]); %doc plotoptions
        % red 0-setting:
        tfdNull = series(tfdBass{5},tfdTreb{5}); % Not dynamic!!!!!
        hnull = bodeplot(tfdNull, 'r');
        hold off;
   
    end
    
    if rootlocus == 1
         figure
         subplot(2,1,1);
         for i = 1:GmTotLength %!!!!!!!!!!!!!!!!!!!
            rlocus(BBass{i},ABass{i})  
            hold on;           
         end
         title('Root Locus - Bass Filter')
         
         subplot(2,1,2);
         for i = 1:GmTotLength %!!!!!!!!!!!!!!!!!!!
            rlocus(BTreb{i},ATreb{i})  
            hold on;           
         end
         title('Root Locus - Treble Filter')
        hold off;
    end
end 



%% Output and save plot
