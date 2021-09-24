close all;

%for diva hisdb.
srcPath = 'ahte_dataset/ahte_test_binary_images/';
clnPath = 'ahte_dataset/ahte_test_inverse_binary_images/';
dstPath = 'ahte_dataset/ahte_test_manual_blobs_with_em_result_10_ct_mean_merge/';
blobsPath='ahte_dataset/ahte_test_manual_blobs/';

% Evaluation Map estimation -  turn this option on for highly degraded gray scale images.
options = struct('EuclideanDist',true, 'mergeLines', true, 'EMEstimation',false,... 
    'cacheIntermediateResults', true,'blobsPath',blobsPath, 'srcPath',srcPath, 'dstPath', dstPath, 'thsLow',15,'thsHigh',Inf,'Margins', 0);
%options = merge_options(options,varargin{:});
samplesDir = dir(srcPath);
mkdir([dstPath,'fused_polygons']); mkdir([dstPath,'polygon_labels/']);
mkdir([dstPath,'pixel_labels']);
for sampleInd = 1:length(samplesDir)
    fileName = samplesDir(sampleInd).name;
    [path,sampleName,ext] = fileparts(fileName);
    if (strcmp(ext,'.png'))
        options.sampleName = sampleName;
        options.fileName = fileName;
        I = imread( [srcPath,'/',fileName]);
        bin = imread( [clnPath,'/',sampleName,'.png']);
        bin=bin(:,:,1);
        [result] = BlobsTouchSplitEmExtractLines(I, bin, options);
        [polygon_labels] = postProcessByBoundPolygonAndPixelsDiva( result);
        DivaSaveResults2Files(I,polygon_labels,result,fileName,dstPath);
        clear polygon_labels;
        clear result;

    end
end