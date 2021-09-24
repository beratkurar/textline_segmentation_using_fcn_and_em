function [lines] = matlab_niblack(max_response, bin,N )

im = double(max_response);
localSum=filter2(ones(N),im);
localNum=filter2(ones(N),im*0+1);
localMean=localSum./(localNum);
localMean(isnan(localMean))=0;

localStd = stdfilt(im,ones(N)); 

ppProcess = ((im-localMean)./(localStd))*10;

lines=niblack(ppProcess, [100 100], -0.2, 0);
%lines = imreconstruct(bin & lines, lines);
[Lines,~] = bwlabel(lines);
figure; imshow(imfuse(bin,label2rgb(Lines),'blend'));

end

