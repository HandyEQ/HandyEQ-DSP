%% eq_coeffgen1stage.m
%
% by Preben Thor�d - 
% Gr 6 DAT096 - HandyEq - Chalmers University of Technology
% Using shelving() function by Jeff Tackett 08/22/05, Based on DAFX book
% and Z�lner calculations and formulas for biquad filters.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generates coefficients for one stage shelving filter.
% Choose between notch, treble shelving and bass shelvng filter
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
%0501: filter analysis: Sjekk stabilitet ved � bytte tilbake til orginal 
% DAFC/z�tzler likning uten "Q" -> sqwrt(2)
%0501 script for � parse output fra leon3 impulse response.

%0501: Adaptive dataformat/scaling factor (For each set if array)


%% Doing: %%%-%%% OLD BUT USEFUL

%% Return values:
%%%-%%% %  a = [  1, a1, a2];
%%%-%%% %  b = [ b0, b1, b2];


%% Testbench options

%%outdated single = 1;     % Single(1) or multiple filter curves and coefficients
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

%% CHOOSE FILTER TYPE:
filterset = 1;          %1=bass,2=notch,3=treble
                                            




%% Filter specification:
if filterset == 1
    %% Bass shelving filter:
    %Bass shelving, different gain, constant fc
    fc = 600;         % Cutoff frequency  %% Unstable on low frequencies (<200..?) 500OK!
    G = -12;        % Single coeffisient set, gain in dB
%     G = [12 9 6 3 0 -3 -6 -9 -12]; % Coeffisient vector, multiple gain levels
    Q = 0.8;                  % Q-factor
    filtertype = 'Base_Shelf';      % 'Base_Shelf' or 'Treble_Shelf' 
end

