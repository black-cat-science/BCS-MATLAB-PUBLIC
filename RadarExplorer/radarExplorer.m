function varargout = radarExplorer(varargin)
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
% RadarExplorer
% A Simple GUI for investigating FMCW Radar system and FFTs
%
%
% INPUTS:  N/A
% OUTPUTS: N/A
%
% DEPENDENCIES: updateParams()
%               updatePlot()
%               hann()
%               saveData()
%               bcs_icon.png
%
% MATLAB:       Version 8.4        (R2015b)
%-----------------------------------------------------------------------------------------------------------
% RADAREXPLORER MATLAB code for radarExplorer.fig
%      RADAREXPLORER, by itself, creates a new RADAREXPLORER or raises the existing
%      singleton*.
%
%      H = RADAREXPLORER returns the handle to a new RADAREXPLORER or the handle to
%      the existing singleton*.
%
%      RADAREXPLORER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RADAREXPLORER.M with the given input arguments.
%
%      RADAREXPLORER('Property','Value',...) creates a new RADAREXPLORER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before radarExplorer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to radarExplorer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help radarExplorer

% Last Modified by GUIDE v2.5 22-Mar-2015 13:33:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @radarExplorer_OpeningFcn, ...
    'gui_OutputFcn',  @radarExplorer_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before radarExplorer is made visible.
function radarExplorer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to radarExplorer (see VARARGIN)

% Choose default command line output for radarExplorer
handles.output = hObject;

handles.savePath = cd;
handles = updateParams(handles);
handles = updatePlot(handles);



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes radarExplorer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = radarExplorer_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function editStartFreqHz_Callback(hObject, eventdata, handles)
% hObject    handle to editStartFreqHz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editStartFreqHz as text
%        str2double(get(hObject,'String')) returns contents of editStartFreqHz as a double

handles = updateParams(handles);
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function editStartFreqHz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editStartFreqHz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editStopFreqHz_Callback(hObject, eventdata, handles)
% hObject    handle to editStopFreqHz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editStopFreqHz as text
%        str2double(get(hObject,'String')) returns contents of editStopFreqHz as a double

