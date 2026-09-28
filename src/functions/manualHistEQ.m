function [imgEQ, countsEQ] = manualHistEQ(img)
    counts = manualHist(img);
    rows = size(img, 1);
    cols = size(img, 2);
    numChannels = size(img, 3);
    totalPixel = rows * cols;

    imgEQ = zeros(size(img), 'uint8');

    if numChannels == 1
        histEQ = zeros(256, 1);
        for r = 1:256
            sum = 0;
            for c = 1:r
                sum = sum + counts(c);
            end
            histEQ(r) = floor(255 * sum / totalPixel);
        end

        for r = 1:rows
            for c = 1:cols
                imgEQ(r, c) = histEQ(img(r, c) + 1);
            end
        end

        countsEQ = manualHist(imgEQ);
        
    elseif numChannels == 3
        countsEQ = zeros(256, 3);

        for ch = 1:3
            countsCh = counts(:, ch);
            histEQ = zeros(256, 1);
            for r = 1:256
                sum = 0;
                for c = 1:r
                    sum = sum + countsCh(c);
                end
                histEQ(r) = floor(255 * sum / totalPixel);
            end

            for r = 1:rows
                for c = 1:cols
                    imgEQ(r, c, ch) = histEQ(img(r ,c , ch) + 1);
                end
            end

            countsEQ = manualHist(imgEQ);
        end
    else
        error('histogram: citra harus grayscale (2D) atau RGB (3D dengan 3 kanal).');
    end
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