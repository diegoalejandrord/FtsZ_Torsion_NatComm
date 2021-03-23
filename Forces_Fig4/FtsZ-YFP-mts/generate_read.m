amplitude=3;
time_acq=30; %seconds

s = daq.createSession('ni');
addAnalogInputChannel(s,'OTKB', 0, 'Voltage');
addAnalogInputChannel(s,'OTKB', 1, 'Voltage');
addAnalogInputChannel(s,'OTKB', 2, 'Voltage');

addAnalogOutputChannel(s,'OTKB',0,'Voltage');

output_data = 5+(amplitude/2)*sin(linspace(0,time_acq*2*pi,time_acq*1000)');
queueOutputData(s,output_data);


%plot(output_data);
%title('Output Data Queued');


 
[cap_data,time] = s.startForeground;

name=strcat(num2str(datenum(datetime('now'))),'_cap_data');

save(strcat(name,'.mat'),'cap_data');
plot(time,cap_data);

