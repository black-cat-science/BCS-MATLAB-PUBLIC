function [ wind ] = hann(windowLength)
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
%   function [ wind ] = hann(windowLength)
%   creates a hann window
%   run hann(); on command line for example output
%
%   INPUTS:  windowLength, number of points in hann window
%   OUTPUTS: wind, the hann window
%
%   DEPENDENCIES: NONE
%   MATLAB: Version 8.4 (R2014b)
%--------------------------------------------------------------------------


if nargin == 0
    windowLength = 100;
    N = windowLength - 1;
    num = linspace(0,N,windowLength);
    wind = 0.5*(1 - cos(2*pi*num/N));
    figure
    plot(wind)
    title('hann window')
else
    N = windowLength - 1;
    num = linspace(0,N,windowLength);
    wind =  0.5*(1 - cos(2*pi*num/N));
end

