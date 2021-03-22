clear;
close all;

names=dir('*.tif');

g_0=zeros(length(names)/2,1);


for i=1:length(names)/2
    
      GV=imread(names(2*i-1).name);
      RD=imread(names(2*i).name);
        
      
      B=GV(1:10,:);
  
      back=mean(mean(GV));
  
      GV=GV-back;
     
      BW=imbinarize(RD);
     
      masking=find(BW==0);
     
      GV(masking)=0;
    
     
      g_0(i)=sum(sum(double(GV)));
     
     
end    