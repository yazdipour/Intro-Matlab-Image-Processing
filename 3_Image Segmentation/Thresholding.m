%% Read in image
I = imread('Toys_Candy.jpg');
imshow(I);
%%  Convert to grayscale image
Igray = rgb2gray(I);
imshow(Igray);

%% problem
imshow(edge(im2bw(Igray,0.6)));

%% 
Ithresh = im2bw(Igray,.6);
imshowpair(I, Ithresh, 'montage');