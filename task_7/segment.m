    
%%% Read input images (drawing and scribbles):

pic = double(imread('data/drawing.png'));
usr = double(imread('data/scribbles.png'));

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

for x=1:w
 for y=1:h
 
  ...   
 
 end
end

%%% Setup directed edges going from the source terminal "S" to all pixels 
%%% and from all pixels to the sink terminal "T" and set their capacities
%%% according to scribbles stored in "usr" (use "SK") [3 points]:

eid = 1; % edge index

for x=1:w
 for y=1:h

  %% ... 

  %% Graph edges are specified using three index arrays:
  %%
  %% "source(eid)" = index of source (from) graph vertex
  %% "target(eid)" = index of target (to) graph vertex
  %% "capacity(eid)" = edge capacity
 
 end 
end

%%% Setup capacities of undirected edges between neighbour pixels 
%%% (undirected edge = two directed edges in opposite direction with 
%%% the same capacity). As a capacity use "EK" scaled in proportion to 
%%% pixel's intensity. You can use gamma correction to improve contrast 
%%% between white and dark pixels (remember that edge capacity between 
%%% pixels shouldn't be equal to zero) [4 points]:

for x=1:w
 for y=1:h
  
  ...
 
 end 
end

%%% Construct a directed graph "G" and solve for maximum flow between 
%%% source "S" and sink "T" terminal vertices. Use "source", "target", 
%%% and "capacity" arrays prepared in previous steps:

G = digraph(source, target, capacity);

[MF,GF,CS,CT] = maxflow(G,S,T);

%%% Get indices of pixels labelled as belonging to terminal "T" stored 
%%% in the array "CT" and colorize them by multiplying their original 
%%% intensity with the color components of the green color. Use "idx"
%%% and "idy" to lookup pixel coordiantes [1.5 points]: 

out = pic; % copy the input drawing to the output

col(1) = 14; % setup green color RGB values
col(2) = 138;
col(3) = 8; 

for id=1:size(CT)
  
 ...
 
end

%%% Save the resulting colorized image:

imwrite(out/255,'output.png');
