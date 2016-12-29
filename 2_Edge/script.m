clear all
close all
clc
ax=imread('door.jpg');
imshow(ax);
%%
gray = rgb2gray(ax);
imshow(gray)

%%
edgeC=edge(gray, 'canny');
imshow(edgeC)
%%
edgeP=edge(gray, 'prewitt');
imshow(edgeP)

%%
imshowpair(edgeC, edgeP, 'montage');
%%
imshowpair(imfill(edgeC,'holes'), imfill(edgeP,'holes'), 'montage');
