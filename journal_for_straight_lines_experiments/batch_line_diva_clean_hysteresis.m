close all;

%for diva hisdb.
srcPath = 'diva_dataset/crop_cb55/';
clnPath = 'diva_dataset/crop_cb55_clean/';
dstPath = 'diva_dataset/crop_cb55_clean_result_10_hystere_mean_broken_non_gloss/';

% Evaluation Map estimation -  turn this option on for highly degraded gray scale images.
options = struct('EuclideanDist',true, 'mergeLines', false, 'EMEstimation',false,... 
    'cacheIntermediateResults', true, 'srcPath',srcPath, 'dstPath', dstPath, 'thsLow',15,'thsHigh',Inf,'Margins', 0);
%options = merge_options(options,varargin{:});
samplesDir = dir(srcPath);
mkdir([dstPath,'fused_polygons']); mkdir([dstPath,'polygon_labels/']);
mkdir([dstPath,'pixel_labels']);
for sampleInd = 1:length(samplesDir)
    fileName = samplesDir(sampleInd).name;
    [path,sampleName,ext] = fileparts(fileName);
    if (strcmp(ext,'.jpg'))
        options.sampleName = sampleName;
        options.fileName = fileName;
        I = imread( [srcPath,'/',fileName]);
        bin = imread( [clnPath,'/',sampleName,'.png']);
        bin=bin(:,:,1);
        %[result,Labels, linesMask, newLines] = ExtractLines(I, bin, options);
        charRange=estimateCharsHeight(I,bin,options);
        if (isnan(charRange(1)))
            charRange=[13,16];
        end
        if (options.cacheIntermediateResults &&...
                exist([options.dstPath,'masks/',options.sampleName,'.png'], 'file') == 2)
            linesMask = imread([dstPath,'masks/',sampleName,'.png']);
        else
            %linesMask = LinesExtraction(I, charRange(1):charRange(2));
            %[~, ~, max_response] = filterDocument(I,charRange(1):charRange(2));
            [~, ~, max_response] = filterDocument(~bin,charRange(1):charRange(2));

            N=2.*round(charRange(2))+1;
            [~, linesMask] = NiblackPreProcess(max_response, bin, 2.*round(charRange(2))+1);
        end
        [L,num] = bwlabel(bin);
        if (num<=2)
            fprintf('only one component \n')
            result=L;
            Labels=1;
            newLines=[];
        else
            [result,Labels,newLines] = PostProcessByMRF(L,num,linesMask,charRange,options);
        end
        [polygon_labels] = postProcessByBoundPolygonAndPixelsDiva( result);
        DivaSaveResults2Files(I,polygon_labels,result,fileName,dstPath);
    end
end