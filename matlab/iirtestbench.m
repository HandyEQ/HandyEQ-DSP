%% Testbench and algorithm for fixed point IIR filter.
%   Uses coefficients generated by eq_testbench1

%% Input parameters:

%% NEXT: Okay, both impulse, step and audio testbench seems to work for basic input, 

%!! Fs system og Fs audiofile can be different!

%% Responseanalysis:
plotfft=1; %
plotimpulse = 0;
createImpulseFile = 1;
    ImpulseFileMaxLength = 500;

%% Main testmethod:    
testmethod  =2;  % 0 = impulse response, 1 = stepresponse, 2 =audiofile 3 = bypass
plotsignals = 0;

% Audio properties:
instantplayback = 0;    %Called by play(player)
genwavfile = 1;
%Audioinput:
audiopath = 'C:\Users\Preben\Dropbox\Matlab\Dat096\Audiofiles\FLAC\';
scaleinputsignal = 1 ; % To enable headroom for 12dB gainboost.

    %Lothe
%     inputaudiofile = 'lothesimplerdays.flac';
%     t_start = 10; %seconds (cant be zero)
%     t_end = 30; %seconds

    %Daft punk
    inputaudiofile = 'getlucky.flac';
    t_start = 30; %seconds (cant be zero)
    t_end = 50; %seconds�

    %Metallica
%     inputaudiofile = 'sadbuttrue.flac';
%     t_start = 56; %seconds (cant be zero)
%     t_end = t_start+20; %seconds

%Wavgeneration properties:
outputaudiofile = 'output';
outputaudiofileformat = '.flac';
timestamp = datestr(now, 'mmdd_HHMM');
outputaudiofilewithpath = sprintf('%s%s_%s%s',audiopath,outputaudiofile,timestamp,outputaudiofileformat);

%plot properties
plotaccumulators = 1;
plotlength = 50;
audioplotlength = 88200;
audiooffset = 200000;


%% Create test signals:
%% Impulse
if testmethod == 0 %Impuls response
    disp('iirtestbench: Testing IIR filters impulseresponse');
    impulselength = 1000;
    impulseratio = 1;
    impulseonevalue =  16384*impulseratio; %2147483647*impulseratio;
    testsignal = zeros(impulselength, 'int32');
    testsignal(1) = impulseonevalue;
    
elseif testmethod == 1 % Step response
    steplength = 100;
    stepratio = 0.5;
    steponevalue = 32768*stepratio;
    testsignal(1:3) = 0;
    testsignal(4:steplength) = steponevalue;
    
elseif testmethod ==2 % Audio file
    %% Import audio file
    audiofilewithpath = sprintf('%s%s',audiopath,inputaudiofile);
    disp('iirtestbench: Reading audiofile: ');
    disp(audiofilewithpath);%s',audiofilewithpath);
    %get fs:
    [~,Fs] = audioread(audiofilewithpath);
    %calculate interval
    N_start = Fs * t_start +1;
    N_end = Fs * t_end;
    N_size = N_end - N_start;
    t_size = t_end - t_start;
    [y,Fs] = audioread(audiofilewithpath,[N_start N_end],'native');
    %mono
    testsignal_16 = y(:,1:1);    
    if scaleinputsignal == 1 
        testsignal_16 = testsignal_16 / 4;
    end    
    testsignal = int32(testsignal_16);  
elseif testmethod == 3 %bypass
    disp('iirtestbench: bypassing main test');


else
    error('please assign 0,1 or 2 to testmethod');    
end

