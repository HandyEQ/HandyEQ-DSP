%% Testbench IIR DF1 Biquad
% For frequency and impulse response analysis and
%
% by Carl-Johan H?ll
% Gr 6 DAT096 - HandyEq - Chalmers University of Technology


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
Fs = 48000;     %Hz
Fb = 15000;
Fsw = Fs*2*pi;  %sample rate rad/s
Ts=1/Fs;


Fs_IIR1 = 16*Fs;
Fs_IIR2 = 8*Fs;
Fs_IIR3 = 4*Fs;
Fs_IIR4 = 2*Fs;

order = 2;

%% Filter specification input parameters

t = (0:1000)'/8e3;
xin = sin(2*pi*0.3e3*t)+sin(2*pi*3e3*t); % Input is 0.3 & % 3kHz 

hFromWS = dsp.SignalSource(xin, 100);
hLog = dsp.SignalSink;

    %%
    R=0.5 %Passband ripple in dB %Wpish = (Fb/(Fs_IIR1*0.5))
    Wp = (2*pi*Fb)/(0.5*Fs_IIR1); %the normalized passband edge frequency Wp is a number between 0 and 1, where 1 corresponds to half the sample rate, ? radians per sample. 
                  %Smaller values of passband ripple R lead to wider transition widths (shallower rolloff characteristics).
    [b,a] = cheby1(order,R,Wp,'low');
    sos = tf2sos(b,a);
    fvtool(sos,'Analysis','freq');



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
