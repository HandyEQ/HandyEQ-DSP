%% Testbench for eq/shelving+notch filters
% For frequency and impulse response analysis and
%
% by Preben Thorød - 
% Gr 6 DAT096 - HandyEq - Chalmers University of Technology
% Using shelving() function by Jeff Tackett 08/22/05, Based on DAFX book
% and Zölner calculations and formulas for biquad filters.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% TODO:
% Coeff control for testbench(testbench1 first)
%   -> Ok, improve testbench with freq spec analysis or something.
%   -> generator
% Change root locus plot to "plane()
%% Return values:
%   a = [  1, a1, a2];
%   b = [ b0, b1, b2];

%% Testbench options
N = 1024;       %fft window size for freq analysis
single = 0;     % Single(1) or multiple filter curves and coefficients
bodegen = 1;    % Bodeplot(1) or freqz (0)
rootlocus = 0;  % Show root locus plot
FreqScale = 'log'; %'linear' or 'log'

count = 0; % (for nextcoeff stepping)
%% System parameters
Fs = 41000;     %Hz
Fsw = Fs*2*pi;  %sample rate rad/s
Ts=1/Fs;

%% Filter specification/ input parameters
%fc = 1000;       % Cutoff frequency
%fc = [200 500 3000 7000];
fc = 800;
Gs = -12;        % Single coeffisient set, gain in dB

%Gm = [-24 -12 -9 -3 0];  % Coeffisient vector, multiple gain levels
Gm = [12 9 6 3 0 -3 -6 -9 -12];
%Gm = [0 -6 -12 -24];
%Gm = [-12 -12 -12 -12];

Q = 0.8;                  % Q-factor
type = 'Base_Shelf';      % 'Base_Shelf' or 'Treble_Shelf'

%% SINGLE COEFFISIENT SET
if single == 1 
    %% Generate filter coefficient 
        [b,a] = shelving(Gs, fc, Fs, Q, type);
    %% Generate plot
    if bodegen ==1
        %bodeplot
        tfd = tf(b,a,Ts);   %Discrete transfer function 
        filt(b,a)           %Print transfer function on DSP-format
        hbode = bodeplot(tfd);  
        setoptions(hbode,'FreqUnits', 'Hz','FreqScale', FreqScale, 'Xlim',[10 Fs/2]);
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
            [B{i}, A{i}] = shelving(Gm(i), fc(i), Fs, Q, 'Base_Shelf');        
            tfd{i} = tf(B{i},A{i},Ts);
        end
    else
        for i = 1:N_coeff
            [B{i}, A{i}] = shelving(Gm(i), fc, Fs, Q, 'Base_Shelf');        
            tfd{i} = tf(B{i},A{i},Ts);
        end
    end

    
    % Plot:
    if bodegen == 1    
        % Bode plot
        for i = 1:length(Gm)
            hold on;
            hbode = bodeplot(tfd{i});
            setoptions(hbode,'FreqUnits', 'Hz','FreqScale', FreqScale, 'Xlim',[10 Fs/2]); %doc plotoptions
        end
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
