function I = solution2image(M,Msol)

figure(10);
set(10,'visible','off');
set(10,'Units','pixels','pos',[1 1 200 200]);
set(10,'paperpositionmode','auto');
a = axes;
set(a,'units','nor','pos',[0 0 1 1]);

axis([0 9 0 9]);
axis ij
axis off

for k = 1:9
    for j = 1:9
        if ~M(k,j)
            text(j-0.5,k-0.5,num2str(Msol(k,j)),'fontweight','bold'...
                ,'horiz','cen','fontsize',10);
        end
    end
end
print('-dpng','testimage.png',['-r' num2str(get(0,'screenPixelsPerInch'))]);
I = im2bw(imread('testimage.png'));
delete testimage.png
close(10);