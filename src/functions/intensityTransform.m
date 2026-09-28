function imgHasil = intensityTransform(img, jenis, params)
% INTENSITYTRANSFORM Mengubah nilai intensitas tiap pixel citra
% menggunakan salah satu dari beberapa metode transformasi.
%
%   imgHasil = intensityTransform(img, jenis, params)
%
%   Input:
%     img    - citra uint8, grayscale (2D) atau RGB (3D)
%     jenis  - string, pilih salah satu:
%              'negative'  -> kebalikan warna (seperti negatif film)
%              'log'       -> log transform (terangkan bagian gelap)
%              'gamma'     -> power-law/gamma correction
%              'contrast'  -> contrast stretching linear
%     params - struct berisi parameter tambahan tergantung jenis:
%              untuk 'log'      : params.c (konstanta, opsional, default dihitung otomatis)
%              untuk 'gamma'    : params.gamma (nilai gamma, misal 0.5 atau 2)
%              untuk 'contrast' : params.lowIn, params.highIn (rentang input yang diregangkan)
%              untuk 'negative' : params tidak dipakai (boleh kosong [])
%
%   Output:
%     imgHasil - citra uint8, ukuran sama dengan input
    imgDouble = double(img);

    switch lower(jenis)

        case 'negative'
            % s = 255 - ra.
            hasilDouble = 255 - imgDouble;

        case 'log'
            % s = c * log(1 + r)
            if isfield(params, 'c')
                c = params.c;
            else
                c = 255 / log(1 + 255);
            end
            hasilDouble = c * log(1 + imgDouble);

        case 'gamma'
            % s = 255 * (r/255)^gamma
            % gamma < 1 -> terang
            % gamma > 1 -> gelap
            gamma = params.gamma;
            hasilDouble = 255 * (imgDouble / 255) .^ gamma;

        case 'contrast'
            % Contrast stretching linear sederhana.
            % Nilai di bawah lowIn dianggap 0, di atas highIn dianggap 255,
            % di antaranya diregangkan secara linear.
            lowIn = params.lowIn;
            highIn = params.highIn;

            hasilDouble = (imgDouble - lowIn) / (highIn - lowIn) * 255;

            % dipotong 0 atau 255
            hasilDouble(hasilDouble < 0) = 0;
            hasilDouble(hasilDouble > 255) = 255;

        otherwise
            error('intensityTransform: jenis "%s" tidak dikenali. Pilih: negative, log, gamma, contrast.', jenis);
    end

    % hasil akhir dalam rentang 0-255, lalu ubah balik ke uint8
    hasilDouble(hasilDouble < 0) = 0;
    hasilDouble(hasilDouble > 255) = 255;
    imgHasil = uint8(hasilDouble);
end