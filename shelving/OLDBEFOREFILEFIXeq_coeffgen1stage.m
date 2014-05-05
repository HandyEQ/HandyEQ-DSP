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
%% Output coeffisient struct:
%       stage1.datatype     Fixed point format (QI.F)
%        stage1.type        'Base_shelv', 'Treble_shelv', or 'Notch'
%        stage1.fc          String: '1500Hz'
%        stage1.gain        String: '6dB' . '-12dB'
%        stage1.scalefactor power of two, integer scalingfactor used
%                           (For use in algorithm for descaling
%        stage1.a           [a0 a1 a2]
%                           vector of a coefficients, scaled by scalefactor
%                           int32 type, [a0 a1 a2]
%        stage1.b           [b0 b1 b2]
%        stage1.tfd         Transferfunction before fixedpoint converting
%        stage1.tfd_32      Transferfunction based on fixed point
%                           coefficients
%
% 
%! Ouput file description:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% TODO:

%% Doing: %%%-%%% OLD BUT USEFUL

%% Return values:
%%%-%%% %  a = [  1, a1, a2];
%%%-%%% %  b = [ b0, b1, b2];


%% Testbench options

single = 1;     % Single(1) or multiple filter curves and coefficients
genfixpoint = 1;            % Generate fixed point coefficients(OUTDATED)
%Plot options:
bodegen = 1;    % 
    bodegen_FreqScale = 'log'; %'linear' or 'log'
    bodegen_plotphase = 'off';
rootlocus = 0;  % Show root locus plot
printcoeffs = 0;

%File generation options:
fprintfixedpoint = 1;       % Ouputs fixed point coefficients to infofile
fprintfixedpointheader = 1; % generates eqcoeff.c source file with coefficients.

filterset = 1;  % 1 for bass filter, 0 for treble filter   %%2= Notch





%% Filter specification/ input parameters
%% Bass filter:
if filterset == 1
    %Bass shelving, different gain, constant fc
    fc = 200;         % Cutoff frequency
    Gs = -18;        % Single coeffisient set, gain in dB
    Gm = [12 9 6 3 0 -3 -6 -9 -12]; % Coeffisient vector, multiple gain levels
    Q = 0.8;                  % Q-factor
    filtertype = 'Base_Shelf';      % 'Base_Shelf' or 'Treble_Shelf' 
end
%% Treble filter:
if filterset == 2
    %%notch:
    %% Midrange shelving filter
    fc = 5400;       % Cutoff frequency
    Gs = 15;        % Single coeffisient set, gain in dB
    Gm = [-12 -9 -6 -3 0 3 6 9 12];  % Coeffisient vector, multiple gain levels
    Q = 1.2;                  % Q-factor
    filtertype = 'Notch';
else    
    fc = 3000;         % Cutoff frequency
    Gs = 6;         % Single coeffisient set, gain in dB
    Gm = [12 9 6 3 0 -3 -6 -9 -12]; % Coeffisient vector, multiple gain levels
    Q = 0.8;                  % Q-factor
    filtertype = 'Treble_Shelf';      % 'Base_Shelf' or 'Treble_Shelf'
end


%% System parameters
Fs = 44100;     %Hz
Fsw = Fs*2*pi;  %sample rate rad/s
Ts=1/Fs;

%% Fixed point parameters:
fractionalbits = 13 %12; % Highest coeff value found until now is <~4, need three integer bits(S,2,1), 16-3 = 13
integerbits = 32-fractionalbits;
scalefactor = 2^fractionalbits; % equals '1' in the system
fractionaldatatype = sprintf('Q%i.%i',integerbits,fractionalbits);


%% SINGLE COEFFISIENT SET
if single == 1 
    %% Generate filter coefficient 
        % [b,a] = shelving(Gs, fc, Fs, Q, filtertype);
        if or(filterset == 1,filterset == 0)
            [stage1.b_double,stage1.a_double] = shelving(Gs, fc, Fs, Q, filtertype);
        end
        if filterset == 2
            [stage1.b_double,stage1.a_double] = peak(Gs, fc, Fs, Q);
        end
        
    %% Convert to fixed point 32bit
        if genfixpoint == 1
       
            %% 
            %(independent of dfilt()
            % _16 For use with rouding error check:
            a_16 = fi(stage1.a_double,1,16,fractionalbits);   %Q3.13 to prevent integer rounding errorstop clipping, may need to be extended further for other sets?
            b_16 = fi(stage1.b_double,1,16,fractionalbits);
            
            a_32 = fi(stage1.a_double,1,32,fractionalbits);
            b_32 = fi(stage1.b_double,1,32,fractionalbits);   %Q19.13 to prevent integer rounding errorstop clipping, may need to be extended further for other sets?

            %% Generate coefficient structure:
            stage1.datatype = fractionaldatatype;   % QI.F
            stage1.type = filtertype;               %'Base_shelv', 'Treble_shelv', or 'Notch'
            stage1.fc = fc;      
            stage1.gain = Gs;
            stage1.scalefactor = scalefactor;       % Can be made local for each coefficient set (later)
            stage1.a = int32(storedInteger(a_32));  %to be replaced with actual generation
            stage1.b = int32(storedInteger(b_32)); 
            
            % discrete transferfunction for use with plots etc:
            stage1.tfd = tf(stage1.b_double,stage1.a_double,Ts,'variable','z^-1'); 
            stage1.tfd_32 = tf(b_32,a_32,Ts,'variable','z^-1');      %fixed point coeffs 
            
            % Print: Compare double and fixed point coefficients 
            if printcoeffs == 1
                [stage1.b_double,stage1.a_double]
                [b_16,a_16]
                [b_32,a_32]             
            end    
            
            %% Give error if integer rounding happens because of to big coefficients
            % Compare double, 16bit and 32 bit coefficients
%%%            coeffquanterror_acc = 0;
%%%            coeffquanterror_16 = abs(b - double(b_16));
%%%            coeffquanterror_16_max = max(coeffquanterror_16);
            % coeffquanterror_16_mean = mean(coeffquanterror_16);   %For statistics if needed  
           
            
            
            coeffquanterror_16_b = abs(stage1.b_double - double(b_16));
            coeffquanterror_16_a = abs(stage1.a_double - double(a_16));
            coeffquanterror_16_max = max(max(coeffquanterror_16_b),max(coeffquanterror_16_a))               
            if (coeffquanterror_16_max > 0.5) %0.002) % should probably calculate properly
                [stage1.b_double,stage1.a_double]
                [b_16,a_16]
                [b_32,a_32]
                coeffquanterror_16_max
                error('eq_coeffgen: Integer rounding error when converting from double!');                      
            end
        end
        
        
    %% Stability check:    
    if (isstable(stage1.tfd) == 0)
        error('eq_coeffgen: Original double type filter is not stable (tfd)');  
    end
    
    if (isstable(stage1.tfd_32) == 0)
        error('eq_coeffgen: 32bit fixed point type filter is not stable (tfd_32)');  
    end
    %%%IDEA: Auto stability check: If unstable, plot rlocus! :D
           
    %% Generate plot
    
%     if ishandle(fig_bodelocus)        %%Was good but stopped working
%                                       %% after clear!?
%         close(fig_bodelocus);
%         if or(bodegen,rootlocus)
%             fig_bodelocus = figure;
%         end      
%     end  

    try 
        close(fig_bodelocus);
    end
    if or(bodegen,rootlocus)
        scrsz = get(0,'ScreenSize');
        fig_bodelocus = figure('Position',[2 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2-78]);        
        %figure('Position',[1 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2])
    end      
    

    if bodegen == 1  
        subplot(1,bodegen+rootlocus,1);
        hbode = bodeplot(stage1.tfd); 
        setoptions(hbode,'MagVisible','on','PhaseVisible', bodegen_plotphase,'FreqUnits', 'Hz','FreqScale', bodegen_FreqScale); %, 'Xlim',[10 Fs/2]);
        setoptions(hbode,'Ylim',[-24 24], 'Xlim',[10 Fs/2],'Grid','on');
    end
    if rootlocus == 1      
        subplot(1,bodegen+rootlocus,bodegen+1);        
        rlocus(stage1.tfd)
        hold on;
        rlocus(stage1.tfd_32)  %force red color
        hold off;
    end
    %print coefficient structure:
    stage1

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
            setoptions(hbode,'FreqUnits', 'Hz','FreqScale', bodegen_FreqScale, 'Xlim',[10 Fs/2]); %doc plotoptions
        end
        hold off;
    else
        %freqz plot
        for i = 1:length(Gm)
            hold on;            
            freqz(A{i},B{i},Nfreqz,Fs);            
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
