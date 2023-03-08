% load data
load("subject2.mat");
data1=data;

%strip data
Lead1=data1(:,1);
Lead2=data1(:,2);
Lead3=data1(:,3);

Lead2=Lead2(1:130000);

% M = movmean(Lead2,1000);
% signal=Lead2-M;
% Lead2=signal;

num_chunks=1;
interval_length=length(Lead2)/num_chunks;
interval=(1:interval_length);
window_data = Lead2(interval);

time_total=65; % seconds
time=time_total/num_chunks;
time_to_idx=interval_length/time;

TF = islocalmin(window_data,'MinProminence',0.15);
%find local mins

%plot data
figure()
plot(interval,window_data,interval(TF),window_data(TF),'r*')

%extract non zero indices
indices=find(TF);

%make array to  for every 
lmin1=indices(1:3:end);
lmin2=indices(2:3:end);
lmin3=indices(3:3:end);

%plot 1st cycle of QT interval

figure()
lmin_ind_array=1:lmin1(2);
plot(lmin_ind_array,window_data(lmin_ind_array),lmin1(1),window_data(lmin1(1)),"r*")
hold on
lmin_ind_array=1:lmin2(2);
plot(lmin_ind_array,window_data(lmin_ind_array),lmin2(1),window_data(lmin2(1)),"k*")
lmin_ind_array=1:lmin3(2);
plot(lmin_ind_array,window_data(lmin_ind_array),lmin3(1),window_data(lmin3(1)),"g*")

%Cut length  of data to smallest number of indice
max_length=min([length(lmin1),length(lmin2),length(lmin3)]);

Q_ind=lmin1(1:max_length);
S_ind=lmin2(1:max_length);
T_ind=lmin3(1:max_length);


QT_ind_lengths=T_ind-Q_ind;
QT_ind_time=QT_ind_lengths/time_to_idx;

avg_QT_time=mean(QT_ind_time);
std_QT_time=std(QT_ind_time);


% ht_rate_idx= (store_idx./time_scale).* 60;
% ht_rate_avg=mean(ht_rate_idx(2:end)); % becuase the 1st entry is 0 so we ignore it 
% ht_duration=1./ht_rate_idx;
% avg_ht_duration=mean(ht_duration(2:end))*60;
% std_ht_duration=std(ht_duration(2:end))*60;