%% ONLY FOR FFT
%runs impulseresponse and plots fft
if plotfft == 1
    %init
    disp('iirtestbench: Testing IIR filters impulseresponse and frequenzy response');
    impulselength = 4000;
    impulseratio = 1;
    impulseonevalue =  16384*impulseratio; %2147483647*impulseratio;
    impulsesignal = zeros(impulselength, 'int32');
    impulsesignal(1) = impulseonevalue;
    
    [outputimpulseresponse, ~] = directform1biquad(impulsesignal,stage1);
    
    %plots impulse and frequencyresponse of stage1:

    try 
        close(fig_response1);       
    end    
    scrsz = get(0,'ScreenSize');    
    fig_response1 = figure('Name','Measured response from stage1','Position',[scrsz(3)/2 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2-78]);  
   
    responseanalysis(outputimpulseresponse,impulseonevalue,Fs,plotimpulse);

end




%% RUN STAGE1:

[outputresponse, acc1] = directform1biquad(testsignal,stage1);

%% Plot signal and info:
hfig_signal = figure(1);
if plotsignals == 1
if plotaccumulators == 1
    disp('iirtestbench: Plotting');
    %Input signal
    hplot(1) = subplot(2,3,1);
    stem(hplot(1), testsignal, 'Marker', 'none');
    title(hplot(1),'Test signal 16bit')
    ylabel(hplot(1),'Amplitude')
    ylim(hplot(1), [-32768 32767]) 
 
  
    %Accumulator 1 before scaling
    hplot(2) = subplot(2,3,2);
    stem(hplot(2), acc1, 'Marker', 'none');
    title(hplot(2),'Accumulator 1 before scaling 32bit')
    ylabel(hplot(2),'Amplitude - 32bit')
    ylim(hplot(2), [-2147483648 2147483647])
    
%     %Accumulator 1 after scaling
%     hplot(3) = subplot(2,3,3);    
%     stem(hplot(3), acc2, 'Marker', 'none');
%     %title(hplot(3),'Accumulator 1 after scaling 32bit')
%     title(hplot(3),'Accumulator 1 after scaling zoomed to 18bit')
%     ylabel(hplot(3),'Amplitude - 32bit')
%    % ylim(hplot(3), [-32768 32767]) %16bit
%      %ylim(hplot(3), [-65536 65535]) %17bit
%      ylim(hplot(3), [-131072 131071]) % 18bit
%    
%    % ylim(hplot(3), [-2147483648 2147483647]) %32bit
   
   
    
%     %Output accumulator before scaling
%     hplot(4) = subplot(2,3,4);
%     stem(hplot(4), acc3, 'Marker', 'none');
%     title(hplot(4),'Output accumulator before scaling - 32 bit')
%     ylabel(hplot(4),'Amplitude - 32bit')
%     ylim(hplot(4), [-2147483648 2147483647])
    
    
    
    %32bit output
    hplot(5) = subplot(2,3,5);
    stem(hplot(5), outputresponse, 'Marker', 'none');
    title(hplot(5),'Output signal 32 bit')
    ylabel(hplot(5),'Amplitude')
    ylim(hplot(5), [-2147483648 2147483647])
    
    %Output zoomed to 16bit
    hplot(6) = subplot(2,3,6);
    stem(hplot(6), outputresponse, 'Marker', 'none');
    title(hplot(6),'Output signal zoomed to 16 bit')
    ylabel(hplot(6),'Amplitude')
    ylim(hplot(6), [-32768 32767])    
else

    hmusic(1) = subplot(2,1,1);
    hmusic(2) = subplot(2,1,2);

    %plot(hmusic(1),testsignal(audiooffset+1:audiooffset+audioplotlength+1));

    stem(hmusic(1), testsignal);
    title(hmusic(1),'Test signal 32 bit')
    ylabel(hmusic(1),'Amplitude')
    ylim(hmusic(1), [-2147483648 2147483647])

    %16bit: ylim(hmusic(1), [-32768 32767])

    %plot(hmusic(2),testsignal_32)
    %stem(hmusic(2),impulsesignal(1:plotlength+1));

    stem(hmusic(2),outputresponse);
    title(hmusic(2),'Impulse response 32bit')
    ylabel(hmusic(2),'Amplitude 32bit')
    ylim(hmusic(2), [-2147483648 2147483647])

end
end

