% Script that select filter coefficients for simulink testbench
% "singleBiquadTestbench2" by selecting the next coefficient set in list.
% Preben Thorød - HandyEQ - Chalmers University of Technology 2014

if exist('A') ~= 1
    error('ERROR: Multiple coefficient cell array is not initialized, please run eq_testbench1.m')
else    
    if exist('count') ~= 1
        count = 0 ;
    end

    if count < N_coeff
        count = count + 1;   
    else 
        count = 1;
    end

    disp('Changed gain gain to: ')   
    disp(Gm(count));
    
    if length(fc) > 1
        disp('fc = ');
        disp(fc(count));    
    end
    
    %test set param:
    set_param('singleBiquadTestbench2/B_coeff','Value',mat2str(B{count}'));
    set_param('singleBiquadTestbench2/A_coeff','Value',mat2str(A{count}(2:3)'));
    set_param('singleBiquadTestbench2/Gain','Value',num2str(Gm(count)));
    
    
    hbode = bodeplot(tfd{count});
    setoptions(hbode,'FreqUnits', 'Hz','FreqScale', FreqScale, 'Xlim',[10 Fs/2]); %doc plotoptions
end


