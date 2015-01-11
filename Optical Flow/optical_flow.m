function [output] = optical_flow(imgs, options)
%  --------------------------------------------------------------------------
%   COPYRIGHT 2015 BLACK CAT SCIENCE, INC.
%   CONTACT INFORMATION: STEM@BLACKCATSCIENCE.COM
%   WEBSITE: WWW.BLACKCATSCIENCE.COM
%  --------------------------------------------------------------------------
%   OTHER DOWNLOADS AVAILABLE AT:
%   BCS: HTTP://WWW.BLACKCATSCIENCE.COM/MATLAB-CODE/
%   GITHUB: HTTPS://GITHUB.COM/BLACK-CAT-SCIENCE/BCS-MATLAB-PUBLIC/
%   MATHWORKS: HTTP://WWW.MATHWORKS.COM/MATLABCENTRAL/FILEEXCHANGE/
%  -------------------------------------------------------------------------
%   [output] = optical_flow(imgs, options)
%   Demonstrates optical flow algorithm based on Lucas-Kanade Method
%   run optical_flow(); on command line for example output
%
%   INPUTS:  imgs (required): an [M x N x P] array of images, [M x N] is the size of
%            the image and P is the # of images. P > 1 images is required.
%
%            options.x_blk_size (optional): x-width (pixels)of sub-domain block
%            size
%
%            options.y_blk_size (optional): y-width (pixels)of sub-domain block
%            size
%           
%            options.displayResults (optional): [0|1] flag to show image of
%            results after processing. Default set to off [0]
%
%   OUTPUTS: output.position: [NF x 2 x NX*NY] positon matrix of center location of
%            of sub-domains. NF is # image frames - 1. NX is # of x
%            sub-domains. NY is # of y sub-domains.
%
%            output.velocity: [NF x 2 x NX*NY] matrix of (relative)
%            velocities.
%
%            output.num_blks_x: number of sub-domians used in x-direction
%            output.num_blks_y: number of sub-domains used in y-direction
%
%            output.blk_size_x: x block size (pixels)
%            output.blk_size_y: y block size (pixels)
%
%            output.nframes: number of image frames
%            output.process_time: process time in seconds
%
%   DEPENDENCIES: NONE
%   MATLAB: Version 8.4 (R2014b)
%  --------------------------------------------------------------------------

t = tic;
position = [];
velocity = [];
if nargin == 0
    display('running demo...')
    display('loading data...')
    try
    load cat_data
    catch
        display('missing demo file "cat_data.mat"')
        display('demo aborted.')
        return
    end
    imgs = single(imgs);
end

if size(imgs,3) < 2
    error('need at least 2 image frames for optical flow algorithm to operate')
end

if nargin < 2
    x_blk_size = floor(.04*size(imgs,2));
    y_blk_size = floor(.04*size(imgs,1));
else
    
    if ~isfield(options,'x_blk_size')
        x_blk_size = floor(.04*size(imgs,2));
        display(sprintf('no x_blk_size options found, using %g',x_blk_size))
    end
    
     if ~isfield(options,'y_blk_size')
         
        y_blk_size = floor(.04*size(imgs,1));
        display(sprintf('no x_blk_size options found, using %g',y_blk_size))
     end
    
    if ~isfield(options,'displayResults')
        displayResults = 0;
    end
end

nframe = size(imgs,3);

