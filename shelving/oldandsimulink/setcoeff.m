% Function for setting sending filter coefficients to Simulink testbench:
% "BiquadTestbench_1band"
% Preben Thorød - HandyEQ - Chalmers University of Technology 2014

function [ ] = setcoeff( coeffIndex, acoeff, bcoeff, gainlist  )
    set_param('BiquadTestbench_1band/B_coeff','Value',mat2str(bcoeff{coeffIndex}'));
    set_param('BiquadTestbench_1band/A_coeff','Value',mat2str(acoeff{coeffIndex}(2:3)'));
    set_param('BiquadTestbench_1band/Gain','Value',num2str(gainlist(coeffIndex)));
    
end

