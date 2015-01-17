function [ output_args ] = saveData(hObject,event,handles,res)
%--------------------------------------------------------------------------
% COPYRIGHT 2014 BLACK CAT SCIENCE, INC.
% CONTACT INFORMATION: STEM@BLACKCATSCIENCE.COM
% WEBSITE: WWW.BLACKCATSCIENCE.COM
%--------------------------------------------------------------------------
% OTHER DOWNLOADS AVAILABLE AT:
% BCS: HTTP://WWW.BLACKCATSCIENCE.COM/MATLAB-CODE/
% GITHUB: HTTPS://GITHUB.COM/BLACK-CAT-SCIENCE/BCS-MATLAB-PUBLIC/
% MATHWORKS: HTTP://WWW.MATHWORKS.COM/MATLABCENTRAL/FILEEXCHANGE/
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% function [ output_args ] = saveData(hObject,event,handles,res)
% GUI function, saves data from plot to a .mat file
%
%
%  INPUTS: hObject,event,handles,res
% OUTPUTS: output_args [not used]
%
% DEPENDENCIES: [none]
% MATLAB:       Version 8.4        (R2014b)
%--------------------------------------------------------------------------

if ~isempty(handles.savePath)
    
    defaultName = fullfile(handles.savePath,[sprintf(datestr(now,'_ddmmmyy_hhMMss'))]);
    [FileName,PathName,FilterIndex]=uiputfile({'*.mat'},'Save Results',defaultName);
else
    defaultName = [sprintf(datestr(now,'_ddmmmyy_hhMMss'))];
    [FileName,PathName,FilterIndex]=uiputfile({'*.mat'},'Save Results',defaultName);
end

if FileName ~=0
  save(fullfile(PathName, FileName),'-struct','res')
else
    display('no data saved')
end