max_input = max(testsignal);
%min_input = min(testsignal);
max_acc1 = max(acc1);
% % max_acc2 = max(acc2);
% % max_acc3 = max(acc3);
max_output = max(outputresponse);
%min_output = min(outputresponse);



fprintf('\niirtestbench: max(testsignal) = %i, utilisating %i bits\n',max_input,ceil(log2(double(max_input))))
fprintf('iirtestbench: max(acc1) = %i, utilisating %i bits\n',max_acc1,ceil(log2(double(max_acc1))))
% % fprintf('iirtestbench: max(acc2) = %i, utilisating %i bits\n',max_acc2,ceil(log2(double(max_acc2))))
% % fprintf('iirtestbench: max(acc3) = %i, utilisating %i bits\n',max_acc3,ceil(log2(double(max_acc3))))
fprintf('iirtestbench: max(output) = %i, utilisating %i bits\n\n',max_output,ceil(log2(double(max_output))))
%max_level_32 = min(testsignal_32)
%min_level_32 = max(testsignal_32)
%% Playback
if testmethod == 2
    disp('iirtestbench: Formatting audio for playback');
    %Create stereo 16bit audio vector:   
    outputresponse_16 = int16(outputresponse);
    ouputsignal = [testsignal_16 outputresponse_16'];
    player = audioplayer(ouputsignal,Fs);
 %   player = audioplayer(outputresponse_16,Fs);
    
    
    if (instantplayback == 1) 
        play(player);
    end
    
    %if createwav -> wavwrite
    
    %mono/old:
    %player = audioplayer(testsignal_16,Fs);
    %if (instantplayback == 1) 
    %    play(player);
    %end
end

%% Generate stereo testfile
if and(genwavfile == 1,testmethod == 2)
       disp('iirtestbench: Generating wav file');
       disp(outputaudiofilewithpath);
       audiowrite(outputaudiofilewithpath,ouputsignal,Fs);
       
       disp('iirtestbench: Done generating audiofile');
end

disp('iirtestbench: Completed!');

%% Generate file holding impulseresponse in integers:

%-> Should be moved to generic function
% Statistics, and compare could be independent of fileplot!
if createImpulseFile == 1
    
    %%NOTE TO SELF: impz(stage1.b_double,stage1.a_double) --> Can compare with
    %%original impulseresponse
    
    %testing: generate original impulseresponse:
    
    [impulseResponseDouble,~] = impz(stage1.b_double,stage1.a_double);
    impulseResponseDouble =impulseResponseDouble*impulseonevalue; %Scale up
        
    disp('iirtestbench: Generating impulse response file ''impulseResponse.txt''');
    impulseFile = fopen('Dat096/impulseResponse.txt','wt');
   
    impulsefilelength = min(length(outputimpulseresponse),ImpulseFileMaxLength);
    impulsefilelength = min(impulsefilelength,length(impulseResponseDouble));
    
   %% impulsefilelength = min(length(outputimpulseresponse),ImpulseFileMaxLength,impulseResponseDouble);
    
    
    fprintf(impulseFile,'N = %i;\n',impulsefilelength);
    fprintf(impulseFile,'one/scalefactor = %i;\n',impulseonevalue); 
    
    %% SHOULD ADD TAG: Date, spec on filter/system
    fprintf(impulseFile,'\n');
    for i = 1:impulsefilelength
     %%% fprintf(impulseFile,'n=%i\t\t\t%i \n',i,outputimpulseresponse(i)); 
     
      
      impulsediff_100=(double(outputimpulseresponse(i))-impulseResponseDouble(i))*100/impulseResponseDouble(i);
      fprintf(impulseFile,'n=%i \t\t %i \t\t\t\t %f \t\t\t\t diff: %f%%\n',i,outputimpulseresponse(i),impulseResponseDouble(i),impulsediff_100); 
      %fprintf(impulseFile,'\n');
    end
    
    
    fclose(impulseFile);
    disp('iirtestbench: impulseResponse.txt created');
end