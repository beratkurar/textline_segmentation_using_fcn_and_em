I=imread('hetero1.png');
bin = binarization(I,25,0);
[result,Labels, linesMask, newLines] = ExtractLines(I, bin);

figure
imshow(label2rgb(result));
print(gcf, '-dpng','journal_for_straight_lines_experiments/pixel_label.png','-r300');



