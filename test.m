addpath 'code/linecodes/davidlee/'
addpath 'code/linecodes/davidlee/Canny/'
addpath 'code/linecodes/davidlee/pkline/'
addpath 'code/linecodes/derekhoiem/'
myDir='images/';
myDir2='input/';
myDir3=strcat(myDir,myDir2);
myFiles=dir(fullfile(myDir3,'*.jpg'));
for ii=1:size(myFiles,1)
    name=strcat(myDir2,myFiles(ii).name(1:end-4));
%name='input/P1020871';
    im=imread(strcat(myDir,name,'.jpg'));
    if strcmp(name,'input/01') || strcmp(name,'input/02')
        im=imresize(im,0.5);
    end
    threshold=pi/90;
    im=rgb2gray(im);
    s=size(im);
    lines=APPgetLargeConnectedEdges(im,0.025*sqrt(s(1)^2+s(2)^2));
    %figure(1), hold off, imshow(im)
    %figure(1),hold off, image([-3000,3000],[-7000,1000],ones(6000,8000,3))
    %figure(1), hold on,imshow(im)
    %figure(1), hold on, plot(lines(:, [1 2])', lines(:, [3 4])')
    %cluster=clustering(lines,3);
    %points=get_intersect(lines);
    vp=[];
    c=cell(1,3);
    for i=1:3
        temp=ransac_vp(lines,2000,threshold);
        temp=temp/temp(3);
        vp=[vp;temp];
        [lines,in]=delete_inliers(lines,temp,threshold);
        c{1,i}=in;
        min_x=floor(min(temp(1),0)-50);
        min_y=floor(min(temp(2),0)-50);
        max_x=ceil(max(temp(1),size(im,2))+50);
        max_y=ceil(max(temp(2),size(im,1))+50);
        figure(i),hold off, image([min_x,max_x],[min_y,max_y],ones(max_x-min_x,max_y-min_y,3))
        figure(i),hold on,imshow(im)
        if i==1
            color='r';
        elseif i==2
            color='g';
        else
            color='b';
        end
        figure(i),hold on, plot(in(:, [1 2])', in(:, [3 4])',color)
        figure(i),hold on, scatter(temp(:,1),temp(:,2),400,'x',color)
        %saveas(figure(i),strcat('res/',name,'_',num2str(i),'.png'))
        print(figure(i),strcat('res/',name,'_',num2str(i),'.png'),'-dpng','-r300');



    end
    min_x=floor(min(min(vp(:,1)),0)-50);
    min_y=floor(min(min(vp(:,2)),0)-50);
    max_x=ceil(max(max(vp(:,1)),size(im,2))+50);
    max_y=ceil(max(max(vp(:,2)),size(im,1))+50);
    figure(4),hold off, image([min_x,max_x],[min_y,max_y],ones(max_x-min_x,max_y-min_y,3))
    figure(4),hold on,imshow(im)
    for i=1:3
        if i==1
            color='r';
        elseif i==2
            color='g';
        else
            color='b';
        end
        figure(4),hold on, plot(c{1,i}(:, [1 2])', c{1,i}(:, [3 4])',color)
        figure(4),hold on, scatter(vp(i,1),vp(i,2),400,'x',color)
    end
    figure(4),hold on, plot(lines(:, [1 2])', lines(:, [3 4])','y')
    %saveas(figure(4),strcat('res/',name,'_',num2str(4),'.png'))
    print(figure(4),strcat('res/',name,'_',num2str(4),'.png'),'-dpng','-r300');
    figure(5),hold off, imshow(im)
    for i=1:3
        if i==1
            color='r';
        elseif i==2
            color='g';
        else
            color='b';
        end
        figure(5),hold on, plot(c{1,i}(:, [1 2])', c{1,i}(:, [3 4])',color)
    end
    figure(5),hold on, plot(lines(:, [1 2])', lines(:, [3 4])','y')
    print(figure(5),strcat('res/',name,'_',num2str(5),'.png'),'-dpng','-r300');
    
end