for iframe = 1:nframe-1
    display(sprintf('processing frame: %g of %g...',iframe,nframe-1))
    
    frame1 = squeeze(imgs(:,:,iframe));
    frame2 = squeeze(imgs(:,:,iframe+1));
    %--------------------------------------------------------------------------
    %  calculate change in image with respect to position
    [Ix,Iy] = gradient(frame1);
    [ny, nx] = size(Ix);
    %--------------------------------------------------------------------------
    % calculate change in image with respect to time using nearest frames
    It = frame2-frame1;
    
    %--------------------------------------------------------------------------
    % initialize counter
    ct = 1;
    
    %--------------------------------------------------------------------------
    % calculate x-range of first block
    x1 = 1;
    x2 = x1+x_blk_size;
    
    %--------------------------------------------------------------------------
    % calculate steps in x and y direction
    xs = floor((nx-x_blk_size)/x_blk_size);
    ys = floor((ny-y_blk_size)/y_blk_size);
    
    %--------------------------------------------------------------------------
    % initialzes velocity vectors
    % vx,vy are used to store the x-components of the velocity vector and
    % y-components of the velocity vector, respectively.
    vx = zeros(1,ys*xs);
    vy = zeros(1,ys*xs);
    
    %--------------------------------------------------------------------------
    % initializes position vectors
    % x,y store the center position of the block used to calculate the optical
    % flows values.
    x = zeros(1,ys*xs);
    y = zeros(1,ys*xs);
    
    
    %--------------------------------------------------------------------------
    % loop through image
    for ix = 1:xs
        
        y1 = 1;
        y2 = y1 + y_blk_size;
        
        for iy = 1:ys
            
            %------------------------------------------------------------------
            % select a sub-domain from gradient and difference image to perform
            % calculation on
            
            Ix_block = Ix(y1:y2,x1:x2);
            Iy_block = Iy(y1:y2,x1:x2);
            It_block = It(y1:y2,x1:x2);
            
            
            %------------------------------------------------------------------
            % Cast problem as linear equation and solve in a lsqr sense
            % This approach is known as the Lucas-Kanade Method
            % A*u = f
            % A'*A*u = A'*f
            % u = inv(A'*A)*A*f
            % solve inv(A'*A) using pseudo-inv (pinv)
            % f -> It  (change in image with repsect to time)
            % A -> [Ix,Iy] (chainge in image with respect to position)
            % u -> [vx,vy] (velocities, what we want to solve for)
            
            A = [Ix_block(:) , Iy_block(:)];
            b = -It_block(:);
            
            A = A(1:1:end,:);
            b = b(1:1:end);
            
            P = pinv(A'*A);
            u = P*A'*b;
            
            %------------------------------------------------------------------
            % realtive velocities from current sub-domain.
            %
            % Note: to convert this to a real velocity e.g. [m/s] you would
            % need to include information on the rate between frames
            % (delta-t) and the distance between neighbooring pixels in the
            % images (delta-x, delta-y). Otherwise, the result is a
            % relative velocity.
            vx(ct) = u(1);
            vy(ct) = u(2);
            
            %------------------------------------------------------------------
            % calculate mid point of sub-domain
            y(ct) = (x1+x2)/2;
            x(ct) = (y1+y2)/2;
            
            ct = ct+1;
            
            %------------------------------------------------------------------
            % get the y range of the new block
            y1 = y1 + y_blk_size + 1;
            y2 = y1 + y_blk_size;
            
            %------------------------------------------------------------------
            % make sure you don't exceed the image size in the y direction
            if y2 > ny
                y2  = ny;
            end
        end
        %----------------------------------------------------------------------
        % get the x range of the new block
        x1 = x1 + x_blk_size + 1;
        x2 = x1 + x_blk_size;
        %----------------------------------------------------------------------
        % make sure you don't exceed the image size in the x direction
        if x2 > nx
            x2 = nx;
        end
    end
    
    position(iframe,:,:) = [y ; x];
    velocity(iframe,:,:) = [vy ; vx];
    x = [];
    y = [];
    vx = [];
    vy = [];
    ct = 1;
    
end
%--------------------------------------------------------------------------
% if there are no input arguments, plot results
if nargin == 0 || options.displayResults
    
    
    figure
    subplot(1,2,1)
    imagesc(frame1),colormap gray
    axis image
    hold on
    x = squeeze(position(10,2,:));
    y = squeeze(position(10,1,:));
    vx = squeeze(velocity(10,2,:));
    vy = squeeze(velocity(10,1,:));
    plot(y,x,'.k','markersize',1)
    quiver(y,x,vy,vx,'r')
    subplot(1,2,2)
    imagesc(reshape(sqrt(vx.^2+vy.^2),[ys,xs]))
    axis image
    
    figure
    
    for iframe = 1:size(velocity,1);
        
        subplot(1,2,1)
        imagesc(squeeze(imgs(:,:,iframe+1))),colormap gray
        title(sprintf('velocity vectors + image\n frame %g',iframe))
        hold on
        x = squeeze(position(iframe,2,:));
        y = squeeze(position(iframe,1,:));
        vx = squeeze(velocity(iframe,2,:));
        vy = squeeze(velocity(iframe,1,:));
        plot(y,x,'.k','markersize',1)
        quiver(y,x,vy,vx,'r'), hold off
        axis image, axis([1 nx 1 ny])
        subplot(1,2,2)
        imagesc(reshape(sqrt(vx.^2+vy.^2),[ys,xs])),colorbar
        title(sprintf('speed map\nsqrt(vx^2+vy^2) \n frame %g',iframe))
        axis image
        drawnow
        pause(.1)
    end
    
    
end


output.position = position;
output.velocity = velocity;
output.num_blks_x = xs;
output.num_blks_y = ys;
output.blk_size_x = x_blk_size;
output.blk_size_y = y_blk_size;
output.nframes = nframe;
output.process_time = sprintf('%3.2f [sec]',toc(t));
