I=imread('hetero3.jpg');
bin = binarization(I,25,0);
options = struct('EuclideanDist',true, 'mergeLines', true, 'EMEstimation',false,... 
            'cacheIntermediateResults', false, 'thsLow',15,'thsHigh',Inf,'Margins', 0);
charRange=estimateCharsHeight(I,bin,options);
scales=charRange(1):charRange(2);
linesMask = LinesExtraction(I, charRange(1):charRange(2));

%figure
%imshow(bin)

figure
imshow(linesMask)