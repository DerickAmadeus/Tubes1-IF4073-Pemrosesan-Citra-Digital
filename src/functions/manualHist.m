function counts = manualHist(img)
% MANUALHIST Menghitung histogram 256 tingkat intensitas dari sebuah citra.
%
%   counts = manualHist(img)
%
%   Input:
%     img    - citra grayscale (2D) atau citra berwarna RGB (3D, MxNx3)
%              tipe data uint8 (nilai 0-255)
%
%   Output:
%     counts - untuk citra grayscale: vector 1x256, counts(k) = jumlah
%              pixel dengan intensitas (k-1)
%              untuk citra RGB: matrix 256x3, kolom 1=R, kolom 2=G, kolom 3=B

    numChannels = size(img, 3);

    if numChannels == 1
        % ---- Citra grayscale ----
        counts = hitungSatuKanal(img);

    elseif numChannels == 3
        % ---- Citra berwarna: hitung histogram tiap kanal R, G, B terpisah ----
        counts = zeros(256, 3);
        counts(:,1) = hitungSatuKanal(img(:,:,1)); % kanal R
        counts(:,2) = hitungSatuKanal(img(:,:,2)); % kanal G
        counts(:,3) = hitungSatuKanal(img(:,:,3)); % kanal B

    else
        error('histogram: citra harus grayscale (2D) atau RGB (3D dengan 3 kanal).');
    end
end


function counts = hitungSatuKanal(channel)
% Fungsi bantu (helper): hitung histogram untuk SATU kanal/matrix 2D.

    channel = double(channel);
    counts = zeros(256, 1);

    % Ratakan matrix 2D (MxN) jadi vector 1D panjang (M*N x 1)
    pixelValues = channel(:);

    % Loop setiap pixel, lalu tambahkan hitungan ke bin yang sesuai.
    for i = 1:length(pixelValues)
        nilai = pixelValues(i);
        counts(nilai + 1) = counts(nilai + 1) + 1;
    end
end