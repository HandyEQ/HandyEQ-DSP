%function [h,f] = responseanalysis = (x_scaled,scalevalue,Fs);

%Scale back
scalevalue=16384;
Fs=44100;

x_scaled=double(outputimpulseresponse);
x=x_scaled/scalevalue;

L=length(x);
NFFT = 2^nextpow2(L);   %Find closets power of 2 for faster FFT
X  = fft(x,NFFT);  %/L;  %%hmm...why not scale with L?
f = Fs/2*linspace(0,1,NFFT/2+1); %frequency vector

%%Plot Impulseresponse:
fig_response = figure(1);
subplot(1,2,1);
himpulse = stem(x_scaled,'Marker', 'none');
xlabel('N');
%need some fixing to look good


%%Plot Magnitude:
subplot(1,2,2);
hfreq = loglog(f,abs(X(1:NFFT/2+1)));

%Fix Y axis:
ytic = get(gca,'YTick');
ytic_dB = 20*log10(ytic);
%set(gca,'YTickLabel',yticlab)
set(gca,'YTickLabel',ytic_dB,'XGrid','on','YGrid','on');
ylabel('dB');

xlabel('Frequency');

