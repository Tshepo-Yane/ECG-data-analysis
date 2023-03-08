%Tshepo Yane 
% design challenge
% load data
clc
clear all
load("subject1.mat")

%strip data
Lead2=data(:,2);
Lead2=Lead2(1:20000);
signal_length=length(Lead2);

moving_mean = movmean(Lead2,1000);
Lead2=Lead2-moving_mean;

%filter data
Lead2=lowpass(Lead2,0.05);

sample_frequency=2000; %hz
time_total=signal_length/sample_frequency; %  350 seconds;
time_to_idx=signal_length/time_total; %time to index conversion factor
time_vec=(1:signal_length);

mins = islocalmin(Lead2,'MinProminence',0.15);
maxs= islocalmax(Lead2,'MinProminence',0.15);
TF = islocalmin(Lead2,'MinProminence',0.03);

mins=find(mins);
maxs=find(maxs);
%find local mins

%plot data
figure()
plot(time_vec,Lead2,time_vec(mins),Lead2(mins),'r*',time_vec(maxs),Lead2(maxs),'g*')
%hold on 
%plot(time_vec(TF),Lead2(TF),"ko")

%separate P peaks from T peaks
P_idx_long=maxs(1:3:end);
T_idx_long=mins(3:3:end);

max_len=min(length(P_idx_long),length(T_idx_long));

P_ind=P_idx_long(1:max_len);
T_ind=T_idx_long(1:max_len);

figure()
%this plot makes sure that we are identifing the right indicies to find
%the duration of a heart beat
plot(time_vec,Lead2,time_vec(T_ind),Lead2(T_ind),'r*',time_vec(P_ind),Lead2(P_ind),'g*') 

duration_ind=T_ind-P_ind;
hr_duration=duration_ind/time_to_idx;

avg_PT_time=mean(hr_duration);
std_PT_time=std(hr_duration);


