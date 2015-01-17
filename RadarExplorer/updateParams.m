function handles = updateParams(handles)
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
% function handles = updateParams(handles)
% GUI function updates various parameters in the GUI
%
%
%  INPUTS: handles
% OUTPUTS: handles
%
% DEPENDENCIES: [none]
% MATLAB:       Version 8.4        (R2014b)
%--------------------------------------------------------------------------
handles.startFreq = str2double(get(handles.editStartFreqHz,'string'));
handles.stopFreq = str2double(get(handles.editStopFreqHz,'string'));
handles.numSamples = str2double(get(handles.editNumSamples,'string'));
handles.freqStep = floor((handles.stopFreq-handles.startFreq)/handles.numSamples);
set(handles.editFreqStepHz,'string',sprintf('%4.4e',handles.freqStep))

handles.noise = get(handles.checkAddNoise,'value');
handles.noiseVal = str2double(get(handles.editNoise,'string'));

handles.radarXPos = 0;
handles.radarZPos = 0;

handles.xa = str2num(get(handles.editXA,'string'));
handles.za = str2num(get(handles.editZA,'string'));

xt = str2num(get(handles.editTargetXPos,'string'));
zt = str2num(get(handles.editTargetZPos,'string'));

if isempty(xt) || isempty(zt)
    handles.xt = 0;
    handles.zt = 1;
    set(handles.editTargetXPos,'string','0');
    set(handles.editTargetZPos,'string','1');
else
    
    if numel(xt)~=numel(zt)
        nxt = numel(xt);
        nzt = numel(zt);
        h=errordlg(sprintf('Number of target position parameters do not match.\nPlease fix to proceed.'),'error','modal');
        uiwait(h)
        error('error:Number of target position parameters do not match.')
    else
        handles.xt = xt;
        handles.zt = zt;
    end
end

handles.numTargets = length(handles.xt);
handles.zeropad = get(handles.checkZeroPad,'value');
handles.npad = str2double(get(handles.editZeroPad,'string'));
handles.window = get(handles.checkWindow,'value');

obj=get(get(handles.uiRadarChannels,'SelectedObject'),'tag');

switch obj
    case 'radI'
        chan = 1;
    case 'radQ'
        chan = 2;
    case 'radIandQ'
        chan = 3;
end
handles.chan = chan;
