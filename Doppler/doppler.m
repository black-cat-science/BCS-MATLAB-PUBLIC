function [Fd, v, data] = doppler(tm,Ft,sig,win_size,shift,wind_flag,mean_remove_flag, zpad)
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
% processes doppler data using STFFT (short time fft)
%
%      [Fd, v, data] = doppler(tm,Ft,sig,win_size,shift,wind_flag,mean_remove_flag,zpad)
%
%      inputs
%      tm: vector of measuremetn times [sec]
%      Ft: sensor transmit frequency [Hz]
%      sig: signal data, can be complex
%      win_size: size of individual data chunks used in fft
%      shift: how many points to shift window. shift must be less than win_size or error will occur.
%      wind_flag: [1] apply hanning window to each data chunk before fft.
%                  [0] no window applied to data before fft
%       mean_remove_flag: [1] remove mean from each data chunk before fft
%                         [0] do not remove mean from data before fft
%
%      output
%      data: stfft of input data (complex)
%      Fd: vector of doppler frequency values [Hz]
%      v: vector of velocity values [meters/sec]
%
%
%
%--------------------------------------------------------------------------
t = tic;
display('processing doppler data...')
if shift >= win_size
    error('shift  must be less then win_size')
end


j = win_size;
k = 1;
m = 1;
steps = floor((length(sig)-win_size)/shift);


if zpad < win_size
    zpad = win_size;   
end
%--------------------------------------------------------------------------
% calculate frequency vector
dt = abs(tm(1)-tm(2));
T = dt*zpad;
df = 1/T;
Fd = 0:df:df*(zpad-1);
%--------------------------------------------------------------------------
% calculate the velocity vector
v = doppler_velocity(Ft,Fd);

%--------------------------------------------------------------------------
% allocate memory
data = zeros(zpad,floor(steps));

%--------------------------------------------------------------------------
% perform short time fft
for ii = 1:steps
    
    %----------------------------------------------------------------------
    % select a chunk of data to perform fft on
    sig0 = sig(m:j);
    %----------------------------------------------------------------------
    % remove dc (mean) offset from chunk
    if mean_remove_flag == 1
        sig0=sig0-mean(sig0);
    end
    %----------------------------------------------------------------------
    % window data to reduce sidelobe ringing
    if wind_flag == 1
        wind = (hann(length(sig0)));
        sig0=sig0.*wind.';
    end
    %----------------------------------------------------------------------
    % fft data and zero pad
    data(:,k) = ifft(sig0,zpad);
    %----------------------------------------------------------------------
    % increment counters and shift window
    j = j + shift;
    m = m + shift;
    k = k + 1;
    
end

display(sprintf('processing complete: %g [sec]',toc(t)))

