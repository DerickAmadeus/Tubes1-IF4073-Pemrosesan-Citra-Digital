

clear; clc; close all;

% Citra grayscale acak 100x100
imgGray = uint8(randi([0 255], 100, 100));

% Citra RGB acak 50x50
imgRGB = uint8(randi([0 255], 50, 50, 3));

fprintf('=== Citra uji siap: grayscale 100x100 & RGB 50x50 ===\n\n');


%% ---- Test 1: intensityTransform ----
fprintf('--- Test intensityTransform ---\n');

imgNeg = intensityTransform(imgGray, 'negative', []);
fprintf('Negative: OK, ukuran %s\n', mat2str(size(imgNeg)));

imgLog = intensityTransform(imgGray, 'log', struct());
fprintf('Log transform: OK, ukuran %s\n', mat2str(size(imgLog)));

imgGamma = intensityTransform(imgGray, 'gamma', struct('gamma', 0.5));
fprintf('Gamma (0.5): OK, ukuran %s\n', mat2str(size(imgGamma)));

imgContrast = intensityTransform(imgGray, 'contrast', struct('lowIn', 50, 'highIn', 200));
fprintf('Contrast stretching: OK, ukuran %s\n\n', mat2str(size(imgContrast)));

figure('Name', 'Intensity Transform');
subplot(2,3,1); imshow(imgGray); title('Asli');
subplot(2,3,2); imshow(imgNeg); title('Negative');
subplot(2,3,3); imshow(imgLog); title('Log');
subplot(2,3,4); imshow(imgGamma); title('Gamma 0.5');
subplot(2,3,5); imshow(imgContrast); title('Contrast Stretch');


%% ---- Test 2: convFilter ----
fprintf('--- Test convFilter ---\n');

kernelBlur = ones(3,3) / 9;  % rata-rata 3x3 (blur)
imgBlur = convFilter(imgGray, kernelBlur);
fprintf('Blur 3x3: OK, ukuran %s (harus sama dgn asli %s)\n', ...
    mat2str(size(imgBlur)), mat2str(size(imgGray)));

kernelSharpen = [0 -1 0; -1 5 -1; 0 -1 0];  % sharpen
imgSharpen = convFilter(imgGray, kernelSharpen);
fprintf('Sharpen 3x3: OK, ukuran %s\n', mat2str(size(imgSharpen)));

% Coba juga di citra RGB
imgBlurRGB = convFilter(imgRGB, kernelBlur);
fprintf('Blur pada RGB: OK, ukuran %s\n\n', mat2str(size(imgBlurRGB)));

figure('Name', 'Conv Filter');
subplot(1,3,1); imshow(imgGray); title('Asli');
subplot(1,3,2); imshow(imgBlur); title('Blur (avg 3x3)');
subplot(1,3,3); imshow(imgSharpen); title('Sharpen');


%% ---- Test 3: manualMedFilter ----
fprintf('--- Test manualMedFilter ---\n');

% Tambahkan noise "salt & pepper" biar kelihatan efek median filter-nya
imgNoisy = imgGray;
noiseMask = rand(size(imgGray)) < 0.05;  % 5% pixel kena noise
imgNoisy(noiseMask) = uint8(255 * (rand(sum(noiseMask(:)),1) > 0.5));

imgMedian = manualMedFilter(imgNoisy, 3);
fprintf('Median filter 3x3: OK, ukuran %s\n\n', mat2str(size(imgMedian)));

figure('Name', 'Median Filter');
subplot(1,3,1); imshow(imgGray); title('Asli');
subplot(1,3,2); imshow(imgNoisy); title('Ditambah Noise');
subplot(1,3,3); imshow(imgMedian); title('Setelah Median Filter');


%% ---- Test 4: imageFeatures ----
fprintf('--- Test imageFeatures ---\n');

fiturGray = imageFeatures(imgGray);
fprintf('Grayscale -> mean: %.2f, std: %.2f, min: %d, max: %d, entropy: %.3f\n', ...
    fiturGray.meanVal, fiturGray.stdVal, fiturGray.minVal, fiturGray.maxVal, fiturGray.entropy);

fiturRGB = imageFeatures(imgRGB);
fprintf('RGB -> mean (R,G,B): %s\n', mat2str(round(fiturRGB.meanVal,2)));
fprintf('RGB -> entropy (R,G,B): %s\n\n', mat2str(round(fiturRGB.entropy,3)));

fprintf('=== Semua test selesai. Cek angka & figure di atas. ===\n');