handles = updateParams(handles);
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function editStopFreqHz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editStopFreqHz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editNumSamples_Callback(hObject, eventdata, handles)
% hObject    handle to editNumSamples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editNumSamples as text
%        str2double(get(hObject,'String')) returns contents of editNumSamples as a double
handles = updateParams(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function editNumSamples_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editNumSamples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editFreqStepHz_Callback(hObject, eventdata, handles)
% hObject    handle to editFreqStepHz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFreqStepHz as text
%        str2double(get(hObject,'String')) returns contents of editFreqStepHz as a double


% --- Executes during object creation, after setting all properties.
function editFreqStepHz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFreqStepHz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editBeamwidth_Callback(hObject, eventdata, handles)
% hObject    handle to editBeamwidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editBeamwidth as text
%        str2double(get(hObject,'String')) returns contents of editBeamwidth as a double
handles = updateParams(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function editBeamwidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editBeamwidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editZA_Callback(hObject, eventdata, handles)
% hObject    handle to editZA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editZA as text
%        str2double(get(hObject,'String')) returns contents of editZA as a double


% --- Executes during object creation, after setting all properties.
function editZA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editZA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editXA_Callback(hObject, eventdata, handles)
% hObject    handle to editXA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editXA as text
%        str2double(get(hObject,'String')) returns contents of editXA as a double


% --- Executes during object creation, after setting all properties.
function editXA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editXA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editRadarXPos_Callback(hObject, eventdata, handles)
% hObject    handle to editRadarXPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editRadarXPos as text
%        str2double(get(hObject,'String')) returns contents of editRadarXPos as a double


% --- Executes during object creation, after setting all properties.
function editRadarXPos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editRadarXPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editRadarZPos_Callback(hObject, eventdata, handles)
% hObject    handle to editRadarZPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editRadarZPos as text
%        str2double(get(hObject,'String')) returns contents of editRadarZPos as a double


% --- Executes during object creation, after setting all properties.
function editRadarZPos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editRadarZPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushUpdateAxes.
function pushUpdateAxes_Callback(hObject, eventdata, handles)
% hObject    handle to pushUpdateAxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles = updatePlot(handles);
guidata(hObject,handles);

function editTargetXPos_Callback(hObject, eventdata, handles)
% hObject    handle to editTargetXPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTargetXPos as text
%        str2double(get(hObject,'String')) returns contents of editTargetXPos as a double


% --- Executes during object creation, after setting all properties.
function editTargetXPos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTargetXPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editTargetZPos_Callback(hObject, eventdata, handles)
% hObject    handle to editTargetZPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTargetZPos as text
%        str2double(get(hObject,'String')) returns contents of editTargetZPos as a double


% --- Executes during object creation, after setting all properties.
function editTargetZPos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTargetZPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushUpdateTargets.
function pushUpdateTargets_Callback(hObject, eventdata, handles)
% hObject    handle to pushUpdateTargets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles = updateParams(handles);
handles = updatePlot(handles);
guidata(hObject,handles);
% --- Executes on button press in pushAddTargets.
function pushAddTargets_Callback(hObject, eventdata, handles)
% hObject    handle to pushAddTargets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[x y]= ginput(1);

x = str2double(sprintf('%2.3g',x));
y = str2double(sprintf('%2.3g',y));
xt = handles.xt;
zt = handles.zt;
zt = [zt x];
xt = [xt y];

handles.xt = xt;
handles.zt = zt;

set(handles.editTargetXPos,'string',num2str(xt));
set(handles.editTargetZPos,'string',num2str(zt));
handles = updateParams(handles);
handles = updatePlot(handles);

guidata(hObject,handles)

% --- Executes on button press in pushCompute.
function pushCompute_Callback(hObject, eventdata, handles)
% hObject    handle to pushCompute (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = updateParams(handles);
handles = updatePlot(handles);

f0 = handles.startFreq;
f1 = handles.stopFreq;
n = handles.numSamples;
xt = handles.xt;
zt = handles.zt;
x0 = handles.radarXPos;
z0 = handles.radarZPos;
nt = handles.numTargets;
chan = handles.chan;
if handles.zeropad
    npad = handles.npad;
else
    npad = n;
end
m=numel(xt);
sigt = zeros(m,n);
sig = zeros(1,n);
c=3e8;
f = linspace(f0,f1,n);


for ii = 1:length(zt)
    r = sqrt((xt(ii)-x0).^2+(zt(ii)-z0).^2);
    if handles.noise
        
        noiseI = handles.noiseVal*randn(size(f));
        noiseQ = handles.noiseVal*randn(size(f));
        noise = noiseI+1i.*noiseQ;
    else
        noise = 0;
    end
    sigt(ii,:)=exp(4*1i*pi.*f*r/c)./r^2+noise;
    sig = sig+sigt(ii,:);
end


switch chan
    case 1
        sig = real(sig);
        sigt = real(sigt);
    case 2
        sig = imag(sig);
        sigt = imag(sigt);
    case 3
end
df = f(2)-f(1);
bw = df*(npad-1);
dt=1/bw;
t = 0:dt:dt*(npad-1);
mr = c.*t/2;
myres.f = f;
myres.sigt = sigt;
myres.sig = sig;
myres.t=t;
myres.mr = mr;
myres.bw=bw;
myres.df = df;
myres.f0 = f0;
myres.f1 = f1;
myres.numSamples = handles.numSamples;
myres.xt = xt;
myres.zt = zt;
myres.x0 = x0;
myres.z0 = z0;
myres.nt = nt;
if nt>1
    figure
    
    switch chan
        case 1 % I
            
            plot(f,sigt)
            
            for ii =1:nt
                str{ii}= sprintf('I - Chan, Target %g',ii);
            end
            legend(str)
        case 2 % Q
            plot(f,sigt)
            for ii =1:nt
                str{ii}= sprintf('Q - Chan, Target %g',ii);
            end
            legend(str)
        case 3 %I&Q
            plot(f,real(sigt),'-')
            for ii =1:nt
                str{ii}= sprintf('I - Chan, Target %g',ii);
            end
            legend(str)
            hold on
            plot(f,imag(sigt),'--')
            ct = 1;
            for ii =nt+1:nt+nt
                
                str{ii}= sprintf('Q - Chan, Target %g',ct);
                ct = ct+1;
            end
            legend(str)
    end
    xlabel('Frequency, GHz')
    ylabel('Amplitude')
    title('Individual Scatter Response')
end
h=figure;
f=f/1e9;
switch chan
    case 1
        plot(f,sig)
        xlabel('Frequency, GHZ')
        ylabel('Amplitude')
        legend('I')
        title('Combined Scattering Respone')
    case 2
        plot(f,sig)
        xlabel('Frequency, GHZ')
        ylabel('Amplitude')
        legend('Q')
        title('Frequency Data')
    case 3
        plot(f,real(sig),f,imag(sig))
        xlabel('Frequency, GHZ')
        ylabel('Amplitude')
        legend('I','Q')
        title('Frequency Data')
end

if handles.window
    sig = sig.*hann(length(sig));
end

switch chan
    case 1
        figure
        plot(mr,abs(fft(sig,npad))/npad)
        xlabel('Range, meters')
        ylabel('Amplitude')
        title('Range Data - I Channel Only')
    case 2
        figure
        plot(mr,abs(fft(sig,npad))/npad)
        xlabel('Range, meters')
        ylabel('Amplitude')
        title('Range Data - Q Channel Only')
    case 3
        figure
        plot(mr,abs(fft(sig,npad))/npad)
        xlabel('Range, meters')
        ylabel('Amplitude')
        title('Range Data - I & Q Channels')
end
sigf = abs(fft(sig,npad))/npad;
myres.sigf=sigf;
figure(h)
uicontrol('Style', 'pushbutton', 'String', 'Save Data',...
    'Position', [10 10 100 20],...
    'Callback', {@saveData,handles,myres},'backgroundcolor','g');


% --- Executes on button press in pushResetTargets.
function pushResetTargets_Callback(hObject, eventdata, handles)
% hObject    handle to pushResetTargets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.editTargetXPos,'string','0');
set(handles.editTargetZPos,'string','1');
handles = updateParams(handles);
handles = updatePlot(handles);

guidata(hObject,handles);


% --- Executes on button press in checkWindow.
function checkWindow_Callback(hObject, eventdata, handles)
% hObject    handle to checkWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkWindow


% --- Executes on button press in checkZeroPad.
function checkZeroPad_Callback(hObject, eventdata, handles)
% hObject    handle to checkZeroPad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkZeroPad

if get(hObject,'value')
    set(handles.editZeroPad,'enable','on');
else
    set(handles.editZeroPad,'enable','off');
end

function editZeroPad_Callback(hObject, eventdata, handles)
% hObject    handle to editZeroPad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editZeroPad as text
%        str2double(get(hObject,'String')) returns contents of editZeroPad as a double


% --- Executes during object creation, after setting all properties.
function editZeroPad_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editZeroPad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkAddNoise.
function checkAddNoise_Callback(hObject, eventdata, handles)
% hObject    handle to checkAddNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkAddNoise

if get(hObject,'value')
    set(handles.editNoise,'enable','on')
else
    set(handles.editNoise,'enable','off')
end


function editNoise_Callback(hObject, eventdata, handles)
% hObject    handle to editNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editNoise as text
%        str2double(get(hObject,'String')) returns contents of editNoise as a double


% --- Executes during object creation, after setting all properties.
function editNoise_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function mnuAbout_Callback(hObject, eventdata, handles)
% hObject    handle to mnuAbout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cdata = imread('bcs_icon.png');
msgbox(sprintf(['Simple GUI for investigating FMCW Radar system and FFTs.\n'...
 '\nemail: stem@blackcatscience.com\n   www.blackcatscience.com' '\n\nCopyright 2015 Black Cat Science, Inc.\n']),'About','custom',cdata)
