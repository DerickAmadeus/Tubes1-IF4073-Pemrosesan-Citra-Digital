function imgHasil = convFilter(img, kernel)
% CONVFILTER Melakukan filtering linear pada citra menggunakan konvolusi 2D
%
%   imgHasil = convFilter(img, kernel)
%
%   Input:
%     img    - citra uint8, grayscale (2D) atau RGB (3D)
%     kernel - matrix kernel/mask konvolusi, ukuran ganjil x ganjil
%              (misal 3x3 untuk blur, sharpen, dll)
%
%   Output:
%     imgHasil - citra uint8, ukuran SAMA dengan input (zero-padding)


    numChannels = size(img, 3);

    if numChannels == 1
        imgHasil = konvolusiSatuKanal(img, kernel);
    else
        % Untuk citra RGB, proses tiap kanal (R, G, B) secara terpisah
        imgHasil = zeros(size(img), 'uint8');
        for c = 1:numChannels
            imgHasil(:,:,c) = konvolusiSatuKanal(img(:,:,c), kernel);
        end
    end
end


function hasil = konvolusiSatuKanal(channel, kernel)

    channel = double(channel);
    [tinggi, lebar] = size(channel);
    [kH, kW] = size(kernel);

    if mod(kH,2) == 0 || mod(kW,2) == 0
        error('convFilter: ukuran kernel harus ganjil (misal 3x3, 5x5).');
    end

    % Balik kernel 180 derajat (flip horizontal + vertical)
    kernelFlip = rot90(kernel, 2);

    % Hitung berapa banyak padding dibutuhkan di tiap sisi
    padH = floor(kH/2);
    padW = floor(kW/2);

    % Zero-padding
    channelPad = zeros(tinggi + 2*padH, lebar + 2*padW);
    channelPad(padH+1 : padH+tinggi, padW+1 : padW+lebar) = channel;

    hasil = zeros(tinggi, lebar);

    % Kernel shift 
    for i = 1:tinggi
        for j = 1:lebar
            patch = channelPad(i : i+kH-1, j : j+kW-1);

            hasil(i,j) = sum(sum(patch .* kernelFlip));
        end
    end

    % Clip ke rentang 0-255 lalu ubah ke uint8
    hasil(hasil < 0) = 0;
    hasil(hasil > 255) = 255;
    hasil = uint8(hasil);
end