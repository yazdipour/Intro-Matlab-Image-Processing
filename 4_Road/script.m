%%
clc,clear all,close all;
road=imread('road.jpg');
imshow(road);

%% Cropping
img= imcrop(road,[60 70 580 300]);
imshow(img);

%% Segment by thresholding
bw=im2bw(img,200/255);
%bw=im2bw(img,graythresh(img));
imshow(bw);

%% clean up
% Mophology can assist sgmentation
% removing small OBJs
bw2 = bwareaopen(bw,50);
imshow(bw2)
%% Clear border Obj
bw3 = imclearborder(bw2);
imshow(bw3);

%% Finding objects
% find all remaining connected regions 1st.
[B L]= bwboundaries(bw3,'noholes');
imshow(label2rgb(L));

%% feature extractiong
stats= regionprops(L,'all');
shapes =[stats.Eccentricity];
lines = find(shapes>.98);

%% show lines on image
imshow(img);
for index=1:length(lines)
	outline = B{lines(index)};
	line(outline(:,2),outline(:,1),'Color','r','LineWidth',3)
end