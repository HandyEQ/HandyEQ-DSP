%% eq_coeffgen1stage.m
%
% by Preben Thorød - 
% Gr 6 DAT096 - HandyEq - Chalmers University of Technology
% Using shelving() function by Jeff Tackett 08/22/05, Based on DAFX book
% and Zölner calculations and formulas for biquad filters.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generates coefficients for one stage shelving filter.
% Choose Bass or Treble shelving
% Chose ploting of frequency response
% Choose to generate a single coefficient set or multiple (an array)
% Generates int32 coefficients forced to 16bit, scaled to fractional fixed 
% point (typical Q.19(3).13)
%
%! Output coeffisient struct:
%       stage1.datatype     Fixed point format (QI.F)
%        stage1.type        'Base_shelv', 'Treble_shelv', or 'Notch'
%        stage1.gain        String: '6dB' . '-12dB'
%        stage1.fc 
%        stage1.a = int32(storedInteger(a_32)); %to be replaced with actual generation
%        stage1.b = int32(storedInteger(b_32));        
%        stage1.scalefactor = scalefactor;  
        
% 
%! Ouput file description:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% TODO:

%% Return values:
%   a = [  1, a1, a2];
%   b = [ b0, b1, b2];



%% Testbench options
N = 128;       %fft window size for freq analysis
single = 1;     % Single(1) or multiple filter curves and coefficients
bodegen = 1;    % Outdated, use plotfreqz, should be fixed
plotfreqz = 0;  %
rootlocus = 0;  % Show root locus plot
zplane = 0;     % plot poles and zeroes in z plane
genfixpoint = 1;    % Generate fixed point coefficients
fprintfixedpoint = 1;% Ouputs fixed point coefficients to file
fprintfixedpointheader = 1; %generates .h header file with coefficients.
FreqScale = 'log'; %'linear' or 'log'

filterset = 0;  % 1 for bass filter, 0 for treble filter

%% System parameters
Fs = 44100;     %Hz
Fsw = Fs*2*pi;  %sample rate rad/s
Ts=1/Fs;

%% Fixed point parameters:
fractionalbits = 12; % Highest coeff value found until now is <~4, need three integer bits(S,2,1), 16-3 = 13
integerbits = 32-fractionalbits;
scalefactor = 2^fractionalbits; % equals '1' in the system
fractionaldatatype = sprintf('Q%i.%i',integerbits,fractionalbits);

%% Filter specification/ input parameters
%% Bass filter:
if filterset == 1
    %Bass shelving, different gain, constant fc
    fc = 200;         % Cutoff frequency
    Gs = -12;        % Single coeffisient set, gain in dB
    Gm = [12 9 6 3 0 -3 -6 -9 -12]; % Coeffisient vector, multiple gain levels
    Q = 0.8;                  % Q-factor
    filtertype = 'Base_Shelf';      % 'Base_Shelf' or 'Treble_Shelf'    
%% Treble filter:
else    
    fc = 3000;         % Cutoff frequency
    Gs = 6;         % Single coeffisient set, gain in dB
    Gm = [12 9 6 3 0 -3 -6 -9 -12]; % Coeffisient vector, multiple gain levels
    Q = 0.8;                  % Q-factor
    filtertype = 'Treble_Shelf';      % 'Base_Shelf' or 'Treble_Shelf'
end

