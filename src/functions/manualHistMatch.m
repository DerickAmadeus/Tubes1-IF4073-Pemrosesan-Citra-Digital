function [imgMatched, countsMatched] = manualHistMatch(imgSrc, imgRef)
    rowsS = size(imgSrc, 1);
    colsS = size(imgSrc, 2);
    numChannelsS = size(imgSrc, 3);
    rowsR = size(imgRef, 1);
    colsR = size(imgRef, 2);
    numChannelsR = size(imgRef, 3);

    if numChannelsS ~= numChannelsR
        error('Jumlah kanal citra sumber dan referensi harus sama!');
    end

    countsSrc = manualHist(imgSrc);
    countsRef = manualHist(imgRef);

    totalPixelS = rowsS * colsS;
    totalPixelR = rowsR * colsR;

    imgMatched = zeros(size(imgSrc), 'uint8');

    for ch = 1:numChannelsS
        countsS_ch = countsSrc(:, ch);
        countsR_ch = countsRef(:, ch);

        zSrc= zeros(256, 1);
        sumS = 0;
        for i = 1:256
            sumS = sumS + countsS_ch(i);
            zSrc(i) = round(255 * sumS / totalPixelS);
        end

        zRef = zeros(256, 1);
        sumR = 0;
        for i = 1:256
            sumR = sumR + countsR_ch(i);
            zRef(i) = round(255 * sumR / totalPixelR);
        end

        M = zeros(256, 1, 'uint8');
        for i = 1:256
            T = zSrc(i);

            minDiff = inf;
            bestZ = 0;

            for j = 1:256
                diff = abs(zRef(j) - T);
                if diff < minDiff
                    minDiff = diff;
                    bestZ = j - 1; 
                end
            end

            M(i) = bestZ;
        end

        for r = 1:rowsS
            for c = 1:colsS
                pikselLama = imgSrc(r, c, ch);
                imgMatched(r, c, ch) = M(pikselLama + 1);
            end
        end
    end

    countsMatched = manualHist(imgMatched);
end

function counts = manualHist(img)

    numChannels = size(img, 3);

    if numChannels == 1
        counts = hitungSatuKanal(img);

    elseif numChannels == 3
        counts = zeros(256, 3);
        counts(:,1) = hitungSatuKanal(img(:,:,1)); % kanal R
        counts(:,2) = hitungSatuKanal(img(:,:,2)); % kanal G
        counts(:,3) = hitungSatuKanal(img(:,:,3)); % kanal B

    else
        error('histogram: citra harus grayscale (2D) atau RGB (3D dengan 3 kanal).');
    end
end

function counts = hitungSatuKanal(channel)    
    channel = double(channel);
    counts = zeros(256, 1);

    pixelValues = channel(:);

    for i = 1:length(pixelValues)
        nilai = pixelValues(i);
        counts(nilai + 1) = counts(nilai + 1) + 1;
    end
end