close all;

%for diva hisdb.
srcPath = 'diva_dataset/crop_csg863/';
grndPath = 'diva_dataset/crop_csg863_ground/';
dstPath = 'diva_dataset/crop_csg863_clean/';

samplesDir = dir(srcPath);
for sampleInd = 1:length(samplesDir)
    fileName = samplesDir(sampleInd).name;
    [path,sampleName,ext] = fileparts(fileName);
    if (strcmp(ext,'.jpg'))
        options.sampleName = sampleName;
        options.fileName = fileName;
        g = imread( [grndPath,'/',sampleName,'.png']);
        blue=g(:,:,3);
        maintext=(blue==8 | blue==10 | blue==12);
        red=g(:,:,1);
        clean=xor(red,maintext)&maintext;
        %I = imread( [srcPath,'/',fileName]);
        %bin = binarization(I,25,0);
        %gry=rgb2gray(I);
        %bin=~imbinarize(gry,'adaptive','ForegroundPolarity','bright','Sensitivity',0.75);
        %clean=maintext_g&bin;

        imwrite(clean, [dstPath,sampleName,'.png']);
        close all;
    end
end