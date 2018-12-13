%% Voronoiͼ�����㷨��ͨ������Voronoiͼ�Ķ�żͼ���ǵ�Ԫ������Voronoiͼ
%Author: Qiao Lu
%Date: 2018.12.10
clear; clc;
%% ���ص㼯
load seamount
x = x(1:50);
y = y(1:50);
Xmax = max(x);
Xmin = min(x);
Ymax = max(y);
Ymin = min(y);
%% �㷨ʵ��
triangles = DT2(x, y);  %�Ե㼯����delaunay�����ʷ֣��õ�delaunay�����μ�
triangles = triangleCircumCircle(triangles);    %�ṹ����������һ��ÿ�����ԲԲ��
triangles = findNeighborTriangles(triangles);   %�ҵ�ÿ�����������ڵ�������
triangles = buildLine(triangles, Xmax, Xmin, Ymax, Ymin);   %�ҵ�ÿ�����������ε����ԲԲ��,��ÿ�������������αߵ���������û�е�Ϊ�߽�

axis([Xmin-0.01 Xmax+0.01 Ymin-0.15 Ymax+0.15]);
triangles(35).neighborCircleCenters(3, :) = [];%��������ʾ�����⣬�����������ܣ���������ȥ��~~
                                               %Ӧ����buildLine��������ʾ�߼�����������
                                               %���ø��ˣ��������ɣ���Ϣһ���ٿ�
for i = 1:size(triangles, 2)
    n = size(triangles(i).neighborCircleCenters, 1);
    for j = 1:n
        hold on;
        line([triangles(i).center(1), triangles(i).neighborCircleCenters(j, 1)],...
            [triangles(i).center(2), triangles(i).neighborCircleCenters(j, 2)], 'color', 'b', 'LineWidth', 1.5);
    end
end

