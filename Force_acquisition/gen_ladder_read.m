amplitude=3;
time_stp=5; %seconds

s = daq.createSession('ni');
addAnalogInputChannel(s,'OTKB', 0, 'Voltage');
addAnalogInputChannel(s,'OTKB', 1, 'Voltage');
addAnalogInputChannel(s,'OTKB', 2, 'Voltage');

addAnalogOutputChannel(s,'OTKB',0,'Voltage');

vector=ones(1,1000*time_stp);

output_data=[];

    for i=0.5:0.5:5
    aux=5-vector*i;
    output_data=[output_data,aux];
    end

aux=vector*5;
output_data=[output_data,aux];
queueOutputData(s,output_data');


% plot(output_data);
% title('Output Data Queued');


 
[cap_data,time] = s.startForeground;

name=strcat(num2str(datenum(datetime('now'))),'_cap_data');

save(strcat(name,'.mat'),'cap_data');
plot(time,cap_data);

