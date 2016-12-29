clc,clear all;
close all;
% Deblurring Images Using the Blind Deconvolution Algorithm
%%   Step 1
I = imread('cameraman.png');
figure;imshow(I);title('Original Image');

%% Step 2: Simulate a Blur
% h = fspecial('gaussian', hsize, sigma) returns a rotationally 
% symmetric Gaussian lowpass filter of size hsize with standard
% deviation sigma (positive).
% The default value for hsize is [3 3]; the default value for sigma is 0.5.
PSF = fspecial('gaussian',7,10);
Blurred = imfilter(I,PSF,'symmetric','conv');
imshow(Blurred);title('Blurred Image');

%% Step 3: Restore the Blurred Image Using PSFs of Various Sizes
UNDERPSF = ones(3);
[J1, P1] = deconvblind(Blurred,UNDERPSF);
imshow(J1);title('Deblurring with Undersized PSF');

%% The second restoration, J2 and P2, uses an array of ones, OVERPSF, 
% OVERPSF = padarray(UNDERPSF,[4 4],'replicate','both');
OVERPSF=ones(11);
[J2, P2] = deconvblind(Blurred,OVERPSF);
imshow(J2);title('Deblurring with Oversized PSF');

%% The third restoration, more accurate
INITPSF = ones(7);
[J3, P3] = deconvblind(Blurred,INITPSF);
imshow(J3);title('Deblurring with INITPSF');

%% Step 4: Analyzing the Restored PSF
figure;
subplot(221);imshow(PSF,[],'InitialMagnification','fit');
title('True PSF');
subplot(222);imshow(P1,[],'InitialMagnification','fit');
title('Reconstructed Undersized PSF');
subplot(223);imshow(P2,[],'InitialMagnification','fit');
title('Reconstructed Oversized PSF');
subplot(224);imshow(P3,[],'InitialMagnification','fit');
title('Reconstructed true PSF');