clc; clear; close all;

img_gray = imread('image_01.png');
counts_gray_asli = manualHist(img_gray);

[img_gray_eq, counts_gray_eq] = manualHistEQ(img_gray);

figure('Name', 'Pengujian Grayscale EQ');
subplot(2, 2, 1); imshow(img_gray);           title('Citra Asli');
subplot(2, 2, 2); tampilkanHistogram(counts_gray_asli); title('Histogram Asli');

subplot(2, 2, 3); imshow(img_gray_eq);        title('Citra Hasil Ekualisasi');
subplot(2, 2, 4); tampilkanHistogram(counts_gray_eq);   title('Histogram Hasil Ekualisasi');