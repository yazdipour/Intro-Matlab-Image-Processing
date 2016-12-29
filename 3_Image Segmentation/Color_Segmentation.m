%% Read in image
clc,close all;
clear all;
I = imread('Toys_Candy.jpg');
imshow(I);

%%
Im=I;

rmat=Im(:,:,1);
gmat=Im(:,:,2);
bmat=Im(:,:,3);

subplot(2,2,1), imshow(rmat);
title('Red Plane');
subplot(2,2,2), imshow(gmat);
title('Green Plane');
subplot(2,2,3), imshow(bmat);
title('Blue Plane');
subplot(2,2,4), imshow(I);
title('Original Image');
linkaxes;
%%
i1=im2bw(rmat,.6);
i2=im2bw(gmat,.5);
i3=im2bw(bmat,.4);
Isum = i1&i2&i3;

subplot(2,2,1), imshow(i1);
title('Red Plane');
subplot(2,2,2), imshow(i2);
title('Green Plane');
subplot(2,2,3), imshow(i3);
title('Blue Plane');
subplot(2,2,4), imshow(Isum);
title('Sum of all the planes');

%% Complement Image 
Icomp = imcomplement(Isum);
figure, imshow(Icomp); 
% 1-Isum
%% Fill in holes

Ifilled = imfill(Icomp,'holes');
figure, imshow(Ifilled);
%% creating morphological structuring element
se = strel('disk', 25);
Iopenned = imopen(Ifilled,se);
figure ,imshow(Iopenned);

%% Extract features

[labeled,numObjects] = bwlabel(Iopenned,4); %help
stats = regionprops(labeled,'BoundingBox');

%Iregion = regionprops(Iopenned, 'centroid');

%% Use feature analysis to count skittles objects

figure, imshow(I);
hold on;
for idx = 1 :numObjects
        h = rectangle('Position',stats(idx).BoundingBox,'LineWidth',2);
        set(h,'EdgeColor',[1 0 0]);
        hold on;
end
title(['There are ', num2str(numObjects), ' objects in the image!']);
hold off;


