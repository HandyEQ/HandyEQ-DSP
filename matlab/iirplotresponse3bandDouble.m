

allcombinations = 0;
plotextremes = 1;
NSIZE = 9;


index1 = 9;
index2 = 9;
index3 = 9;


bodegen_plotphase = 'off';
bodegen_FreqScale = 'log';


figure 
if (allcombinations == 1)
    count = 0;
    for index1 = 1:NSIZE
       for index2 = 1:NSIZE
           for index3 = 1:NSIZE
                sys1 = series(stage1{index1}.tfd,stage2{index2}.tfd)
                sys2 = series(sys1,stage3{index3}.tfd)
                hbode = bodeplot(sys2);
                hold on;
                count = count +1
           end
        
       end
    end
    setoptions(hbode,'MagVisible','on','PhaseVisible', bodegen_plotphase,'FreqUnits', 'Hz','FreqScale', bodegen_FreqScale); %, 'Xlim',[10 Fs/2]);
    setoptions(hbode,'Ylim',[-24 24], 'Xlim',[10 Fs/2],'Grid','on');
    hold off;

else
    sys1 = series(stage1{index1}.tfd,stage2{index2}.tfd)
    sys2 = series(sys1,stage3{index3}.tfd)
    hbode = bodeplot(sys2); 
    setoptions(hbode,'MagVisible','on','PhaseVisible', bodegen_plotphase,'FreqUnits', 'Hz','FreqScale', bodegen_FreqScale); %, 'Xlim',[10 Fs/2]);
    setoptions(hbode,'Ylim',[-24 24], 'Xlim',[10 Fs/2],'Grid','on');
    
    
    if plotextremes == 1 
        hold off;
        
        
        index1 = 9;
        index2 = 5;
        index3 = 9;        
        sys1 = series(stage1{index1}.tfd,stage2{index2}.tfd);
        sys2 = series(sys1,stage3{index3}.tfd);
        hbode = bodeplot(sys2,'k'); 
        hold on;
        setoptions(hbode,'MagVisible','on','PhaseVisible', bodegen_plotphase,'FreqUnits', 'Hz','FreqScale', bodegen_FreqScale); %, 'Xlim',[10 Fs/2]);
        setoptions(hbode,'Ylim',[-24 24], 'Xlim',[10 Fs/2],'Grid','on');
        
        index1 = 9;
        index2 = 9;
        index3 = 5;        
        sys1 = series(stage1{index1}.tfd,stage2{index2}.tfd);
        sys2 = series(sys1,stage3{index3}.tfd);
        hbode = bodeplot(sys2,'k'); 
        

        
        index1 = 5;
        index2 = 9;
        index3 = 9;        
        sys1 = series(stage1{index1}.tfd,stage2{index2}.tfd);
        sys2 = series(sys1,stage3{index3}.tfd);
        hbode = bodeplot(sys2,'k'); 
        
%         index1 = 5;
%         index2 = 5;
%         index3 = 9;        
%         sys1 = series(stage1{index1}.tfd,stage2{index2}.tfd);
%         sys2 = series(sys1,stage3{index3}.tfd);
%         hbode = bodeplot(sys2,'k'); 
        
%         index1 = 9;
%         index2 = 5;
%         index3 = 5;        
%         sys1 = series(stage1{index1}.tfd,stage2{index2}.tfd);
%         sys2 = series(sys1,stage3{index3}.tfd);
%         hbode = bodeplot(sys2,'k'); 
        
        
       
        index1 = 5;
        index2 = 5;
        index3 = 1;        
        sys1 = series(stage1{index1}.tfd,stage2{index2}.tfd);
        sys2 = series(sys1,stage3{index3}.tfd);
        hbode = bodeplot(sys2,'k');
        
        index1 = 5;
        index2 = 1;
        index3 = 5;        
        sys1 = series(stage1{index1}.tfd,stage2{index2}.tfd);
        sys2 = series(sys1,stage3{index3}.tfd);
        hbode = bodeplot(sys2,'k');
        
        index1 = 1;
        index2 = 5;
        index3 = 5;        
        sys1 = series(stage1{index1}.tfd,stage2{index2}.tfd);
        sys2 = series(sys1,stage3{index3}.tfd);
        hbode = bodeplot(sys2,'k');
        
        index1 = 8;
        index2 = 8;
        index3 = 8;        
        sys1 = series(stage1{index1}.tfd,stage2{index2}.tfd);
        sys2 = series(sys1,stage3{index3}.tfd);
        hbode = bodeplot(sys2,'g');
        
        index1 = 1;
        index2 = 1;
        index3 = 1;        
        sys1 = series(stage1{index1}.tfd,stage2{index2}.tfd);
        sys2 = series(sys1,stage3{index3}.tfd);
        hbode = bodeplot(sys2,'r');
        
        index1 = 9;
        index2 = 9;
        index3 = 9;        
        sys1 = series(stage1{index1}.tfd,stage2{index2}.tfd);
        sys2 = series(sys1,stage3{index3}.tfd);
        hbode = bodeplot(sys2,'r'); 
        
        h = findobj(gcf,'type','line');
        set(h,'linewidth',2);
        
    end
    
end