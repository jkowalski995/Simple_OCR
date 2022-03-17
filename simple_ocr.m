clc;
clear all;

%loading a image for OCR
[file, path]= uigetfile('Please choose a file with text');
tekst = imread(file);
save tekst %saving an image as a mat file
load tekst %loading an image
%plotting an image in grayscale 
tekst_img = tekst;
White = max(max(tekst_img));
figure
imagesc(tekst_img)
axis image off
tekst_img = rgb2gray(tekst_img)
title('Orygina³')

%loading an image with letter to find
[file, path]= uigetfile('Please choose a letter');
litera = imread(file);
save litera
load litera
%plotting an image in grayscale
img_litera = litera;
White = max(max(img_litera));
figure
imagesc(img_litera)
axis image off
img_litera = rgb2gray(img_litera)
title('Letter')

%doing a correlation
korelacja = xcorr2(tekst_img,img_litera);%correlation function
[row,col] = max(korelacja(:)); %result of correlation is down right corner of an image with letter
[ij,ji] = ind2sub(size(korelacja),col); %getting this coordinates

%plotting a correlation function
figure
plot(korelacja(:))
title('Correlation function')
hold on
plot(col,row,'or')
hold off
text(col*1.05,row,'Max')

%plotting a text with founded letter
figure
imagesc(tekst_img) %making a image in color map
title('Results - letter founded')
hold on
[wys szer] = size(img_litera);
plot([ji-11 ji-11 ji-szer+11 ji-szer+11 ji-11],[ij-11 ij-wys+11 ij-wys+11 ij-11 ij-11],'b', 'LineWidth', 3) %plotting a frame