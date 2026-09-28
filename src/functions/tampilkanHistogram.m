function tampilkanHistogram(counts)
    x = 0:255;
    numChannels = size(counts, 2);
    
    isGrayscaleInRGB = (numChannels == 3) && isequal(counts(:,1), counts(:,2), counts(:,3));
    
    if numChannels == 1 || isGrayscaleInRGB
        if isGrayscaleInRGB
            counts = counts(:, 1);
        end
        
        bar(x, counts, 'FaceColor', [0.3 0.3 0.3], 'EdgeColor', 'none');
        title('Histogram Grayscale');
        
    elseif numChannels == 3
        hold on;
        plot(x, counts(:,1), 'r', 'LineWidth', 1.2);
        plot(x, counts(:,2), 'g', 'LineWidth', 1.2);
        plot(x, counts(:,3), 'b', 'LineWidth', 1.2);
        hold off;
        legend('Red', 'Green', 'Blue');
        title('Histogram RGB');
    end
    
    xlabel('Nilai Piksel (0-255)');
    ylabel('Frekuensi');
    xlim([0 255]);
    grid on;
end