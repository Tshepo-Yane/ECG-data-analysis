%Tshepo Yane
%BE 310
%import data
data= readtable('2021_BE310_ECG_resting_3_patient.xlsx');
Lead1=table2array(data(:,3));
Lead2=table2array(data(:,4));
Lead3=table2array(data(:,5));
%%
% plot(Lead1)
Ts=table2array(data(1,1));
y = fft(Lead1);   
fs = 1/Ts;
f = (0:length(y)-1)*fs/length(y);

plot(f,abs(y))
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('Magnitude')

%% lab data
clear all;clc

load("subject2.mat");


Lead1=data(:,1);
Lead2=data(:,2);
Lead3=data(:,3);

% create loop to find the heartbeat per minute by looking at 60 second window

time_total=350; % seconds
n=length(data);
time_to_idx=n/time_total;
minute_window=35*time_to_idx;
hr_store=zeros(1, n/minute_window);
  


window_look=minute_window*(i-1):minute_window*(i);


window=Lead2(window_look);
window_array=1:length(window);

TF2 = islocalmax(Lead2(window_look),'MinProminence',1);

plot(window_array,window,window_array(TF2),window(TF2),'r*')


hr_store(i)=sum(TF2);




%%
plot(Lead1(1:10000))
hold on

plot(Lead2(1:10000))
plot(Lead3(1:10000))