if filterset == 2
    %% Midrange peak/notch filter

    % Extreme Q and gain settings seems to work, but careful with low
    % frequencies combined with low Q! (Can get significant LF boost
    fc = 1000;       % Cutoff frequency
    G = -15;        % Single coeffisient set, gain in dB
%     G = [-12 -9 -6 -3 0 3 6 9 12];  % Coeffisient vector, multiple gain levels
    Q = 5.6;                  % Q-factor 
    filtertype = 'Notch';
end

if filterset == 3
    %% Treble shelving filter:
    fc = 3000;         % Cutoff frequency
%     G = 12;            % Single coeffisient set, gain in dB
    G = [12 9 6 3 0 -3 -6 -9 -12]; % Coeffisient vector, multiple gain levels
    %G = [-20 5 10 15];
%     G = [12 12];
%     G = [-10 5];
    Q = 0.8;                  % Q-factor
    filtertype = 'Treble_Shelf';      % 'Base_Shelf' or 'Treble_Shelf'
end


%% System parameters
Fs = 44100;     %Hz
Fsw = Fs*2*pi;  %sample rate rad/s
Ts=1/Fs;

%% Fixed point parameters:
fractionalbits = 14; %12; % Highest coeff value found until now is <~4, need three integer bits(S,2,1), 16-3 = 13
integerbits = 32-fractionalbits;
scalefactor = 2^fractionalbits; % equals '1' in the system
fractionaldatatype = sprintf('Q%i.%i',integerbits,fractionalbits)

%% Check input parameters:
if filterset == 1
    filterstructname = 'bass';
elseif filterset == 2 
    filterstructname = 'midrange';
elseif filterset == 3
    filterstructname = 'treble';
else
    error('eq_coeffgen: Please choose filterset 1,2 or 3');
end  

%% 
arraysize = length(G);
if arraysize > 1
    single =0;
elseif arraysize == 1;
    single =1;
end



%% SINGLE COEFFISIENT SET %% length(G)
if single == 1 
    %% Generate filter coefficient 
        if or(filterset == 1,filterset == 3)
            [stage1.b_double,stage1.a_double] = shelving(G, fc, Fs, Q, filtertype);
        end
        if filterset == 2
            [stage1.b_double,stage1.a_double] = peak(G, fc, Fs, Q);
        end
        
    %% Convert to fixed point 32bit
        if genfixpoint == 1
       
            % _16 For use with rouding error check:
            a_16 = fi(stage1.a_double,1,16,fractionalbits);   %Q3.13 to prevent integer rounding errorstop clipping, may need to be extended further for other sets?
            b_16 = fi(stage1.b_double,1,16,fractionalbits);
            % _32 Used for new coefficients
            a_32 = fi(stage1.a_double,1,32,fractionalbits);
            b_32 = fi(stage1.b_double,1,32,fractionalbits);   %Q19.13 to prevent integer rounding errorstop clipping, may need to be extended further for other sets?

            %% Generate coefficient structure:
            stage1.type = filtertype;               %'Base_shelv', 'Treble_shelv', or 'Notch'
            stage1.fc = fc;      
            stage1.gain = G;
            stage1.q = Q;                           %Q-factor
            stage1.dataformat = fractionaldatatype;   % QI.F
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
   
           
    %% Generate plot
    iirplotresponseDouble(stage1,bodegen,rootlocus,Fs);
    
    %% print coefficient structure:
    stage1

%% MULTIPLE COEFFISIENT SET
else
    % Generate coefficients and transferfunctions:
    stage1 = cell(1,arraysize); %Cell of coeff structs
       
    
    %% Generate filter coefficient 
% % %        if or(filterset == 1,filterset == 3)
            
       for i = 1:arraysize

            if or(filterset == 1,filterset == 3)
                [stage1{i}.b_double,stage1{i}.a_double] = shelving(G(i), fc, Fs, Q, filtertype);
            end
            if filterset == 2                
                [stage1{i}.b_double,stage1{i}.a_double] = peak(G(i), fc, Fs, Q);
            end
            
            
            
            % _16 For use with rouding error check:
            stage1{i}.a_16 = fi(stage1{i}.a_double,1,16,fractionalbits);   %Q3.13 to prevent integer rounding errorstop clipping, may need to be extended further for other sets?
            stage1{i}.b_16 = fi(stage1{i}.b_double,1,16,fractionalbits);
            % _32 Used for new coefficients
            stage1{i}.a_32 = fi(stage1{i}.a_double,1,32,fractionalbits);
            stage1{i}.b_32 = fi(stage1{i}.b_double,1,32,fractionalbits);  
          
           %% Generate coefficient structure:

           
            stage1{i}.type = filtertype;               %'Base_shelv', 'Treble_shelv', or 'Notch'
            stage1{i}.fc = fc;      
            stage1{i}.gain = G(i);
            stage1{i}.q = Q;                           %Q-factor
            stage1{i}.dataformat = fractionaldatatype;   % QI.F
            stage1{i}.scalefactor = scalefactor;       % Can be made local for each coefficient set (later)
            stage1{i}.a = int32(storedInteger(stage1{i}.a_32));  %to be replaced with actual generation
            stage1{i}.b = int32(storedInteger(stage1{i}.b_32)); 
                    
            % discrete transferfunction for use with plots etc:
            stage1{i}.tfd = tf(stage1{i}.b_double,stage1{i}.a_double,Ts,'variable','z^-1'); 
            stage1{i}.tfd_32 = tf(stage1{i}.b_32,stage1{i}.a_32,Ts,'variable','z^-1');      %fixed point coeffs            
            
            %% Check for saturation in rounding:
            stage1{i}.coeffquanterror_16_b = abs(stage1{i}.b_double - double(stage1{i}.b_16));
            stage1{i}.coeffquanterror_16_a = abs(stage1{i}.a_double - double(stage1{i}.a_16));
            stage1{i}.coeffquanterror_16_max = max(max(stage1{i}.coeffquanterror_16_b),max(stage1{i}.coeffquanterror_16_a))  ;             
            if (stage1{i}.coeffquanterror_16_max > 0.5) %0.002) % should probably calculate properly                
                [stage1{i}.b_double,stage1{i}.a_double]
                [stage1{i}.b_16,    stage1{i}.a_16]
                [stage1{i}.b_32,    stage1{i}.a_32]
                stage1{i}.coeffquanterror_16_max
                error('eq_coeffgen: Integer rounding error when converting from double at coeff struct{%i}!',i);                      
            end
            
            
            %% Stability check:
                %% Stability check:    
            if (isstable(stage1{i}.tfd) == 0)
                error('eq_coeffgen: Original double type filter is not stable (struct{%i}.tfd)',i);  
            end

            if (isstable(stage1{i}.tfd_32) == 0)
                error('eq_coeffgen: 32bit fixed point type filter is not stable (struct{%i}.tfd_32)',i);
            end
            
            
            

            
            
            
       end
       
       %% Generate plot
       iirplotresponseDouble(stage1,bodegen,rootlocus,Fs);
       

end 


%% Create coefficient files

%% Generate .c file for coefficients.
% For single coefficient set:
%%if single ==1
    
    if and((genfixpoint == 1),(fprintfixedpoint == 1))  ;    % Generate fixed point coefficients

        eq_createcoefffile(stage1,filterstructname,'eqcoeff');
    end
%multiple:
%elseif
%%end

