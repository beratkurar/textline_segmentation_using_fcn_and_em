I=imread('hetero2.png');
bin = binarization(I,25,0);
options = struct('EuclideanDist',true, 'mergeLines', true, 'EMEstimation',false,... 
            'cacheIntermediateResults', false, 'thsLow',15,'thsHigh',Inf,'Margins', 0);
charRange=estimateCharsHeight(I,bin,options);

[~, ~, max_response] = filterDocument(I,charRange(1):charRange(2));

N=2.*round(charRange(2))+1;

[~, oldLines] = NiblackPreProcess(max_response, bin, 2.*round(charRange(2))+1);
linesMask = LinesExtraction(I, charRange(1):charRange(2));

figure
imshow(bin)

figure
imshow(linesMask)
print(gcf, '-dpng','comp_tree_binarization2.png','-r300');

figure
imshow(oldLines)
print(gcf, '-dpng','niblack_binarization2.png','-r300');

figure
imshow(oldLines&linesMask)
print(gcf, '-dpng','comp_tree_and_niblack_binarization.png','-r300');

