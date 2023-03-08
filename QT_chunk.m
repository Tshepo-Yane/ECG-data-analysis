% load data
load("subject2.mat");
data1=data;

%strip data
Lead1=data1(:,1);
Lead2=data1(:,2);
Lead3=data1(:,3);

num_chunks=10;
interval_length=floor(length(data)/num_chunks);

time_total=350; % seconds
time=time_total/num_chunks;
time_to_idx=interval_length/time;

QT_avg_chunk=zeros(1,(num_chunks-1));

for i=2:num_chunks
    
interval=(interval_length*(i-1):interval_length*(i));
window_data = Lead2(interval);


TF = islocalmin(window_data,'MinProminence',0.1);
%find local mins

%plot data

%plot(interval,window_data,interval(TF),window_data(TF),'r*')

%extract non zero indices
indices=find(TF);

%make array to  for every 1st, 2nd, 3rd and entry
lmin1=indices(1:3:end);
lmin2=indices(2:3:end);
lmin3=indices(3:3:end);


%sort  data 
sort_array=sort([window_data(lmin1(1)),window_data(lmin2(1)),window_data(lmin3(1))]);
 
if window_data(lmin1(1))==sort_array(1)
    Q_idx=lmin1;
elseif window_data(lmin1(1))==sort_array(2)
    S_idx=lmin1;
elseif window_data(lmin1(1))==sort_array(3)
    T_idx=lmin1;
end

if window_data(lmin2(1))==sort_array(1)
    Q_idx=lmin2;
elseif window_data(lmin2(1))==sort_array(2)
    S_idx=lmin2;
elseif window_data(lmin2(1))==sort_array(3)
    T_idx=lmin2;
end

if window_data(lmin3(1))==sort_array(1)
    Q_idx=lmin3;
elseif window_data(lmin3(1))==sort_array(2)
    S_idx=lmin3;
elseif window_data(lmin3(1))==sort_array(3)
	T_idx=lmin3;
end
                

%plot 1st cycle of QT interval


lmin_ind_array=1:Q_idx(1);
plot(lmin_ind_array,window_data(lmin_ind_array),Q_idx(1),window_data(Q_idx(1)),"r*")
hold on
lmin_ind_array=1:S_idx(1);
plot(lmin_ind_array,window_data(lmin_ind_array),S_idx(1),window_data(S_idx(1)),"k*")
lmin_ind_array=1:T_idx(1);
plot(lmin_ind_array,window_data(lmin_ind_array),T_idx(1),window_data(T_idx(1)),"g*")

%Cut length  of data to smallest number of indice
max_length=min([length(Q_idx),length(S_idx),length(T_idx)]);

Q_ind=Q_idx(1:max_length);
S_ind=S_idx(1:max_length);
T_ind=T_idx(1:max_length);


QT_ind_lengths=T_ind-Q_ind;
QT_ind_time=QT_ind_lengths/time_to_idx;

avg_QT_time=mean(QT_ind_time);
QT_avg_chunk(i-1)=avg_QT_time;

end
avg_QT_time=mean(QT_avg_chunk);
std_QT_time=std(QT_avg_chunk);
