function [  ] = iirplotresponseDouble( coeffStruct,bodegen,rootlocus,Fs)

    bodegen_plotphase = 'off';
    bodegen_FreqScale = 'log';

    if or(bodegen,rootlocus)
        scrsz = get(0,'ScreenSize');
        fig_bodelocus = figure('Position',[2 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2-78]);                
    end 
        
    %% Plot single filter plot:
    if (isstruct(coeffStruct))
      
       
        if bodegen == 1  
            subplot(1,bodegen+rootlocus,1);
            hbode = bodeplot(coeffStruct.tfd); 
            setoptions(hbode,'MagVisible','on','PhaseVisible', bodegen_plotphase,'FreqUnits', 'Hz','FreqScale', bodegen_FreqScale); %, 'Xlim',[10 Fs/2]);
            setoptions(hbode,'Ylim',[-24 24], 'Xlim',[10 Fs/2],'Grid','on');
        end
        if rootlocus == 1      
            subplot(1,bodegen+rootlocus,bodegen+1);        
            rlocus(coeffStruct.tfd)
            hold on;
            rlocus(coeffStruct.tfd_32)  %force red color
            hold off;
        end
        
        
        
    %% Plot multiple filter plot:    
    elseif (iscell(coeffStruct))
        
        nfilters = length(coeffStruct);
        
        if bodegen == 1  
            subplot(1,bodegen+rootlocus,1);            
            for i = 1:nfilters
                hbode = bodeplot(coeffStruct{i}.tfd); 
                hold on;            
            end            
            setoptions(hbode,'MagVisible','on','PhaseVisible', bodegen_plotphase,'FreqUnits', 'Hz','FreqScale', bodegen_FreqScale); %, 'Xlim',[10 Fs/2]);
            setoptions(hbode,'Ylim',[-24 24], 'Xlim',[10 Fs/2],'Grid','on');
            hold off;
            

        end
        
        if rootlocus == 1            
            subplot(1,bodegen+rootlocus,bodegen+1);        
            for i = 1:nfilters            
                rlocus(coeffStruct{i}.tfd)
                hold on;
                rlocus(coeffStruct{i}.tfd_32)  %force red color
            end            
            hold off;
        end
    
        
        
    end






end

