%% Testbench for eq/shelving+notch filters
% For frequency and impulse response analysis and
%
% by Preben Thorød - 
% Gr 6 DAT096 - HandyEq - Chalmers University of Technology
% Using shelving() function by Jeff Tackett 08/22/05, Based on DAFX book
% and Zölner calculations and formulas for biquad filters.
% Using own peak() function to calculate peak filter coefficients.


% Need to verify coeff order for root locus plot
% Change root locus plot to zplane()

%% 0314 TODO: Next is making 3band simulink testbench and control script

%% Testbench options
N = 1024;       %fft window size for freq analysis
single = 0;     % Single(1) or multiple filter curves
bodegen = 1;    % Bodeplot(1) or freqz (0)
plotAll = 1; % Plots filter curves for each filter and seperate.
rootlocus = 0;  % Show root locus plot
FreqScale = 'log'; %'linear' or 'log'

%% System parameters
Fs = 41000;     %Hz
Fsw = Fs*2*pi;  %sample rate rad/s
Ts=1/Fs;

%% Filter specification input parameters   
    
    %% Treble shelving filter
    %NB: Uneven number of filter coefficient is not handled yet!!!
    fcTreb = 4000;       % Cutoff frequency
    GsTreb = -6;        % Single coeffisient set, gain in dB
    %GmTreb = [0 0 0 0 0 3 6 9 12];  % Coeffisient vector, multiple gain levels
    GmTreb = [-12 -9 -6 -3 0 3 6 9 12];  % Coeffisient vector, multiple gain levels
    QTreb = 1.0;                  % Q-factor
    typeTreb = 'Treble_Shelf';      % 'Base_Shelf' or 'Treble_Shelf'
    %% Midrange shelving filter
    fcMid = 1400;       % Cutoff frequency
    GsMid = 6;        % Single coeffisient set, gain in dB
    GmMid = [-12 -9 -6 -3 0 3 6 9 12];  % Coeffisient vector, multiple gain levels
    QMid = 1.2;                  % Q-factor
    
    %% Bass shelving filter
    fcBass = 350;       % Cutoff frequency
    GsBass = -6;        % Single coeffisient set, gain in dB
    GmBass = [-12 -9 -6 -3 0 3 6 9 12];  % Coeffisient vector, multiple gain levels
    QBass = 1.0;                  % Q-factor
    typeBass = 'Base_Shelf';      % 'Base_Shelf' or 'Treble_Shelf'


    
%% Plot colors
colorBrown = [0.6 0.2 0];
colorViolet = [0.4706 0.3059 0.4471];

%% SINGLE COEFFISIENT SET
if single == 1 
    %% Generate filter coefficient         
        [BTreb,ATreb] = shelving(GsTreb, fcTreb, Fs, QTreb, typeTreb);
        [BMid,AMid] = peak(GsMid, fcMid, Fs, QMid);
        [BBass,ABass] = shelving(GsBass, fcBass, Fs, QBass, typeBass);
    %% Generate plot
    if bodegen ==1
        %bodeplot
        tfdBass = tf(BBass,ABass,Ts)   %Discrete transfer function
        tfdMid = tf(BMid,AMid,Ts)   %Discrete transfer function
        tfdSeries1 = series(tfdBass,tfdMid); % Connects Bass and mid transfer functions               
        tfdTreb = tf(BTreb,ATreb,Ts)   %Discrete transfer function       
        tfdTot = series(tfdSeries1,tfdTreb) % Discrete transfer function all three filters.        
        if plotAll == 1
            hbodebass = bodeplot(tfdBass, 'k'); 
            hold on;
            hbodemid = bodeplot(tfdMid, 'g');
            hbodetreb = bodeplot(tfdTreb, 'y');
        end                
        hbode = bodeplot(tfdTot,'r');                
        setoptions(hbode,'FreqUnits', 'Hz','FreqScale', FreqScale, 'Xlim',[20 Fs/2]);
        hold off;

    end
    %%NOT UPDATED FOR THREE FILTERS/TOTAL SYSTEM
   % if rootlocus == 1
   %      figure
   %      rlocus(ABass,BBass)     
   % end
    
%% MULTIPLE COEFFISIENT SET
else
    % Generate Coefficients and transferfunctions:
    lenGmTreb = length(GmTreb);
    lenGmMid = length(GmMid);
    lenGmBass = length(GmBass);
    
    ATreb = cell(1,lenGmTreb);
    BTreb = cell(1,lenGmTreb);
    AMid = cell(1,lenGmMid);
    BMid = cell(1,lenGmMid);
    ABass = cell(1,lenGmBass);
    BBass = cell(1,lenGmBass);
    
    HTreb = cell(1,lenGmTreb);
    HMid = cell(1,lenGmMid);
    HBass = cell(1,lenGmBass);
    tfdTreb = cell(1,lenGmTreb);
    tfdMid = cell(1,lenGmMid);
    tfdBass = cell(1,lenGmBass);  
    
    GmTotLength = max([lenGmBass lenGmMid lenGmTreb])
    tftTot = cell(1,GmTotLength); 
    
    for i = 1:GmTotLength %!!!!!
        [BTreb{i}, ATreb{i}] = shelving(GmTreb(i), fcTreb, Fs, QTreb, 'Treble_Shelf');
        [BMid{i}, AMid{i}] = peak(GmMid(i), fcMid, Fs, QMid);
        [BBass{i}, ABass{i}] = shelving(GmBass(i), fcBass, Fs, QBass, 'Base_Shelf');                            
        tfdTreb{i} = tf(BTreb{i},ATreb{i},Ts);
        tfdMid{i}  = tf(BMid{i},AMid{i},Ts);
        tfdBass{i} = tf(BBass{i},ABass{i},Ts);                     
    end
    
    if bodegen == 1
        % Separete graphs for each filter
        for i = 1:GmTotLength %!!!!!!!!!!!!!!!!!!!
            hold on;
            % Treble plot:
            hbodeTreb = bodeplot(tfdTreb{i},'b');            
            % Midrange plot:
            hbodeMid = bodeplot(tfdMid{i},'k');
            % Bass plot:
            hbodeBass = bodeplot(tfdBass{i},'g');            
        end
        setoptions(hbodeBass,'FreqUnits', 'Hz','FreqScale', FreqScale, 'Xlim',[20 Fs/2]); %doc plotoptions
        % red 0-setting:
        tfdNull = series(tfdBass{5},tfdTreb{5}); % Not dynamic!!!!!
        hnull = bodeplot(tfdNull, 'r');
        hold off;
   
    end
%% Not fixed for midrange    
%     if rootlocus == 1 
%          figure
%          subplot(2,1,1);
%          for i = 1:GmTotLength %!!!!!!!!!!!!!!!!!!!
%             rlocus(BBass{i},ABass{i})  
%             hold on;           
%          end
%          title('Root Locus - Bass Filter')
%          
%          subplot(2,1,2);
%          for i = 1:GmTotLength %!!!!!!!!!!!!!!!!!!!
%             rlocus(BTreb{i},ATreb{i})  
%             hold on;           
%          end
%          title('Root Locus - Treble Filter')
%         hold off;
%     end
end 



%% Output and save plot
