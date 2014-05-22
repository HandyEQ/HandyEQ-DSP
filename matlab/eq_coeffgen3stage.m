%% eq_coeffgen3stage.m
%
% by Preben Thorød - 
% Gr 6 DAT096 - HandyEq - Chalmers University of Technology
% Using shelving() function by Jeff Tackett 08/22/05, Based on DAFX book
% and Zölner calculations and formulas for biquad filters.
% Dependencies:
%   - shelving.m
%   - peak.m
%   - eq_createcoefffile3stage.m
%   - iirplotresponseDouble.m
%   - iirplotresponse3bandDouble.m

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generates coefficients for 3-band shelving/notch filter.
% 
% Generates 3 cell of coefficient structs (stage1,stage2,stage3)
% Each cell structure holds data for one coefficient set.
%  
%% Output coeffisient struct:
%       stage1.datatype     Fixed point format (QI.F)
%        stage1.type        'Base_shelv', 'Treble_shelv', or 'Notch'
%        stage1.fc          String: '1500Hz'
%        stage1.gain        String: '6dB' . '-12dB'
%        stage1.scalefactor power of two, integer scalingfactor used
%                           (For use in algorithm for down-scaling
%        stage1.a           [a0 a1 a2]
%                           Integer representation of coefficients, scaled by scalefactor
%                           int32 type, [a0 a1 a2]
%        stage1.b           [b0 b1 b2]
%        stage1.a_double    Original double type coefficients
%        stage1.b_double    
%        stage1.tfd         Transferfunction with double type coefficients
%        stage1.tfd_32      Transferfunction based on fixed point
%                           coefficients
%
% 
%% Ouput file description:
%       Generates C source files eqcoeff.c and eqcoeff.h if
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% Plot options:
    bodegen = 0;        % Generates bodeplot if = 1
        bodegen_FreqScale = 'log'; %'linear' or 'log' Frequency plot
        bodegen_plotphase = 'off'; % Enables phaseplot if 'on', else 'off'
    bodeextremes = 1;   % Generates bodeplot for combined extreme eq settings if = 1       
    rootlocus = 1;      % Generates root locus plot if = 1    

%% File generation options:
    fprintfixedpoint = 1; % Ouputs fixed point coefficients to infofile


                    
%% Filter specification:

    %% Bass shelving filter:
    %Bass shelving, different gain, constant fc
    fcBass = 600;                       % Cutoff frequency 
    GBass = [-12 -9 -6 -3 0 3 6 9 12];  % Gain vector in dB.
    QBass = 1/sqrt(2); %0.4;            % Q-factor
    filtertypeBass = 'Base_Shelf';      % 'Base_Shelf' or 'Treble_Shelf' 

    %% Midrange peak/notch filter
    fcMid = 1450;                       % Cutoff frequency
    GMid = [-12 -9 -6 -3 0 3 6 9 12];   % Coeffisient vector, multiple gain levels
    QMid = 1.4;                         % Q-factor 
    filtertypeMid = 'Notch';

    %% Treble shelving filter:
    fcTreble = 3500;                    % Cutoff frequency
    GTreble = [-12 -9 -6 -3 0 3 6 9 12];% Coeffisient vector, multiple gain levels 
    QTreble = 0.8;                      % Q-factor
    filtertypeTreble = 'Treble_Shelf';  % 'Base_Shelf' or 'Treble_Shelf'


%% System parameters
    Fs = 48077; %44100;     %Hz
    Fsw = Fs*2*pi;          %Sample rate rad/s
    Ts=1/Fs;                

%% Fixed point parameters:
fractionalbits = 12;        
% Sets fractional binary point.
% If integer rounding error, try increasing integer bits by reducing this variable

integerbits = 32-fractionalbits;
scalefactor = 2^fractionalbits;     % Upsscaling of normalized coefficients equals '1' in the system
fractionaldatatype = sprintf('Q%i.%i',integerbits,fractionalbits)

 
arraysizeBass = length(GBass);
arraysizeMid = length(GMid);
arraysizeTreble = length(GTreble);
if arraysizeBass <2 
    error('Only multiple coefficients is supported, please input vector to GBass');
end

if arraysizeMid <2 
    error('Only multiple coefficients is supported, please input vector to GMid');
end

if arraysizeTreble <2 
    error('Only multiple coefficients is supported, please input vector to GTreble');
end
single = 0;


%% Generate coefficients and transferfunctions:
stage1 = cell(1,arraysizeBass);     %Cell of coeff structs
stage2 = cell(1,arraysizeMid);      %Cell of coeff structs
stage3 = cell(1,arraysizeTreble);   %Cell of coeff structs
roundingerrorBass = 0;
roundingerrorMid = 0;
roundingerrorTreble = 0;
for i = 1:arraysizeBass
    % Calculate coefficients:
    [stage1{i}.b_double,stage1{i}.a_double] = shelving(GBass(i), fcBass, Fs, QBass, filtertypeBass);
    [stage2{i}.b_double,stage2{i}.a_double] = peak(GMid(i), fcMid, Fs, QMid);
    [stage3{i}.b_double,stage3{i}.a_double] = shelving(GTreble(i), fcTreble, Fs, QTreble, filtertypeTreble);

    % _16 For use with rouding error check:
    stage1{i}.a_16 = fi(stage1{i}.a_double,1,16,fractionalbits);   %Q3.13 to prevent integer rounding errorstop clipping, may need to be extended further for other sets?
    stage1{i}.b_16 = fi(stage1{i}.b_double,1,16,fractionalbits);
    % _32 Used for new coefficients
    stage1{i}.a_32 = fi(stage1{i}.a_double,1,32,fractionalbits);
    stage1{i}.b_32 = fi(stage1{i}.b_double,1,32,fractionalbits);  
    
    % _16 For use with rouding error check:
    stage2{i}.a_16 = fi(stage2{i}.a_double,1,16,fractionalbits);   %Q3.13 to prevent integer rounding errorstop clipping, may need to be extended further for other sets?
    stage2{i}.b_16 = fi(stage2{i}.b_double,1,16,fractionalbits);
    % _32 Used for new coefficients
    stage2{i}.a_32 = fi(stage2{i}.a_double,1,32,fractionalbits);
    stage2{i}.b_32 = fi(stage2{i}.b_double,1,32,fractionalbits);
    
    % _16 For use with rouding error check:
    stage3{i}.a_16 = fi(stage3{i}.a_double,1,16,fractionalbits);   %Q3.13 to prevent integer rounding errorstop clipping, may need to be extended further for other sets?
    stage3{i}.b_16 = fi(stage3{i}.b_double,1,16,fractionalbits);
    % _32 Used for new coefficients
    stage3{i}.a_32 = fi(stage3{i}.a_double,1,32,fractionalbits);
    stage3{i}.b_32 = fi(stage3{i}.b_double,1,32,fractionalbits);

   %% Generate coefficient structure:
    stage1{i}.type = filtertypeBass;                %'Base_shelv', 'Treble_shelv', or 'Notch'
    stage1{i}.fc = fcBass;      
    stage1{i}.gain = GBass(i);
    stage1{i}.q = QBass;                            %Q-factor
    stage1{i}.dataformat = fractionaldatatype;      %QI.F
    stage1{i}.scalefactor = scalefactor;            %Can be made local for each coefficient set (later)
    stage1{i}.a = int32(storedInteger(stage1{i}.a_32));  %to be replaced with actual generation
    stage1{i}.b = int32(storedInteger(stage1{i}.b_32)); 

    stage2{i}.type = filtertypeMid;                 %'Base_shelv', 'Treble_shelv', or 'Notch'
    stage2{i}.fc = fcMid;      
    stage2{i}.gain = GMid(i);
    stage2{i}.q = QMid;                             %Q-factor
    stage2{i}.dataformat = fractionaldatatype;      %QI.F
    stage2{i}.scalefactor = scalefactor;            %Can be made local for each coefficient set (later)
    stage2{i}.a = int32(storedInteger(stage2{i}.a_32));  %to be replaced with actual generation
    stage2{i}.b = int32(storedInteger(stage2{i}.b_32)); 
    
    stage3{i}.type = filtertypeTreble;              %'Base_shelv', 'Treble_shelv', or 'Notch'
    stage3{i}.fc = fcTreble;      
    stage3{i}.gain = GTreble(i);
    stage3{i}.q = QTreble;                          %Q-factor
    stage3{i}.dataformat = fractionaldatatype;      %QI.F
    stage3{i}.scalefactor = scalefactor;            %Can be made local for each coefficient set (later)
    stage3{i}.a = int32(storedInteger(stage3{i}.a_32));  %to be replaced with actual generation
    stage3{i}.b = int32(storedInteger(stage3{i}.b_32)); 
    
    % Discrete transferfunction for use with plots etc:
    stage1{i}.tfd = tf(stage1{i}.b_double,stage1{i}.a_double,Ts,'variable','z^-1'); 
    stage1{i}.tfd_32 = tf(stage1{i}.b_32,stage1{i}.a_32,Ts,'variable','z^-1');      %fixed point coeffs            

    stage2{i}.tfd = tf(stage2{i}.b_double,stage2{i}.a_double,Ts,'variable','z^-1'); 
    stage2{i}.tfd_32 = tf(stage2{i}.b_32,stage2{i}.a_32,Ts,'variable','z^-1');      %fixed point coeffs            
    
    stage3{i}.tfd = tf(stage3{i}.b_double,stage3{i}.a_double,Ts,'variable','z^-1'); 
    stage3{i}.tfd_32 = tf(stage3{i}.b_32,stage3{i}.a_32,Ts,'variable','z^-1');      %fixed point coeffs            
    
    %% Check for saturation in rounding:
    stage1{i}.coeffquanterror_16_b = abs(stage1{i}.b_double - double(stage1{i}.b_16));
    stage1{i}.coeffquanterror_16_a = abs(stage1{i}.a_double - double(stage1{i}.a_16));
    stage1{i}.coeffquanterror_16_max = max(max(stage1{i}.coeffquanterror_16_b),max(stage1{i}.coeffquanterror_16_a))  ;             
    if (stage1{i}.coeffquanterror_16_max > 0.5)                 
        [stage1{i}.b_double,stage1{i}.a_double]
        [stage1{i}.b_16,    stage1{i}.a_16]
        [stage1{i}.b_32,    stage1{i}.a_32]
        stage1{i}.coeffquanterror_16_max
        
        roundingerrorBass = roundingerrorBass +1;
        error('eq_coeffgen: Integer rounding error when converting from double at coeff struct{%i}!',i);                      
    end

    stage2{i}.coeffquanterror_16_b = abs(stage2{i}.b_double - double(stage2{i}.b_16));
    stage2{i}.coeffquanterror_16_a = abs(stage2{i}.a_double - double(stage2{i}.a_16));
    stage2{i}.coeffquanterror_16_max = max(max(stage2{i}.coeffquanterror_16_b),max(stage2{i}.coeffquanterror_16_a))  ;             
    if (stage2{i}.coeffquanterror_16_max > 0.5)                
        [stage2{i}.b_double,stage2{i}.a_double]
        [stage2{i}.b_16,    stage2{i}.a_16]
        [stage2{i}.b_32,    stage2{i}.a_32]
        stage2{i}.coeffquanterror_16_max
        
        roundingerrorMid = roundingerrorMid +1;
        error('eq_coeffgen: Integer rounding error when converting from double at coeff struct{%i}!',i);                      
    end
    
    stage3{i}.coeffquanterror_16_b = abs(stage3{i}.b_double - double(stage3{i}.b_16));
    stage3{i}.coeffquanterror_16_a = abs(stage3{i}.a_double - double(stage3{i}.a_16));
    stage3{i}.coeffquanterror_16_max = max(max(stage3{i}.coeffquanterror_16_b),max(stage3{i}.coeffquanterror_16_a))  ;             
    if (stage3{i}.coeffquanterror_16_max > 0.5)                 
        [stage3{i}.b_double,stage3{i}.a_double]
        [stage3{i}.b_16,    stage3{i}.a_16]
        [stage3{i}.b_32,    stage3{i}.a_32]
        stage3{i}.coeffquanterror_16_max
        
        roundingerrorTreble = roundingerrorTreble +1;
        TREBLEERROR = i
        error('eq_coeffgen: Integer rounding error when converting from double at coeff struct{%i}!',i);                      
    end

    %% Stability check:          
    if (isstable(stage1{i}.tfd) == 0)
        error('eq_coeffgen stage1: Original double type filter is not stable (struct{%i}.tfd)',i);  
    end
    if (isstable(stage1{i}.tfd_32) == 0)
        error('eq_coeffgen stage1: 32bit fixed point type filter is not stable (struct{%i}.tfd_32)',i);
    end
    
    
    if (isstable(stage2{i}.tfd) == 0)
        error('eq_coeffgen stage2: Original double type filter is not stable (struct{%i}.tfd)',i);  
    end
    if (isstable(stage2{i}.tfd_32) == 0)
        error('eq_coeffgen stage2: 32bit fixed point type filter is not stable (struct{%i}.tfd_32)',i);
    end
    
    if (isstable(stage3{i}.tfd) == 0)
        error('eq_coeffgen stage3: Original double type filter is not stable (struct{%i}.tfd)',i);  
    end
    if (isstable(stage3{i}.tfd_32) == 0)
        error('eq_coeffgen stage3: 32bit fixed point type filter is not stable (struct{%i}.tfd_32)',i);
    end
end

%% Print rounding error info;
roundingerrorBass
roundingerrorMid
roundingerrorTreble

%% Generate plot
if bodegen == 1
    iirplotresponseDouble(stage1,bodegen,rootlocus,Fs);
    iirplotresponseDouble(stage2,bodegen,rootlocus,Fs);
    iirplotresponseDouble(stage3,bodegen,rootlocus,Fs);
end
if bodeextremes == 1
    iirplotresponse3bandDouble;
end

%% Generate C souce files:
if (fprintfixedpoint == 1);    % Generate fixed point coefficients      
    eq_createcoefffile3stage(stage1,stage2,stage3, Fs,'eqcoeff')
end




