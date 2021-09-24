close all;

%for diva hisdb.
srcPath = 'diva_dataset/crop_csg18/';
dstPath = 'diva_dataset/crop_csg18_binary/';

% Evaluation Map estimation -  turn this option on for highly degraded gray scale images.
options = struct('EuclideanDist',true, 'mergeLines', true, 'EMEstimation',false,... 
    'cacheIntermediateResults', true, 'srcPath',srcPath, 'dstPath', dstPath, 'thsLow',15,'thsHigh',Inf,'Margins', 0);

%options = merge_options(options,varargin{:});

samplesDir = dir(srcPath);
for sampleInd = 1:length(samplesDir)
    fileName = samplesDir(sampleInd).name;
    [path,sampleName,ext] = fileparts(fileName);
    if (strcmp(ext,'.jpg'))
        options.sampleName = sampleName;
        options.fileName = fileName;
        I = imread( [srcPath,'/',fileName]);
        bin = binarization(I,25,0);

        imwrite(bin, [dstPath,sampleName,'.png']);
        close all;
    end
end