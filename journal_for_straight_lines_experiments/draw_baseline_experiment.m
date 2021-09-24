I=imread('one_line.jpg');
bin = binarization(I,25,0);
[result,Labels, linesMask, newLines] = ExtractLines(I, bin);

[rows,cols]=size(result);
labels=unique(result);
polygon_labels=zeros(rows,cols);
for label=2:(length(labels))
        selected_label=labels(label);
        temp=(result==selected_label);
        [y, x]=find(temp);
        k=boundary(x,y,0.7);
        mask=poly2mask(x(k),y(k),rows,cols);
        polygon_labels(mask==1)=label-1;
end

labeled_image=polygon_labels;
baseline_indices=multi_baseline_extractor(labeled_image);

imshow(I);
hold all
%visboundaries(labeled_image,'LineStyle','-');
[b,l]=bwboundaries(labeled_image,'noholes');
boundary=b{1};
plot(boundary(:,2),boundary(:,1),'m','LineWidth',1);


hold all
for i=1:length(baseline_indices)
    baseline=baseline_indices(i);
    plot(baseline{1}(:,1),baseline{1}(:,2),'b*-')    

end  


legend('polygon','baseline','Location','southwest')

ax=gca;
ax.FontSize=13;
    
print(gcf, '-dpng','baseline.png','-r300');
