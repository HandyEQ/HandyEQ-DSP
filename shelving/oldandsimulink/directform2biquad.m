function [y, acclog1, acclog2, acclog3] = directform2biquad( x )

    %remeber arrays starts from 1 in MATLAB, and from 0 in C
    
    %Bass 300hz +6db @44100fs
% 	a0 = 16384;
% 	a1 = -31887;
% 	a2 = 15532;
% 	b0 = 16567;
% 	b1 = -31872;
% 	b2 = 15363;
    
    %Bass 300hz -12db @44100fs
%     a0 = 16384;
% 	a1 = -30999;
% 	a2 = 14728;
% 	b0 = 15950;
% 	b1 = -31042;
% 	b2 = 15120;
    
    %Treble -12 db 3kHz @ 44100fs
%     a0 = 16384;
% 	a1 = -28211;
% 	a2 = 12502;
% 	b0 = 4727;
% 	b1 = -6833;
% 	b2 = 2782;
%     
    %Allpass: 0db gain:
    a0 = 16384;
	a1 = 0;
	a2 = 0;
	b0 = 16384;
	b1 = 0;
	b2 = 0;
  
    scalevalue = 65536; %16384; ;  %16384;  %%%!!! Coefficients should follow same scalevalue as accumulator scaling??
    scalevalue_acc1 = 65536;
    scalevalue_output = 4096; %16384; %1: (16384/4); 
    %scalevalue_acc1 = scalevalue*2;%*2;
    %scalevalue_output = scalevalue/2;  %%works wit 0db
    N = length(x);
    
    y = zeros(1,N,'int32');
    p = zeros(1,N,'int32');
    wmem = zeros(1,3,'int32');
    acclog1 = zeros(1,3,'int32'); %Accumulator before scaling % THESE GROW TO N
    acclog2 = zeros(1,3,'int32'); %Accumulator after scaling
    acclog3 = zeros(1,3,'int32'); % ouput before scaling
    
    for i = 1:N  
   %%%%%%%%% for i = 3:N  
      %%TESTING SIGN SWITCH: wmem(1) = (a0*x(i)) - (a1*wmem(2)) - (a2*wmem(3));  %%Remember that a0 is not equal one!;
       wmem(1) = (a0*x(i)) + (a1*wmem(2)) + (a2*wmem(3));  %%Remember that a0 is not equal one!;
       %%%%%%%%% p(i) = (a0*x(i)) - (a1*p(i-1)) - (a2*p(i-2));
        acclog1(i) = wmem(1);
        
     %%%%%%%%%   p(i) = p(i)/scalevalue_acc1;
        
     wmem(1) = wmem(1)/scalevalue_acc1;  %%WRONG?
        
        acclog2(i) = wmem(1);
     
        %%Scaling here        
        
        %%%%%%%%%y(i) = (b0*p(i)) + (b1*p(i-1)) + (b2*p(i-2));
        
       y(i) = (b0*wmem(1)) + (b1*wmem(2)) + (b2*wmem(3));
        
        acclog3(i) = y(i);
        y(i) = y(i)/scalevalue_output;
        
           
        %shift memory
        wmem(3) = wmem (2);
       wmem(2)	= wmem (1);
    end
    
 
    

    
    %for
  %%%%  wmem(1) = x - (a1*wmem(2)) - (a2*wmem(3));
    
    
 %%%%   y = (b0*wmem(1)) + (b0*wmem(2)) + (b1*wmem(3));
    
    
    
    
    %wmemlog = wmem(n)
    
    %shift memory
%%%%	wmem(3) = wmem (2);
%%%	wmem(2)	= wmem (1);
       
end

