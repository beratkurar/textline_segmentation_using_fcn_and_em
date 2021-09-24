I=imread('hetero1.png');
bin = binarization(I,25,0);
options = struct('EuclideanDist',true, 'mergeLines', true, 'EMEstimation',false,... 
            'cacheIntermediateResults', false, 'thsLow',15,'thsHigh',Inf,'Margins', 0);
charRange=estimateCharsHeight(I,bin,options);

[~, ~, max_response] = filterDocument(I,charRange(1):charRange(2));
N=2.*round(charRange(2))+1;
oldLines =matlab_niblack(max_response, bin,N);

figure
imshow(oldLines)
print(gcf, '-dpng','niblack_binarization2.png','-r300');

