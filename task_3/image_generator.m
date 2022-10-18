function [I] = image_generator(sig_type, imsize, varargin)
%IMAGE_GENERATOR - generates 2d signals
%
% [I] = image_generator(sig_type, params)
%   
%   sig_type - string {'constant','harmonic','square','circ','Gaussian','Gabor'}
%   params - list of parameters depending on signal type    
%       'constant':  a (dc component)
%       'harmonic':  u,v,phi (horizontal and vertical frequency in range 0..pi, pi is the Nyquist frequency, phase 0..pi)
%       'square':  s (half-side of the square in pixels)
%       'circ':    r (radius of the circle in pixels)
%       'Gaussian': sigma (standard deviation in pixels)
%       'Gabor': u0,v0,sigma (normalized horizontal,vertical frequency 0..pi, standard deviation)
%
% Example: 
%   I = image_genrator('Gaussian',[512,512],20);
%

I = zeros(imsize); %init (in case something is not implemented)
centre_x = imsize(1)/2;
centre_y = imsize(2)/2;
switch sig_type
    case 'constant'  %a
        a = varargin{1};
        
        I = I + a;
        
    case 'harmonic'  %u, v
        u = varargin{1}; v = varargin{2}; phi = varargin{3};
        
        for i = 1:imsize(1)
            for j = 1:imsize(2)
                x = j - centre_x;
                y = i - centre_y;
                I(i, j) = cos(u*x + v*y + phi);
            end
        end
        
    case 'square'    %s
        s = varargin{1};          
        
        for i = 1:imsize(1)
            for j = 1:imsize(2)
                if ((j > centre_x - s) && (j < centre_x + s)) && ...
                   ((i > centre_y - s) && (i < centre_y + s))
                    I(i, j) = 1;
                end
            end
        end     
        
    case 'circ'      %r
        r = varargin{1};
        
        for i = 1:imsize(1)
            for j = 1:imsize(2)
                dist_to_centre = sqrt((j-centre_x)^2 + (i-centre_y)^2);
                if dist_to_centre < r
                    I(i, j) = 1;
                end
            end
        end  
    
    case 'inv_circ'      %r
        r = varargin{1};
        I = ones(imsize);
        
        for i = 1:imsize(1)
            for j = 1:imsize(2)
                dist_to_centre = sqrt((j-centre_x)^2 + (i-centre_y)^2);
                if dist_to_centre < r
                    I(i, j) = 0;
                end
            end
        end
        
    case 'Gaussian'  %sigma
        sigma = varargin{1};
        
        for i = 1:imsize(1)
            for j = 1:imsize(2)
                x = j - centre_x;
                y = i - centre_y;
                I(i, j) = exp(-(x^2 + y^2)/(2*sigma^2));
            end
        end      
        
    case 'Gabor'     %u0,v0,sigma  (OPTIONAL)
        u0 = varargin{1}; v0 = varargin{2}; sigma = varargin{3};
        
        for i = 1:imsize(1)
            for j = 1:imsize(2)
                x = j - centre_x;
                y = i - centre_y;
                I(i, j) = cos(u0*x + v0*y)*exp(-(x^2 + y^2)/(2*sigma^2));
            end
        end
        
    otherwise
        error('Unknown signal type.')
end



