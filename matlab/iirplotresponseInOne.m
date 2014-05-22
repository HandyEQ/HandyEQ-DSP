function [  ] = iirplotresponseInOne( coeffStruct1, coeffStruct2, coeffStruct3, bodegen,rootlocus,Fs)

    bodegen_plotphase = 'off';
    bodegen_FreqScale = 'log';

    if or(bodegen,rootlocus)
        scrsz = get(0,'ScreenSize');
        fig_bodelocus = figure('Position',[2 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2-78]);                
    end 
        
  
        
        
        
    %% Plot multiple filter plot:    

        
    nfilters1 = length(coeffStruct1);
    nfilters2 = length(coeffStruct2);
    nfilters3 = length(coeffStruct3);
    if bodegen == 1  
        subplot(1,bodegen+rootlocus,1);            
        for i = 1:nfilters1
            hbode = bodeplot(coeffStruct1{i}.tfd,'k'); 
            hold on;            
        end   

        for i = 1:nfilters2
            hbode = bodeplot(coeffStruct2{i}.tfd,'k'); 
            hold on;            
        end 

        for i = 1:nfilters3
            hbode = bodeplot(coeffStruct3{i}.tfd,'k'); 
            hold on;            
        end 
        
        h = findobj(gcf,'type','line');
        set(h,'linewidth',2);
        setoptions(hbode,'MagVisible','on','PhaseVisible', bodegen_plotphase,'FreqUnits', 'Hz','FreqScale', bodegen_FreqScale); %, 'Xlim',[10 Fs/2]);
        setoptions(hbode,'Ylim',[-24 24], 'Xlim',[10 Fs/2],'Grid','on');
        hold off;


    end

    if rootlocus == 1            
        subplot(1,bodegen+rootlocus,bodegen+1);        
        for i = 1:nfilters1           
            rlocus(coeffStruct1{i}.tfd)
            hold on;
            rlocus(coeffStruct1{i}.tfd_32)  %force red color
        end  
        for i = 1:nfilters2           
            rlocus(coeffStruct2{i}.tfd)
            hold on;
            rlocus(coeffStruct2{i}.tfd_32)  %force red color
        end 
        for i = 1:nfilters3           
            rlocus(coeffStruct3{i}.tfd)
            hold on;
            rlocus(coeffStruct3{i}.tfd_32)  %force red color
        end             
        hold off;
    end
    
        
        







end

