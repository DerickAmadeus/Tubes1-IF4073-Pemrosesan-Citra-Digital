function imgHasil = manualMedFilter(img, windowSize)
% MANUALMEDFILTER Melakukan median filtering pada citra secara manual
% (bukan pakai medfilt2). Ini termasuk filtering NON-LINEAR karena
% tidak menjumlahkan hasil kali kernel, tapi mengambil nilai TENGAH
% (median) dari sekumpulan pixel tetangga.
%
%   imgHasil = manualMedFilter(img, windowSize)
%
%   Input:
%     img        - citra uint8, grayscale (2D) atau RGB (3D)
%     windowSize - ukuran jendela/window, harus ganjil (misal 3 -> jendela 3x3)
%
%   Output:
%     imgHasil - citra uint8, ukuran SAMA dengan input

    if mod(windowSize, 2) == 0
        error('manualMedFilter: windowSize harus ganjil.');
    end

    numChannels = size(img, 3);

    if numChannels == 1
        imgHasil = medianSatuKanal(img, windowSize);
    else
        imgHasil = zeros(size(img), 'uint8');
        for c = 1:numChannels
            imgHasil(:,:,c) = medianSatuKanal(img(:,:,c), windowSize);
        end
    end
end


function hasil = medianSatuKanal(channel, windowSize)
% Helper: median filter manual untuk satu kanal.
%
% Konsepnya beda dari konvolusi:
%   1. Untuk tiap pixel, lihat semua pixel tetangga
%   2. Urutkan (sort) semua nilai dari kecil ke besar
%   3. Ambil nilai median as flter baru

    channel = double(channel);
    [tinggi, lebar] = size(channel);

    pad = floor(windowSize / 2);

    % Padding pakai replikasi tepi (bukan nol), supaya nilai di pinggir
    % citra tidak "tertarik" ke 0 gara-gara padding nol
    channelPad = padreplicate(channel, pad);

    hasil = zeros(tinggi, lebar);

    for i = 1:tinggi
        for j = 1:lebar
            % Ambil jendela pixel tetangga
            window = channelPad(i : i+windowSize-1, j : j+windowSize-1);

            % Ratakan jadi list 1D, urutkan, ambil nilai tengah
            nilaiUrut = sort(window(:));
            tengah = ceil(numel(nilaiUrut) / 2);
            hasil(i,j) = nilaiUrut(tengah);
        end
    end

    hasil = uint8(hasil);
end


function padded = padreplicate(channel, pad)
% Helper kecil: bikin padding dengan cara "meniru" nilai pixel tepi,
% biar pinggir citra tidak dianggap gelap (0) secara tidak wajar.

    [tinggi, lebar] = size(channel);
    padded = zeros(tinggi + 2*pad, lebar + 2*pad);

    % Taruh citra asli di tengah
    padded(pad+1:pad+tinggi, pad+1:pad+lebar) = channel;

    % Tiru baris atas & bawah
    for p = 1:pad
        padded(p, pad+1:pad+lebar) = channel(1, :);
        padded(pad+tinggi+p, pad+1:pad+lebar) = channel(end, :);
    end

    % Tiru kolom kiri & kanan (termasuk sudut-sudutnya)
    for p = 1:pad
        padded(:, p) = padded(:, pad+1);
        padded(:, pad+lebar+p) = padded(:, pad+lebar);
    end
end