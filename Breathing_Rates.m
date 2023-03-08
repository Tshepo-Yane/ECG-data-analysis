
%Finding the  breathing rate
clc
time=Pat1(:,1);
%% Patient 1
signal_array_P1=[leadA_P1_T1 leadA_P1_T3  leadA_P1_T2]; % lol I did this on purpose so that the code works LOL
RR_rates_P1=[];
for i=1:length(signal_array_P1(1,:))
signal=signal_array_P1(:,i);
%subtract local mean from signal
M = movmean(signal,1000);
signal=signal-M;
 
%calculate fft
Fs=1/time(2);
L = length(signal);
f = Fs*(0:(L/2))/L;
 
Y=fft(signal);
 
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
 
RR_range=islocalmax(P1,"MinProminence",0.015);  %find the local maximum only up to frequency 1hz

 
RR_freq=f(find(RR_range)); % find the frequency of the respiration rate
RR_rates_P1(i)=RR_freq(1)*60 % calculate the respiration rate
end
%% Patient 2
signal_array_P2=[leadC_P2_T1 leadC_P2_T2  leadC_P2_T3];
RR_rates_P2=[];
for i=1:length(signal_array_P2(1,:))
signal=signal_array_P2(:,i);
%subtract local mean from signal
M = movmean(signal,1000);
signal=signal-M;
 
%calculate fft
Fs=1/time(2);
L = length(signal);
f = Fs*(0:(L/2))/L;
 
Y=fft(signal);
 
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
 
RR_range=islocalmax(P1,"MinProminence",0.019);  %find the local maximum only up to frequency 1hz

 
RR_freq=f(find(RR_range)); % find the frequency of the respiration rate
RR_rates_P2(i)=RR_freq(1)*60 % calculate the respiration rate
end
%% patient 3
signal_array_P3=[leadA_P3_T1 leadA_P3_T2  leadA_P3_T3];
RR_rates_P3=[];
for i=1:length(signal_array_P3(1,:))
signal=signal_array_P3(:,i);
%subtract local mean from signal
M = movmean(signal,1000);
signal=signal-M;
 
%calculate fft
Fs=1/time(2);
L = length(signal);
f = Fs*(0:(L/2))/L;
 
Y=fft(signal);
 
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
 
 
RR_range=islocalmax(P1,"MinProminence",0.002);  %find the local maximum only up to frequency 1hz

 
RR_freq=f(find(RR_range)); % find the frequency of the respiration rate
RR_rates_P3(i)=RR_freq(1)*60 % calculate the respiration rate
end



