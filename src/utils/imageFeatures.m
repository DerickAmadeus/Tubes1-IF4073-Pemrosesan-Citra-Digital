function fitur = imageFeatures(img)
% IMAGEFEATURES Menghitung fitur/karakteristik statistik dari sebuah citra,
% dipakai untuk membantu analisis sebelum/sesudah enhancement.
%
%   fitur = imageFeatures(img)
%
%   Input:
%     img   - citra uint8, grayscale (2D) atau RGB (3D)
%
%   Output:
%     fitur - struct berisi:
%             .minVal   - nilai intensitas paling rendah
%             .maxVal   - nilai intensitas paling tinggi
%             .meanVal  - rata-rata intensitas
%             .stdVal   - standar deviasi (seberapa "menyebar" nilainya)
%             .entropy  - entropy (seberapa banyak informasi/variasi dalam citra)
%   hasil vector 1x3 untuk tiap field.

    numChannels = size(img, 3);

    if numChannels == 1
        fitur = hitungFiturSatuKanal(img);
    else
        % Untuk RGB, hitung tiap kanal lalu gabungkan jadi vector 1x3
        minVal = zeros(1,3); maxVal = zeros(1,3);
        meanVal = zeros(1,3); stdVal = zeros(1,3); entropyVal = zeros(1,3);

        for c = 1:numChannels
            f = hitungFiturSatuKanal(img(:,:,c));
            minVal(c) = f.minVal;
            maxVal(c) = f.maxVal;
            meanVal(c) = f.meanVal;
            stdVal(c) = f.stdVal;
            entropyVal(c) = f.entropy;
        end

        fitur.minVal = minVal;
        fitur.maxVal = maxVal;
        fitur.meanVal = meanVal;
        fitur.stdVal = stdVal;
        fitur.entropy = entropyVal;
    end
end


function fitur = hitungFiturSatuKanal(channel)

    pixelValues = double(channel(:));
    n = numel(pixelValues);

    % Min dan max intensitas
    fitur.minVal = min(pixelValues);
    fitur.maxVal = max(pixelValues);

    % jumlah semua nilai dibagi banyaknya pixel
    fitur.meanVal = sum(pixelValues) / n;

    % sqrt( rata-rata( (x - mean)^2 ) )
    selisihKuadrat = (pixelValues - fitur.meanVal) .^ 2;
    fitur.stdVal = sqrt(sum(selisihKuadrat) / n);

    % -sum( p(i) * log2(p(i)) ) untuk tiap intensitas i yang muncul
    counts = manualHist(uint8(channel));   
    probabilitas = counts / n;             % (0-1)

    probabilitasValid = probabilitas(probabilitas > 0);
    fitur.entropy = -sum(probabilitasValid .* log2(probabilitasValid));
end