%% SINGLE COEFFISIENT SET
if single == 1 
    %% Generate filter coefficient 
        [b,a] = shelving(Gs, fc, Fs, Q, filtertype);
    
    %%%%%%%TESTING FIXED POINT CONV 0304 %%%%%%%%%%%%%%%%%%    
    %% Generate fixed point
        if genfixpoint == 1
        %% Just the coefficients: (independent of dfilt() but doesnt handel form and scaling
        a_16 = fi(a,1,16,fractionalbits);   %Q3.13 to prevent integer rounding errorstop clipping, may need to be extended further for other sets?
        b_16 = fi(b,1,16,fractionalbits);
        
        
        % a_16 is currently used!!!
        a_32 = fi(a,1,32,fractionalbits);
        b_32 = fi(b,1,32,fractionalbits);   %Q19.13 to prevent integer rounding errorstop clipping, may need to be extended further for other sets?
        
        %% Generate coefficient structure:
        stage1.datatype = fractionaldatatype;   % QI.F
        stage1.type = filtertype;               %'Base_shelv', 'Treble_shelv', or 'Notch'
        stage1.gain = Gs;
        stage1.fc = fc;
        stage1.a = int32(storedInteger(a_32)); %to be replaced with actual generation
        stage1.b = int32(storedInteger(b_32));        
        stage1.scalefactor = scalefactor;  
        
        
      
        Hshelf_df1 = dfilt.df1sos(b,a);
        Hshelf_df1.Arithmetic = 'fixed';
        get(Hshelf_df1);
        Hshelf_df1 = dfilt.df1sos(b,a);
        
        %%TOFO:
        %%Scaling
        % scale(Hshelf_df2);
       % Hshelf_df1.scaleValues % (just for display)
        Hshelf_df1.sosMatrix %(just for display)
        [b_16,a_16] %Print: Compares a and b values with fixed point from
%         if zplane ==1 
%             zplane(Hshelf_df2.sosMatrix);
%         end
        %%word length, rounding etc
        
        %Compare double, 16bit and 32 bit coefficients
        coeffquanterror_acc = 0;
        coeffquanterror_16 = abs(b - double(b_16));
        coeffquanterror_16_max = max(coeffquanterror_16);
        %coeffquanterror_16_mean = mean(coeffquanterror_16);
        
        coeffquanterror_32 = abs(b - double(b_32));
        coeffquanterror_32_max = max(coeffquanterror_32);
        %coeffquanterror_32_mean = mean(coeffquanterror_32);
        
            if or(coeffquanterror_16_max > 0.002, coeffquanterror_32_max > 0.002) 
                error('Integer rounding error when converting from double!');
            end
        end
    %% Generate plot
    if bodegen == 1
        %bodeplot
        tfd = tf(b,a,Ts);   %Discrete transfer function 
        filt(b,a)           %Print transfer function on DSP-format
        hbode = bodeplot(tfd);  
        setoptions(hbode,'FreqUnits', 'Hz','FreqScale', FreqScale, 'Xlim',[10 Fs/2]);
        %%%sos = [b a]         % SOS 1x6 Matrix for simulink model
    end
        %freqz plot
    if plotfreqz == 1          
        freqz(b,a,N,Fs); %verify that this a,b input parameter makes sense, "works, but not mentioned in doc"
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
            [B{i}, A{i}] = shelving(Gm(i), fc(i), Fs, Q, filtertype);        
            tfd{i} = tf(B{i},A{i},Ts);
        end
    else
        for i = 1:N_coeff
            [B{i}, A{i}] = shelving(Gm(i), fc, Fs, Q, filtertype);        
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
%% Create coefficient file
if and((genfixpoint == 1),(fprintfixedpoint == 1))  ;    % Generate fixed point coefficients
    
    arrayFile = fopen('Dat096/coeff.txt','wt');
    
    fprintf(arrayFile,'//Testfile for generating header file for coefficients\n');
    fprintf(arrayFile,'\n');
    
    fprintf(arrayFile,'//Filter 1:\n');
    fprintf(arrayFile,'//Scaling factor:\t %i\n',scalefactor);
    
    fprintf(arrayFile,'\n');
    
    fprintf(arrayFile,'16-bit Q2.14\n');
    fprintf(arrayFile,'coeff\tBinary\t\t\t\tInteger\t\tHex\n');
    fprintf(arrayFile,'a0 \t%s\t\t%d\t\t0x%s\n',bin(a_16(1)),storedInteger(a_16(1)),hex(a_16(1)));
    fprintf(arrayFile,'a1 \t%s\t\t%d\t\t0x%s\n',bin(a_16(2)),storedInteger(a_16(2)),hex(a_16(2)));
    fprintf(arrayFile,'a2 \t%s\t\t%d\t\t0x%s\n',bin(a_16(3)),storedInteger(a_16(3)),hex(a_16(3)));
    fprintf(arrayFile,'b0 \t%s\t\t%d\t\t0x%s\n',bin(b_16(1)),storedInteger(b_16(1)),hex(b_16(1)));
    fprintf(arrayFile,'b1 \t%s\t\t%d\t\t0x%s\n',bin(b_16(2)),storedInteger(b_16(2)),hex(b_16(2)));
    fprintf(arrayFile,'b2 \t%s\t\t%d\t\t0x%s\n',bin(b_16(3)),storedInteger(b_16(3)),hex(b_16(3)));
    fprintf(arrayFile,'\n');
    fprintf(arrayFile,'\n');

    fprintf(arrayFile,'32-bit Q18.14 \n');
    fprintf(arrayFile,'coeff\tBinary\t\t\t\t\t\tInteger\t\t\tHex\n');
    fprintf(arrayFile,'a0 \t%s\t\t%d\t\t0x%s\n',bin(a_32(1)),storedInteger(a_32(1)),hex(a_32(1)));
    fprintf(arrayFile,'a1 \t%s\t\t%d\t\t0x%s\n',bin(a_32(2)),storedInteger(a_32(2)),hex(a_32(2)));
    fprintf(arrayFile,'a2 \t%s\t\t%d\t\t0x%s\n',bin(a_32(3)),storedInteger(a_32(3)),hex(a_32(3)));
    fprintf(arrayFile,'b0 \t%s\t\t%d\t\t0x%s\n',bin(b_32(1)),storedInteger(b_32(1)),hex(b_32(1)));
    fprintf(arrayFile,'b1 \t%s\t\t%d\t\t0x%s\n',bin(b_32(2)),storedInteger(b_32(2)),hex(b_32(2)));
    fprintf(arrayFile,'b2 \t%s\t\t%d\t\t0x%s\n',bin(b_32(3)),storedInteger(b_32(3)),hex(b_32(3)));
%     fprintf(arrayFile,'32-bit Q1.31\n');
%     fprintf(arrayFile,'a0 \t%s\n',bin(a_32(1)));
%     fprintf(arrayFile,'a1 \t%s\n',bin(a_32(2)));
%     fprintf(arrayFile,'a2 \t%s\n',bin(a_32(3)));
%     fprintf(arrayFile,'b0 \t%s\n',bin(b_32(1)));
%     fprintf(arrayFile,'b1 \t%s\n',bin(b_32(2)));
%     fprintf(arrayFile,'b2 \t%s\n',bin(b_32(3)));
%     
%     fprintf(arrayFile,'\n');
%     %fprintf(arrayFile,'a16 \t%d\n',a_16.bin);
%     %fprintf(arrayFile,'a32 \t%d\n',a_32.bin);
    
    fclose(arrayFile);
  
end

%% Generate .c file for coefficients.
% For single coefficient set:
if and((genfixpoint == 1),(fprintfixedpointheader == 1))  ;  
    headerFile = fopen('Dat096/eqcoeff.c','wt');
    
    fprintf(headerFile,'/* eqcoeff.c */\n');
    fprintf(headerFile,'/* Initialization of coefficients for 3-band equalizer	*/\n');
    fprintf(headerFile,'/* For use with HandyEQ project MPEES-1 DAT096 Group6	*/\n');
    fprintf(headerFile,'/* Preben Thorod @ HandyEQ                              */\n');
    fprintf(headerFile,'/* Generated: ');
    fprintf(headerFile,datestr(now,'dd mmmm yyyy HH:MM:SS */\n'));
    
    fprintf(headerFile,'\n');
    fprintf(headerFile,'#include "eqcoeff.h"\n');
    fprintf(headerFile,'#include <string.h>\n');
    fprintf(headerFile,'\n');
    fprintf(headerFile,'void initCoeff() {\n');
    % Coefficients:
    
    fprintf(headerFile,'	strcpy(treble.datatype, "Q%i.%i");\n',integerbits,fractionalbits); %%Can be replaced with string if used earlier in matlab
    fprintf(headerFile,'	treble.datadepth = 16;\n'); %Hardcoded
    fprintf(headerFile,'	strcpy(treble.filtertype, "%s");\n',filtertype);
    fprintf(headerFile,'	strcpy(treble.fc, "%dHz");\n',fc);
    fprintf(headerFile,'	strcpy(treble.gain, "%ddB");\n',Gs);    
    fprintf(headerFile,'	treble.scalefactor =  %i;\n',scalefactor);
    
    fprintf(headerFile,'	treble.a0 = %d;\n',storedInteger(a_16(1)));
    fprintf(headerFile,'	treble.a1 = %d;\n',storedInteger(a_16(2)));
    fprintf(headerFile,'	treble.a2 = %d;\n',storedInteger(a_16(3)));
    fprintf(headerFile,'	treble.b0 = %d;\n',storedInteger(b_16(1)));
    fprintf(headerFile,'	treble.b1 = %d;\n',storedInteger(b_16(2)));
    fprintf(headerFile,'	treble.b2 = %d;\n',storedInteger(b_16(3)));
    fprintf(headerFile,'	treble.g1 = 1;\n'); %hardcoded
    fprintf(headerFile,'	treble.g2 = 1;\n'); %hardcoded
    
    fprintf(headerFile,'};\n');
    
    fprintf(headerFile,'\n');
    fprintf(headerFile,'\n');
    fprintf(headerFile,'\n');
    fprintf(headerFile,'\n');
    fprintf(headerFile,'\n');
    fprintf(headerFile,'\n');
    
    fclose(headerFile);
    
  

end
