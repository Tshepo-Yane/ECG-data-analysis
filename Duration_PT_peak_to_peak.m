%Tshepo Yane 
% design challenge
% load data
clc
clear all
load("subject1.mat")

%strip data
Lead2=data(:,2);
Lead2=Lead2(1:end);
signal_length=length(Lead2);

moving_mean = movmean(Lead2,1000);
Lead2=Lead2-moving_mean;

sample_frequency=2000; %hz
time_total=signal_length/sample_frequency; %  350 seconds;
time_to_idx=signal_length/time_total; %time to index conversion factor
time_vec=(1:signal_length);


maxs= islocalmax(Lead2,'MinProminence',0.2);

maxs=find(maxs);
%find local mins

%plot data
%figure()
%plot(time_vec,Lead2,time_vec(maxs),Lead2(maxs),'g*')

%separate P peaks from T peaks
P_idx=maxs(1:3:end);
T_idx=maxs(3:3:end);


figure()
%this plot makes sure that we are identifing the right indicies to find
%the duration of a heart beat
gg=20*2000;
plot(time_vec,Lead2,time_vec(T_idx),Lead2(T_idx),'r*',time_vec(P_idx),Lead2(P_idx),'g*') 
%xlim([0 1e7])

duration_ind=T_idx-P_idx(1:end);
hr_duration=duration_ind/time_to_idx;

avg_PT_time=mean(hr_duration);
std_PT_time=std(hr_duration);


