%--------------------------------------------------------------------------
%   COPYRIGHT 2015 BLACK CAT SCIENCE, INC.
%   CONTACT INFORMATION: STEM@BLACKCATSCIENCE.COM
%   WEBSITE: WWW.BLACKCATSCIENCE.COM
%--------------------------------------------------------------------------
%   OTHER DOWNLOADS AVAILABLE AT:
%   BCS: HTTP://WWW.BLACKCATSCIENCE.COM/MATLAB-CODE/
%   GITHUB: HTTPS://GITHUB.COM/BLACK-CAT-SCIENCE/BCS-MATLAB-PUBLIC/
%   MATHWORKS: HTTP://WWW.MATHWORKS.COM/MATLABCENTRAL/FILEEXCHANGE/
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%                      DESCRIPTION
%  EXAMPLE SCRIPT FOR PROCESSING DOPPLER DATA AND PLOTTING  RESULTS
%
%  DATA WAS COLLECTED USING A FIXED FREQUENCY RADAR SENSOR OPERATING AT
%  10.525 GHZ. A HAND WAS PLACED ~ 30CM IN FRONT OF THE SENSOR AND MOVED
%  TOWARDS THE SENSOR. THE EXPERIMENT WAS REPEATED 3 TIME WITH THE HAND
%  MOVING AT "SLOW", "MEDIUEM", AND "FAST" SPEEDS. 
%--------------------------------------------------------------------------


%--------------------------------------------------------------------------
close all
clearvars
clc

%--------------------------------------------------------------------------
% fontsize for plots
fs = 12;
%--------------------------------------------------------------------------
% options for doppler function (stfft). The doppler function is a
% short-time fft which calculates the velocity output vector.

windowSize{1} = 10000; % window size used for "hand_moving_slow.mat" data
windowSize{2} = 5000; % window size used for "hand_moving_medium.mat" data
windowSize{3} = 2500; % window size used for "hand_moving_fast.mat" data

shift = 11;     % how much to shift the window between sucessive fft's

doMeanSubtract = 1; % removes dc component (mean) from each chunk of data
% processed in doppler function (stfft)

doWindowData = 1;   % applies hanning window to each chunk of data
                    % processed in doppler function (stfft)

zpad = 2^10;        % zero pad length for stfft
Ft = 10.525e9;      % sensor tranmit freqeuncy [GHz]
%--------------------------------------------------------------------------
% load data and process and plot raw data results
load('hand_moving_slow.mat', 'data','timeStamps')

[freq_slow, v_slow, data_slow] =...
    doppler(timeStamps,Ft,data,windowSize{1},shift,doMeanSubtract,doWindowData, zpad);


figure
subplot(3,1,1)
plot(timeStamps,data)
legend('hand moving slow')
xlabel('time [sec]','fontsize',fs)
ylabel('amplitude, [V]','fontsize',fs)
set(gca,'fontsize',fs)
axis([0 10 -.25 .25])
drawnow

%--------------------------------------------------------------------------
% load data and process and plot raw data results
load('hand_moving_medium.mat')

[freq_medium, v_medium, data_medium] =...
    doppler(timeStamps,Ft,data,windowSize{2},shift,doMeanSubtract,doWindowData,zpad);


subplot(3,1,2)
plot(timeStamps,data)
legend('hand moving medium')
xlabel('time [sec]','fontsize',fs)
ylabel('amplitude, [V]','fontsize',fs)
set(gca,'fontsize',fs)
axis([0 10 -.25 .25])
drawnow

%--------------------------------------------------------------------------
% load data and process and plot raw data results
load('hand_moving_fast.mat')

[freq_fast, v_fast, data_fast] =...
    doppler(timeStamps,Ft,data,windowSize{3},shift,doMeanSubtract,doWindowData,zpad);

subplot(3,1,3)
plot(timeStamps,data)
legend('hand moving fast')
xlabel('time [sec]','fontsize',fs)
ylabel('amplitude, [V]','fontsize',fs)
set(gca,'fontsize',fs)
axis([0 10 -.25 .25])
drawnow

%--------------------------------------------------------------------------
% set plot size
set(gcf,'position',[504         567        1059         420])


%--------------------------------------------------------------------------
% plot stfft results
figure
subplot(1,3,1)
imagesc([timeStamps(1) timeStamps(end)],v_slow*100,imnorm_db(data_slow),[-35 0])
title('hand moving slow','fontsize',fs)
xlabel('time [sec]','fontsize',fs)
ylabel('velocity, [cm/s]','fontsize',fs)
set(gca,'fontsize',fs)
ylim([0 50])
drawnow

subplot(1,3,2)
imagesc([timeStamps(1) timeStamps(end)],v_medium*100,imnorm_db(data_medium),[-35 0])
title('hand moving medium','fontsize',fs)
xlabel('time [sec]','fontsize',fs)
ylabel('velocity, [cm/s]','fontsize',fs)
set(gca,'fontsize',fs)
ylim([0 100])
drawnow

subplot(1,3,3)
imagesc([timeStamps(1) timeStamps(end)],v_fast*100,imnorm_db(data_fast),[-65 0])
title('hand moving fast','fontsize',fs)
xlabel('time [sec]','fontsize',fs)
ylabel('velocity, [cm/s]','fontsize',fs)
set(gca,'fontsize',fs)
ylim([0 600])
drawnow

%--------------------------------------------------------------------------
% set plot size
set(gcf,'position',[506         231        1056         230])


display('processing completed.')


