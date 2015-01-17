function handles = updatePlot(handles)
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
% function handles = updatePlot(handles)
% GUI function updates plot
%
%
%  INPUTS: handles
% OUTPUTS: handles
%
% DEPENDENCIES: [none]
% MATLAB:       Version 8.4        (R2014b)
%--------------------------------------------------------------------------

nt = handles.numTargets;
handles.xa = str2num(get(handles.editXA,'string'));
handles.za = str2num(get(handles.editZA,'string'));
axes(handles.axes1)


hold off
plot(handles.radarZPos,handles.radarXPos,'dr','markerfacecolor','r')
hold on
shapes = 'x+dops';
clrs = 'krb';
ct=1;
pp=1;
for ii = 1:nt
    plot(handles.zt(ii),handles.xt(ii),[clrs(pp) shapes(ct)],'markersize',6)
    ct = ct+1;
    if mod(ct,6)==1
        ct=1;
        pp=pp+1;
    end
    if mod(pp,3)==1
        pp=1;
    end
end
axis([handles.za handles.xa])

str{1} = 'Sensor';

for ii = 1:nt
    str{ii+1} =sprintf('Target %g',ii);
end
legend(str)
title('Sensor and Target Position')
grid on
xlabel('Z Range, meters')
ylabel('X Range, meters')
hold off