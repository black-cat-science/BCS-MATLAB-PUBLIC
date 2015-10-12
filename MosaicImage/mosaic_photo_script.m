%--------------------------------------------------------------------------
%   COPYRIGHT 2015 BLACK CAT SCIENCE, INC.
%   CONTACT INFORMATION: STEM@BLACKCATSCIENCE.COM
%   WEBSITE: WWW.BLACKCATSCIENCE.COM
%--------------------------------------------------------------------------
%   OTHER DOWNLOADS AVAILABLE AT:
%   BCS: HTTP://WWW.BLACKCATSCIENCE.COM/MATLAB-CODE/
%   GITHUB: HTTPS://GITHUB.COM/BLACK-CAT-SCIENCE/BCS-MATLAB-PUBLIC/
%   MATHWORKS: HTTP://WWW.MATHWORKS.COM/MATLABCENTRAL/FILEEXCHANGE/
%-------------------------------------------------------------------------
% 
% Example script that makes a mosaic image from itself or from a second image.
%
%
%   DEPENDENCIES: Image Processing Toolbox (optional)
%                 imnorm.m
%   MATLAB Version: 8.5.0.197613 (R2015a)
%  --------------------------------------------------------------------------

clearvars
clc
close all
drawnow

t=tic;

toolboxes = ver;
toolboxes = {toolboxes.Name};
haveImageProcessingToolbox = sum(~cellfun(@isempty,regexp(toolboxes,'Image Processing Toolbox','match')))>0;


%--------------------------------------------------------------------------
% options
%
% mosaic = 'self';  % create mosaic photo of image 1 using smaller lower resolution images of image 1
mosaic = 'other'; % create mosaic photo of image 1 using smaller lower resolution images of image 2

% blend factor (2>fac>0)
fac = .25;


%--------------------------------------------------------------------------
% decimation amount of original image used to make the tile which will be used
% make mosaic image
NY = 51; NX = 41;


switch mosaic
    case 'self'
        display('loading image 1 of 1...')
        img = imread('DSC04447.JPG');
        img1 = img;
    case 'other'
        display('loading image 1 of 2...')
        img = imread('DSC04447.JPG');
        display('loading image 2 of 2...')
        img1 = imread('DSC04940.JPG');
end

% preallocate some memory
img0 = zeros(size(img));

[ny,nx,nc]=size(img);


%--------------------------------------------------------------------------
%% low pass filter the image
if haveImageProcessingToolbox
    for ii = 1:3
        display(sprintf('lowpass filtering color channel %g...',ii))
        img0(:,:,ii) = medfilt2(squeeze(img1(:,:,ii)),[NY NX],'symmetric');
        
    end
else % Image Processing Toolbox not availble, so conv with ones to performimg local averaging.
    for ii = 1:3
        display(sprintf('lowpass filtering color channel %g...',ii))
        img0(:,:,ii) = imnorm(conv2(double(squeeze(img1(:,:,ii))),ones(NY, NX),'same'));
    end
end

%--------------------------------------------------------------------------
%% decimate lowpass filtered image to create mosaic tile
for ii = 1:3
tile(:,:,ii) = imnorm(squeeze(im2double(img0(1:NY:end,1:NX:end,ii))));
end
tile1 = squeeze(im2double(img0(1:NY:end,1:NX:end,1)));
tile2 = squeeze(im2double(img0(1:NY:end,1:NX:end,2)));
tile3 = squeeze(im2double(img0(1:NY:end,1:NX:end,3)));

[tileSizeY,tileSizeX,NNC] = size(tile);

nTilesY = floor(ny/tileSizeY);
nTilesX = floor(nx/tileSizeX);

mosaicNY = nTilesY*tileSizeY;
mosaicNX = nTilesX*tileSizeX;

%--------------------------------------------------------------------------
% create moasic image
im = zeros(size(img));

indy1 = 1;
indy2 = indy1+tileSizeY-1;
display('creating mosaic...')
for iiy = 1:nTilesY    
    
    indx1 = 1;
    indx2 = indx1+tileSizeX-1;
    
    for iix = 1:nTilesX
        
        % color pixels by values found in sub-domain in orginal image
        im(indy1:indy2,indx1:indx2,1) = tile1.^fac.*double(img(indy1:indy2,indx1:indx2,1));
        im(indy1:indy2,indx1:indx2,2) = tile2.^fac.*double(img(indy1:indy2,indx1:indx2,2));
        im(indy1:indy2,indx1:indx2,3) = tile3.^fac.*double(img(indy1:indy2,indx1:indx2,3));      
        
        indx1 = indx2+1;
        indx2 = indx2+tileSizeX;
        
    end
    
    indy1 = indy2+1;
    indy2 = indy2+tileSizeY;
    
end

%--------------------------------------------------------------------------
%% remove any unfilled edges because of tile sizes not fitting evenly into orignal image.
im = im(1:mosaicNY,1:mosaicNX,:);
im0 = zeros(size(im));
%--------------------------------------------------------------------------
% make sure color channels go from  0 - 1 so that it will display properly
im0(:,:,1) = imnorm(squeeze(im(:,:,1)));
im0(:,:,2) = imnorm(squeeze(im(:,:,2)));
im0(:,:,3) = imnorm(squeeze(im(:,:,3)));


%--------------------------------------------------------------------------
% plot results
switch mosaic
    case 'self'
        figure
        subplot(1,2,1)
        imagesc(img),axis image
        title('orignal image')
        subplot(1,2,2)
        imagesc(tile),axis image
        title('mosaic tile')
        
     
    case 'other'
        
        figure
        subplot(1,3,1)
        imagesc(img),axis image
        title('orignal image 1')
        subplot(1,3,2)
        imagesc(img1),axis image
        title('original image 2')
        subplot(1,3,3)
        imagesc(tile),axis image
        title('mosaic tile')  
        
end
figure
imagesc(im0),axis image,axis off
title('mosaic')
drawnow
imwrite(im0,'mosaic.tiff')
display('processing complete.')
save
toc(t)