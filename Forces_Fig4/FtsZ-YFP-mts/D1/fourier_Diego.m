function [ f, P1 ] = fourier_Diego( signal )
Fs = 1000;            % Sampling frequency

            L = length(signal);             % Length of signal

            
            Y = fft(signal);
            
            %P2 = abs(Y);

            P2 = abs(Y/L);
            %P2 = mean(P2,1);
            P1 = P2(1:L/2+1);
            P1(2:end-1) = 2*P1(2:end-1);
            %P1=100*P1;
            %P1= smooth(P1,'sgolay',3);
            f = Fs*(0:(L/2))/L;
            
%     figure
%         plot(f,P1)        

end

