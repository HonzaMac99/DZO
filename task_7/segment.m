    
%%% Read input images (drawing and scribbles):

pic = double(imread('data/drawing.png'))/255;
usr = double(imread('data/scribbles.png'));

% Info:
% convert the img to 0..1 and pow to 6, then scale it by 2000 (EK)
% to represent the capacity
% create source and sink and connect to all other nodes of the img
% scale these new connections by max 200 (SK) 10times less capacity
% kde je tah (scribble), tak 200, jinak 0
% 



%%% Setting scale for edge capacities between two white pixels:

EK = 2000;

%%% Setting scale for edge capacities that correspond to soft scribbles:

SK = 200;

%%% Getting drawing dimensions:

w = size(pic, 1);
h = size(pic, 2);

%%% Setting indices of auxillary source "S" and sink "T" terminal vertices:

S = w * h + 1;
T = w * h + 2;

%%% Prepare an array "id" that assign unique index to each pixel (x,y) and 
%%% inverted arrays "idx" and "idy" that for the given vertex index returns 
%%% x and y coordiantes of its corresponding pixel [1.5 point]:

vid = 1; % vertex index

id = zeros(size(pic,1:2));
idx = zeros(1,w);
idy = zeros(1,h);

for x=1:w
    for y=1:h
        id(x,y) = vid;
        idx(vid) = x;
        idy(vid) = y;       
        vid = vid + 1;
    end
end

%%% Setup directed edges going from the source terminal "S" to all pixels 
%%% and from all pixels to the sink terminal "T" and set their capacities
%%% according to scribbles stored in "usr" (use "SK") [3 points]:

eid = 1; % edge index
% directed edges between pixels and from S and T to all pixels
n_edges = 2*w*(h-1) + 2*(w-1)*h + 2*w*h;

source = zeros(1, n_edges);
target = zeros(1, n_edges);
capacity = zeros(1, n_edges);

% Graph edges are specified using three index arrays:
%
% "source(eid)" = index of source (from) graph vertex
% "target(eid)" = index of target (to) graph vertex
% "capacity(eid)" = edge capacity

% create edges from source "S"
for x=1:w
    for y=1:h 
       source(eid) = S;
       target(eid) = id(x,y);
       
       % check for white color
       if usr(x, y, 1) == 255
           capacity(eid) = SK;
       else
           capacity(eid) = 0;
       end         
       eid = eid + 1;
    end
end

% create edges to sink "T"
for x=1:w
    for y=1:h        
       source(eid) = id(x,y);
       target(eid) = T;
       
       % check for green color
       if usr(x, y, 1) == 14
           capacity(eid) = SK;
       else
           capacity(eid) = 0;
       end      
       eid = eid + 1;
    end 
end

%%% Setup capacities of undirected edges between neighbour pixels 
%%% (undirected edge = two directed edges in opposite direction with 
%%% the same capacity). As a capacity use "EK" scaled in proportion to 
%%% pixel's intensity. You can use gamma correction to improve contrast 
%%% between white and dark pixels (remember that edge capacity between 
%%% pixels shouldn't be equal to zero) [4 points]:

%cap = 1 + min(I1, I2)^6*2000;

for x=1:w
    for y=1:h
        if x < w && y < h
            source(eid:eid+3) = [id(x,y), id(x,y), id(x+1,y), id(x,y+1)];
            target(eid:eid+3) = [id(x+1,y), id(x,y+1), id(x,y), id(x,y)];
            
            cap1 = 1 + min(pic(x,y), pic(x+1,y))^6*EK;
            cap2 = 1 + min(pic(x,y), pic(x,y+1))^6*EK;
            capacity(eid:eid+3) = [cap1, cap2, cap1, cap2];
            
            eid = eid+4;      

        elseif x == w && y < h
           source(eid:eid+1) = [id(x,y), id(x,y+1)];
           target(eid:eid+1) = [id(x,y+1), id(x,y)];
           
           cap1 = 1 + min(pic(x,y), pic(x,y+1))^6*EK;
           capacity(eid:eid+1) = [cap1, cap1];
           
           eid = eid+2;
       
        elseif x < w && y == h
           source(eid:eid+1) = [id(x+1,y), id(x,y)];
           target(eid:eid+1) = [id(x,y), id(x+1,y)];
           
           cap1 = 1 + min(pic(x,y), pic(x+1,y))^6*EK;
           capacity(eid:eid+1) = [cap1, cap1];
           
           eid = eid+2;

        end
    end 
end

%%% Construct a directed graph "G" and solve for maximum flow between 
%%% source "S" and sink "T" terminal vertices. Use "source", "target", 
%%% and "capacity" arrays prepared in previous steps:

G = digraph(source, target, capacity);
%plot(G)

[MF,GF,CS,CT] = maxflow(G,S,T);

%%% Get indices of pixels labelled as belonging to terminal "T" stored 
%%% in the array "CT" and colorize them by multiplying their original 
%%% intensity with the color components of the green color. Use "idx"
%%% and "idy" to lookup pixel coordiantes [1.5 points]: 

% copy the input drawing to the output
out = pic*255;
 
% setup green color RGB values
col_g = [14, 138, 8];

for id=1:size(CT)-2
    x = idx(CT(id));
    y = idy(CT(id));
    out(x, y, :) = col_g*pic(x,y); 
end

%%% Save the resulting colorized image:

imwrite(out/255,'output.png');
