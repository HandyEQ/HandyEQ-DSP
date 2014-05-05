function [y, acclog1] = directform1biquad(x,coeffstruct)

    % Direct form I biquad IIR filter
    % Works on x input buffer, takes coeffstruct as input


% Coefficient structure as input argument.
% ( Extra transfer just so it's easier to read algorithm)
	a0 = coeffstruct.a(1);
	a1 = coeffstruct.a(2);
	a2 = coeffstruct.a(3);
	b0 = coeffstruct.b(1);
	b1 = coeffstruct.b(2);
	b2 = coeffstruct.b(3);
    scalevalue = coeffstruct.scalefactor;
    
    N = length(x);
    xmem1 = int32(0);
    xmem2 = int32(0);
    ymem1 = int32(0);
    ymem2 = int32(0);
    y_upscaled = int32(0);
    
    y = zeros(1,N,'int32');
    
    %Output accumulator before scaling
    acclog1 = zeros(1,3,'int32'); 
        
    for i = 1:N  
        y_upscaled = b0*x(i) + b1*xmem1 + b2*xmem2 - a1*ymem1 - a2*ymem2;
        acclog1(i) = y_upscaled;
        y(i) = y_upscaled / scalevalue;       
        
        %shift delay line:
        xmem2 = xmem1;
        ymem2 = ymem1;
        xmem1 = x(i);
        ymem1 = y(i);
       

    end
   
 
    

       
end

