clear;
close all;

offset=5;

stack='2_red_t-t.tif';
stack2='2_red_v.tif';
stack3='2_green_t_t.tif';
stack4='2_green_v.tif';
stack5='2_red_t_short.tif';


tsStack = tiffread(stack);
tsStack2 = tiffread(stack2);
tsStack_g = tiffread(stack3);
tsStack2_g = tiffread(stack4);
tsStack2_short = tiffread(stack5);

A=tsStack(1).data;
AV=tsStack2(1).data;

diam=zeros(1,2*offset+1);
I_tubo=zeros(1,size(A,2));

Im=imadjust(A);


for j = 1:1:size(Im,2)
    
   
av=double(A(:,j));           
av=(av-min(av))/(max(av)-min(av));
pos_max=find(av==1);
aux=av(pos_max-offset:pos_max+offset);
diam=diam+aux';
%plot(av)              
end



d_d=(diam-min(diam))/(max(diam)-min(diam));
x=1:length(d_d);

[fitresult, gof] = gauss_fit(x, d_d);

It=double(max(max(A)));
Iv=double(max(max(AV)));

Ir=It/Iv;
d=2*sqrt(log(2))*0.133*fitresult.c1;


Im=tsStack2_short(1).data;
%Im=tsStack(end).data;
Fs=1;

L=size(Im,2);

f = Fs*(0:(L/2))/L;
f=f/0.133;
y=zeros(size(Im,1),length(f));  

y_mean=zeros(1,length(f));

av=zeros(1,size(Im,1));



for j = 1:1:size(Im,1)
    
y(j,:)=fourier_Diego(double(Im(j,:)));

%y(j,:)=y(j,:)./sum(y(j,:));

av(j)=mean(y(j,:));

end

av=(av-min(av))/(max(av)-min(av));

av_aux=av>0.3;

aux=find(av_aux==1);

d_helix=length(av(av>0.3))*0.133;

green_ves=zeros(1,size(tsStack,2));

pos=round((aux(end)-aux(1))/2);


y_mean_s = double(Im(aux(1),:))-mean(double(Im(aux(1),:)));

y_mean=sgolayfilt(y_mean_s,3,13);



for i = 1:1:size(tsStack2_g,2)
    
    GV=tsStack2_g(i).data;
    
    green_ves(i)=max(max(double(GV)));
    

end

GV_0=tsStack_g(1).data;
GV=tsStack_g(end).data;
BW=imbinarize(GV);
masking=find(BW==0);
GV(masking)=0;
g_0=sum(sum(double(GV)));%-sum(sum(double(GV_0)));


g_t=g_0/(mean(green_ves)*size(GV,2));
g_t_c=g_0/(mean(green_ves)*length(find(BW==1)));

%for 1 image -y_mean
%y_mean=-y_mean;

findpeaks(y_mean,'MinPeakDistance',5)

%plot(y_mean)
% 
[pks,locs] = findpeaks(y_mean,'MinPeakDistance',5);

pks_s=pks;%(pks>mean(y_mean(y_mean>0)));

c= ismember(y_mean,pks_s);

% locs_s= find(c);
% 
pitch=diff(locs)*0.133;
% 
% pitch=pitch(pitch>1);
% 
% pitch=pitch(pitch<4);

% 
% if isempty(pks)==1
% 
%     pitch=-10;    
% 
% else
%    
% 
%    c = ismember(y_mean_s, pks);
% 
%     indexes = find(c);
% 
%     p=f(indexes);
%     
%     pitch=1./p;
%     
%     pks_s=pks; 
%     pitch_s=pitch;   
%     
%      pks_s=pks_s(1:end);
%     pitch_s=pitch_s(1:end);
%     
%     pitch_s=sum(pitch_s.*pks_s)/(sum(pks_s));
% 
% end
% 
%     
%     
% 
%  figure
%  plot(f,y_mean)
% 
%  figure
%  
%  plot(av);
%  
%   figure
%  plot(f_n,y_mean_s)
