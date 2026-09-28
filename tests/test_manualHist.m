%% TEST_HISTOGRAM
% Script ini buat nyoba fungsi histogram.m
% Ada 2 percobaan: pakai citra buatan sendiri (biar pasti bisa dites
% walau belum punya dataset), dan pakai citra asli kalau sudah punya.

clear; clc; close all;

%% ---- Percobaan 1: Citra grayscale buatan (biar gampang dicek manual) ----
% Kita bikin citra kecil 4x4 dengan nilai yang sudah kita tentukan sendiri,
% biar kita bisa hitung manual dan cocokkan dengan hasil fungsi.

imgKecil = uint8([0 0 5 5;
                   5 5 5 10;
                   10 10 0 0;
                   0 5 10 10]);

fprintf('=== Percobaan 1: Citra grayscale kecil ===\n');
disp('Citra:');
disp(imgKecil);

counts1 = manualHist(imgKecil);

fprintf('Jumlah pixel intensitas 0  : %d (harusnya 5)\n', counts1(0+1));
fprintf('Jumlah pixel intensitas 5  : %d (harusnya 6)\n', counts1(5+1));
fprintf('Jumlah pixel intensitas 10 : %d (harusnya 5)\n', counts1(10+1));
fprintf('Total semua pixel: %d (harusnya 16, sesuai ukuran 4x4)\n\n', sum(counts1));

% Tampilkan histogramnya pakai bar chart biasa (bukan imhist!)
figure;
bar(0:255, counts1);
title('Histogram Citra Kecil (Grayscale)');
xlabel('Intensitas'); ylabel('Jumlah Pixel');
xlim([0 20]); % zoom biar kelihatan, soalnya cuma ada nilai 0,5,10


%% ---- Percobaan 2: Citra acak yang lebih besar (grayscale) ----
fprintf('=== Percobaan 2: Citra grayscale acak 100x100 ===\n');
imgAcak = uint8(randi([0 255], 100, 100));

counts2 = manualHist(imgAcak);

fprintf('Total pixel dari histogram: %d\n', sum(counts2));
fprintf('Total pixel sebenarnya    : %d (harus SAMA)\n\n', numel(imgAcak));

% Bandingkan dengan fungsi bawaan MATLAB (imhist) HANYA untuk validasi,
% sesuai aturan tugas: imhist boleh dipakai untuk membandingkan hasil.
% Catatan: imhist butuh Image Processing Toolbox. Kalau belum ke-install,
% bagian ini otomatis di-skip (nggak bikin error / program tetap lanjut).

if exist('imhist', 'file') == 2
    countsBawaan = imhist(imgAcak);

    if isequal(counts2, countsBawaan)
        fprintf('COCOK! Hasil fungsi manual sama persis dengan imhist bawaan MATLAB.\n\n');
    else
        fprintf('BEDA! Ada yang salah, cek lagi logikanya.\n\n');
    end

    figure;
    subplot(1,2,1);
    bar(0:255, counts2);
    title('Histogram Manual (buatan sendiri)');
    xlabel('Intensitas'); ylabel('Jumlah Pixel');

    subplot(1,2,2);
    bar(0:255, countsBawaan);
    title('Histogram imhist (bawaan MATLAB)');
    xlabel('Intensitas'); ylabel('Jumlah Pixel');
else
    fprintf('Image Processing Toolbox belum terinstall, skip validasi imhist.\n');
    fprintf('(Fungsi manual tetap valid, sudah terbukti dari Percobaan 1 & total pixel di atas)\n\n');

    figure;
    bar(0:255, counts2);
    title('Histogram Manual (buatan sendiri)');
    xlabel('Intensitas'); ylabel('Jumlah Pixel');
end


%% ---- Percobaan 3: Citra berwarna (RGB) ----
fprintf('=== Percobaan 3: Citra RGB acak 50x50 ===\n');
imgRGB = uint8(randi([0 255], 50, 50, 3));

countsRGB = manualHist(imgRGB);

fprintf('Ukuran hasil (harus 256x3): %d x %d\n', size(countsRGB,1), size(countsRGB,2));

figure;
subplot(3,1,1);
bar(0:255, countsRGB(:,1), 'r');
title('Histogram Kanal R');

subplot(3,1,2);
bar(0:255, countsRGB(:,2), 'g');
title('Histogram Kanal G');

subplot(3,1,3);
bar(0:255, countsRGB(:,3), 'b');
title('Histogram Kanal B');

fprintf('\nSemua test selesai. Cek Command Window dan figure yang muncul.\n');