clear;
close all;


pixel_size=0.0423; % micrometers
time=3; %seconds
doBackSubtraction = true;



stack='F3_red_binary_2.tif';
stack_green='F3_green.tif';
stack_green_v='F3_green_ves.tif';

doInterpolation = true;
interpMeth = 'linear';

sampl = 1.5; %oversampling factor of kymograph (pixels)
off=5;



tsStack = tiffread(stack);
tsStack_green = tiffread(stack_green);
tsStack_green_v = tiffread(stack_green_v);

Im=tsStack(1).data;
x=1:size(Im,1);

y=zeros(size(tsStack,2),size(Im,1));  

intensity=zeros(1,size(tsStack,2));
intensity_ves=zeros(1,size(tsStack,2));
long=zeros(1,size(tsStack,2));

for i = 1:1:size(tsStack,2)


Im=tsStack(i).data;

I_g=tsStack_green(i).data;

I_v=tsStack_green_v(i).data;

intensity_ves(i)=max(max(double(I_v)));

 ind1=find(Im);
    
[X_cm,Y_cm] = ind2sub(size(Im),ind1);

intensity(i)=sum(sum(I_g));%(ind1));

for j = 1:1:size(Im,1)
    
  

        x_pos = find(X_cm==j);

        y(i,j)=mean(Y_cm(x_pos));
        
      
      
        
        

end

y(i,:) =y(i,:)-y(i,1);


[xData, yData] = prepareCurveData( x, y(i,:) );

%Set up fittype and options.
ft = 'linearinterp';

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft );

% figure( 'Name', 'untitled fit 1' );
% h = plot( fitresult, xData, yData );
y(i,:)=fitresult(x);

y(i,:) = sgolayfilt(y(i,:),2,3);

[xData, yData] = prepareCurveData( x, y(i,:) );

% Set up fittype and options.
ft = fittype( 'poly1' );

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft );

y(i,:)=y(i,:)-fitresult(x)';

y_y=y(i,:);

aux=find(abs(y_y)<1);
 
y_y(aux)=0;

y(i,:)=y_y;

long(i)=sum(sqrt(diff(y(i,:)).^2+1));



end



%long_f = sgolayfilt(long,2,3);
% windowSize = 5; 
% b = (1/windowSize)*ones(1,windowSize);
% a = 1;
% %long = filter(b,a,long);
% 
% 
% 
% 
% cc=long(long<long(end));
% 
% cc=sgolayfilt(cc,2,5);
% 
% 
% 
% movieName = stack;
% 
% 
%     v = VideoWriter([movieName,'.mp4'],'MPEG-4');
%     v.FrameRate = 10;
%     open(v);
% 
%     figure
%     
%     for i = 1:1:size(tsStack,2)
%        
%         plot(y(i,:),'DisplayName',num2str(i));
%         legend('show');
%         xlim([min(x) max(x)]);
%         ylim([-5,5]);
%         x0=100;
%         y0=100;
%         width=800;
%         height=200;
%         set(gcf,'units','points','position',[x0,y0,width,height])
%         %daspect([1 1 3]);
%         drawnow
%         frame = getframe(gcf);
%         writeVideo(v,frame);
%     end
%     close(v);
