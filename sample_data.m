%  sample data load
clc
clear all

%load sample data
data=xlsread("2021_BE310_ECG_resting_3_patient.xlsx");
%% 
lead2=data(:,4);

moving_mean = movmean(lead2,1000);
signal=lead2-moving_mean;


Breathing_rate=0.003; % approximate  breathing rate cut off 
y1 = lowpass(signal,Breathing_rate); % removing high frequncy components
y = highpass(y1,Breathing_rate/5); % removing low frequncy components

%compute fft and power of the signal
Y=fft(y);

Fs = data(1,1);
L = length(lead2);
f = Fs*(0:(L/2))/L;

time_array=linspace(1,length(lead2)/Fs,length(lead2));
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);


signal_fft_mag=abs(Y);
signal_fft_abs=signal_fft_mag((1: 1+length(signal_fft_mag)/2));
signal_power=signal_fft_abs.^2;


figure
subplot(2,1,1)
plot(f,P1)
xlabel("Normalized Frequency")
ylabel("Signal Power (Watt)")
set(gca,'FontSize',14)
grid on
grid minor


subplot(2,1,2)
plot(time_array,y)
xlabel("Time (s)")
ylabel("Electrical Potential (mV) ")
set(gca,'FontSize',14)
grid on
grid minor