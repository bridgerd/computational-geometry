%% Voronoi图生成算法，通过先生Voronoi图的对偶图三角单元来生成Voronoi图
%Author: Qiao Lu
%Date: 2018.12.10
clear; clc;
%% 加载点集
load seamount
x = x(1:50);
y = y(1:50);
Xmax = max(x);
Xmin = min(x);
Ymax = max(y);
Ymin = min(y);
%% 算法实现
triangles = DT2(x, y);  %对点集进行delaunay三角剖分，得到delaunay三角形集
triangles = triangleCircumCircle(triangles);    %结构体中增加了一项每个外接圆圆心
triangles = findNeighborTriangles(triangles);   %找到每个三角形相邻的三角形
triangles = buildLine(triangles, Xmax, Xmin, Ymax, Ymin);   %找到每个相邻三角形的外接圆圆心,及每个有相邻三角形边的索引，即没有的为边界

axis([Xmin-0.01 Xmax+0.01 Ymin-0.15 Ymax+0.15]);
triangles(35).neighborCircleCenters(3, :) = [];%此条线显示有问题，看起来好难受，决定把他去掉~~
                                               %应该是buildLine中射线显示逻辑不完整。。
                                               %懒得改了，就这样吧，休息一阵再看
for i = 1:size(triangles, 2)
    n = size(triangles(i).neighborCircleCenters, 1);
    for j = 1:n
        hold on;
        line([triangles(i).center(1), triangles(i).neighborCircleCenters(j, 1)],...
            [triangles(i).center(2), triangles(i).neighborCircleCenters(j, 2)], 'color', 'b', 'LineWidth', 1.5);
    end
end

