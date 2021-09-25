close all;

srcPath = 'ahte_unsupervised/ahte_ablation/moc_train_3.png';
clnPath = 'ahte_unsupervised/ahte_ablation/moc_train_inverse_3.png';
dstPath = 'ahte_unsupervised/ahte_ablation/ahte_usn_blobs_result/';
blobsPath='ahte_unsupervised/ahte_ablation/ahte_usn_blobs/';

% Evaluation Map estimation -  turn this option on for highly degraded gray scale images.
options = struct('EuclideanDist',true, 'mergeLines', true, 'EMEstimation',false,... 
    'cacheIntermediateResults', true,'blobsPath',blobsPath, 'srcPath',srcPath, 'dstPath', dstPath, 'thsLow',15,'thsHigh',Inf,'Margins', 0);
%options = merge_options(options,varargin{:});
samplesDir = dir(blobsPath);
mkdir([dstPath,'fused_polygons']); mkdir([dstPath,'polygon_labels/']);
mkdir([dstPath,'pixel_labels']);
for sampleInd = 1:length(samplesDir)
    fileName = samplesDir(sampleInd).name;
    [path,sampleName,ext] = fileparts(fileName);
    if (strcmp(ext,'.png'))
        options.sampleName = sampleName;
        options.fileName = fileName;
        I = imread(srcPath);
        bin = imread(clnPath);
        bin=bin(:,:,1);
        [result,Labels, linesMask, newLines] = FcnBlobsExtractLines(I, bin, options);
        [polygon_labels] = postProcessByBoundPolygonAndPixelsDiva( result);
        DivaSaveResults2Files(I,polygon_labels,result,fileName,dstPath);
    end
end