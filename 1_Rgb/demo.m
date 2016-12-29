close all;
clc, clear all;
%%
I=imread('Lenna.png');

%%
imshow(I)

%%
imtool(I)

%%
leye=imcrop(I,[120,140,100,30]);
 
%% red filter
l=I;
l(:,:,2)=0;
l(:,:,3)=0;
imshow(l);
%% green filter
l=I;
l(:,:,1)=0;
l(:,:,3)=0;
imshow(l);
%% blue filter
l=I;
l(:,:,1)=0;
l(:,:,2)=0;
imshow(l);
