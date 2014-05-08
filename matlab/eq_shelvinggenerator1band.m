%% Coefficient generator for 1-band shelving filter
% 
%
% by Preben Thorød - 
% Gr 6 DAT096 - HandyEq - Chalmers University of Technology
% Using shelving() function by Jeff Tackett 08/22/05, Based on DAFX book
% and Zölner calculations and formulas for biquad filters.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% System parameters
Fs = 44100;     %Hz
Fsw = Fs*2*pi;  %sample rate rad/s
Ts=1/Fs;

%% Testbench options
single = 1;     % Single(1) or multiple filter curves and coefficients
filterset = 0;  % 1 for bass filter, 0 for treble filter
genfixpoint = 1;    % Generate fixed point coefficients

bodegen = 0;    % Bodeplot(1) or freqz (0)
N = 128;       %fft window size for freq analysis

rootlocus = 0;  % Show root locus plot
%% Filter specification/ input parameters
%% Bass filter:
if filterset == 1
    %Bass shelving, different gain, constant fc
    fc = 3000;         % Cutoff frequency
    Gs = -12;        % Single coeffisient set, gain in dB
    Gm = [12 9 6 3 0 -3 -6 -9 -12]; % Coeffisient vector, multiple gain levels
    Q = 0.8;                  % Q-factor
    type = 'Base_Shelf';      % 'Base_Shelf' or 'Treble_Shelf'    
%% Treble filter:
else    
    fc = 3000;         % Cutoff frequency
    Gs = -12;         % Single coeffisient set, gain in dB
    Gm = [12 9 6 3 0 -3 -6 -9 -12]; % Coeffisient vector, multiple gain levels
    Q = 0.8;                  % Q-factor
    type = 'Treble_Shelf';      % 'Base_Shelf' or 'Treble_Shelf'
end

%% SINGLE COEFFISIENT SET
if single == 1 
    %% Generate filter coefficient 
        [b,a] = shelving(Gs, fc, Fs, Q, type);
    
    %%%%%%%TESTING FIXED POINT CONV 0304 %%%%%%%%%%%%%%%%%%    
    %% Generate fixed point
        if genfixpoint == 1
        %% Just the coefficients: (independent of dfilt() but doesnt handel form and scaling
        a_16 = fi(a,1,16,14);   %Q2.14 to stop clipping, may need to be extended further for other sets?
        b_16 = fi(b,1,16,14);
        % a_16 is currently used!!!
        a_32 = fi(a,1,32,14);   %Here we have headroom for larger integers, and 1bit overhead in regular "representation" for adding
        b_32 = fi(b,1,32,14);   
        
        %USIG WRONG FORM!:D
        Hshelf_df1 = dfilt.df1sos(b,a);
        Hshelf_df1.Arithmetic = 'fixed';
        get(Hshelf_df1);
        Hshelf_df1 = dfilt.df1sos(b,a);
        
        
        %%TOFO:
        %%Scaling
        % scale(Hshelf_df1);
        Hshelf_df1.scaleValues          %%WHY?
        Hshelf_df1.sosMatrix
        [b_16,a_16] %Print: Compares a and b values with fixed point from
        [b_32,a_32]
        
        storedInteger([b_16,a_16])
        storedInteger([b_32,a_32])
        %%word length, rounding etc
        end
    %% Generate plot
    if bodegen ==1
        %bodeplot
        tfd = tf(b,a,Ts);   %Discrete transfer function 
        filt(b,a)           %Print transfer function on DSP-format
        hbode = bodeplot(tfd);  
        setoptions(hbode,'FreqUnits', 'Hz','FreqScale', FreqScale, 'Xlim',[10 Fs/2]);
        %%%sos = [b a]         % SOS 1x6 Matrix for simulink model
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
    error('Multiple coefficient not supported...yet');
end