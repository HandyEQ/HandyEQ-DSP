% Function for setting sending filter coefficients to Simulink testbench:
% "singleBiquadTestbench2"
% Preben Thorød - HandyEQ - Chalmers University of Technology 2014

function [ ] = setcoeff( coeffIndex, acoeff, bcoeff, gainlist  )
    set_param('singleBiquadTestbench2/B_coeff','Value',mat2str(bcoeff{coeffIndex}'));
    set_param('singleBiquadTestbench2/A_coeff','Value',mat2str(acoeff{coeffIndex}(2:3)'));
    set_param('singleBiquadTestbench2/Gain','Value',num2str(gainlist(coeffIndex)));
    
end

