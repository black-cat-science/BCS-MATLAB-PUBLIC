function [data_out] = imnorm(data_in,flag)
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
%  function [data_out] = imnorm(data_in,flag)
%  normalizes data between values 0-1, and optionally converts to
%  dB [20*log10]
%
%  INPUT: data, data to be normalized (required)
%         flag = 'db', converts to db [20*log10], ignores all other entries
%               (optional)
%  OUTPUT: data_out, normalized data
%--------------------------------------------------------------------------
%  DEPENDENCIES: NONE
%  MATLAB:       Version 8.4        (R2014b)
%------------------------------------------------------------------------


if nargin < 2
    flag = 0;
else
    if strcmpi(flag,'db')
        flag = 1;
    else
        flag = 0;
    end
end

data_out = abs(data_in);
data_out = data_out-min(data_out(:));
data_out = data_out/max(data_out(:));

if flag == 1
    data_out = 20*log10(data_out);
end