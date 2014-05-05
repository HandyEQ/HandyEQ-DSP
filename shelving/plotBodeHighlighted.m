function [ hbodetest ] = plotBodeHighlighted( tfd, highlighted, Fs )
    % Plot set of transferfunctions in blue with one highlighted in red
    opts = bodeoptions;
    opts.Xlim = [10 Fs/2];
    opts.FreqUnits = 'Hz';
    opts.FreqScale = 'log';
    opts.YLim = {[-20,20];[-360,0]};    %{maglimits;phaselimits}
    opts.YLimMode = {'manual';'auto'};  %{maglimits mode;phaselimits mode}
    
    for i = 1:length(tfd)
            
            hbodetest{i} = bodeplot(tfd{i},opts,'b'); 
            hold on;
    end
    %Highlighted curve
    hbodetest{highlighted} = bodeplot(tfd{highlighted},opts,'r');
    hold off;


end

