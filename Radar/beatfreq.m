function [fb] = beatfreq(tc,r,bw,c)
%--------------------------------------------------------------------------
% COPYRIGHT 2015 BLACK CAT SCIENCE, INC.
% CONTACT INFORMATION: STEM@BLACKCATSCIENCE.COM
% WEBSITE: WWW.BLACKCATSCIENCE.COM
%--------------------------------------------------------------------------
% OTHER DOWNLOADS AVAILABLE AT:
% BCS: HTTP://WWW.BLACKCATSCIENCE.COM/MATLAB-CODE/
% GITHUB: HTTPS://GITHUB.COM/BLACK-CAT-SCIENCE/BCS-MATLAB-PUBLIC/
% MATHWORKS: HTTP://WWW.MATHWORKS.COM/MATLABCENTRAL/FILEEXCHANGE/
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% function [fb] = beatfreq(tc,r,bw,c)
% Calculates the beat frequency for a Homodyne FMCW (Frequency Modulated
% Constant Wave) radar system.
%
% INPUTS:  tc [required]: chirp rate of FMCW signal in seconds.
%          r  [required]: distance to target location in meters.
%          bw [required]: bandwidth of FMCW signal in herzt.
%          c  [optional]: propgation speed in medium [m/s]. If no value is
%                         supplied, e/m propgation speed in vacuum is used.
%
% OUTPUTS: fb [required]: beat frequency in hertz.
%
% DEPENDENCIES: [none]
% MATLAB:       Version 8.4        (R2014b)
%--------------------------------------------------------------------------

if nargin == 3
    c = 299792458; % propogation speed in vacuum
end

if nargin < 3
    error('minimum of 3 inputs are required')
end
 
fb = 2*bw.*r./(c.*tc);


display(sprintf('\n'))
display('-----------------------------------------')
display(sprintf('%+18s %-10g %+6s','Chirp Rate: ', tc, '[sec]'))
display(sprintf('%+18s %-10g %+6s','Target Range: ',r, '[m]'))
display(sprintf('%+18s %-10g %+6s','Band Width: ',bw, '[Hz]'))
display(sprintf('%+18s %-10g %+6s','Propgation Speed: ', c, '[m/s]'))
display(sprintf('%+18s %-10g %+6s','Beat Frequency: ',fb, '[Hz]'))
display('-----------------------------------------')
