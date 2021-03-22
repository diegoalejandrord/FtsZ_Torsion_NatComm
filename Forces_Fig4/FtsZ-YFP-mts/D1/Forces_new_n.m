
S_x=cap_data(:,1);
S_y=cap_data(:,2);
S_x=S_x-mean(S_x);

S_y=S_y-mean(S_y);




[f1,P1]=fourier_Diego(S_x);

[f2,P2]=fourier_Diego(S_y);

amplitude=sqrt((P1(31)^2+P2(31)^2))



%figure
%       plot(f,P1);
        

% xfft=2*fft(S_x)/length(S_x);
% plot(xfft)
% 
