% GUI Menu to select filter coefficients for simulink testbench
% "singleBiquadTestbench2"
% Plots bode plot of selected filter
% Note: When GUI is open, simulation is halted
% Preben Thorød - HandyEQ - Chalmers University of Technology 2014

num2str(Gm);
indexlist = cell(1,N_coeff);

for i = 1:N_coeff        
    indexlist{i} = num2str(Gm(i));
end
selected = menu('select gain:', indexlist);
setcoeff(selected, A, B, Gm);

%Bode plot for selected filter curve
opts = bodeoptions;
opts.Xlim = [10 Fs/2];
opts.FreqUnits = 'Hz';
opts.FreqScale = FreqScale;
opts.YLim = {[-20,20];[-360,0]};    %{maglimits;phaselimits}
opts.YLimMode = {'manual';'auto'};  %{maglimits mode;phaselimits mode}

hbode = bodeplot(tfd{selected},opts);  







