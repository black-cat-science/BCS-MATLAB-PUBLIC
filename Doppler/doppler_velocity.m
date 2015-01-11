function  [v] = doppler_velocity(Ft,Fd,theta)
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
%   [v] = doppler_velocity(Ft,Fd,theta)
%   Computes velocity vector for a doppler data set. 
%
%   INPUTS:  Ft(required): Transmit freqeuncies [Hz]
%
%            Fd (required): Doppler frequency [Hz]
%
%            theta (optional): angle between transmiter/receiver and target
%            [radians]
%           
%
%   OUTPUTS: v: velocity [m/s]
%
%   DEPENDENCIES: NONE
%   MATLAB: Version 8.4 (R2014b)
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% electromagentic propogation speed in vacuum in [m/s]
c = 299792458; 

if nargin == 2
    theta = 0; % angle between transmitter/receiver and target
end

v = Fd.*c./(2.*Ft.*cos(theta));