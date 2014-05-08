function [  ] = impulseresponseplot( input_scaled,scalevalue,Fs,plotimpulse )
    

   %function [y, acclog1] = directform1biquad(x,coeffstruct)

    %scalevalue=16384;
    %Fs=44100;

    %Convert to double and scale back
    x_scaled=double(input_scaled);
    x=x_scaled/scalevalue;
    
    

    L=length(x);
    NFFT = 2^nextpow2(L);   %Find closets power of 2 for faster FFT
    X  = fft(x,NFFT);  %/L;  %%hmm...why not scale with L?
    X_mag = abs(X);
    f = Fs/2*linspace(0,1,NFFT/2+1); %frequency vector

    %% Plot Impulseresponse:
   % fig_response = figure(3);
    if plotimpulse == 1
        subplot(1,2,1);    
        himpulse = stem(x_scaled,'Marker', 'none');
        title('Impulseresponse');
        xlabel('N');
        %need some fixing to look good
        
        
        
        subplot(1,2,2);
    end
   


    %% Plot Magnitude:
    
  %%%%%  hfreq = loglog(f,X_MAG(1:NFFT/2+1));
  
    X_mag_dB = 20*log10(X_mag);
    hfreq = semilogx(f,X_mag_dB(1:NFFT/2+1));  %,'Ylim', [-12 12]);
    title('Magnitude');
    ylim([-24 24]);
    set(gca,'XGrid','on','YGrid','on');
    ylabel('dB');
    
    %Fix Y axis:
 %%%%   ytic = get(gca,'YTick');
 %%%%   ytic_dB = 20*log10(ytic);
 %%%%   set(gca,'YTickLabel',ytic_dB,'XGrid','on','YGrid','on');
 %%%%   ylabel('dB');
    xlabel('Frequency');
end
