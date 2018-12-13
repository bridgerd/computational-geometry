%% Delaunay�����ʷ�
%Author: Qiao Lu
%Date: 2018.12.10
%Reference: https://www.cnblogs.com/zhiyishou/p/4430017.html
function triangles = DT2(x, y)
%% ���ص㼯
% x = x(1:50);
% y = y(1:50);
plot(x, y, 'r.', 'Markersize', 20);
axis equal
hold on; grid on;
%% ���쳬��������
Xmax = max(x);
Xmin = min(x);
Ymax = max(y);
Ymin = min(y);

hold on;
upPoint = [Xmin-0.01 + (Xmax+0.02 - (Xmin-0.01))/2, Ymax+0.02+0.4]; %�����������϶���
h = upPoint(2) - (Ymax+0.02);
w = upPoint(1) - (Xmin-0.01);
arc = atan(h/w);
h1 = upPoint(2) - (Ymin-0.01);
w1 = h1/arc;
leftPoint = [upPoint(1)-w1; Ymin-0.01-0.1]; %�������������¶���
rightPoint = [upPoint(1)+w1, Ymin-0.01-0.1];    %�������������¶���

%%%%%��������������%%%%%
% line([leftPoint(1), rightPoint(1)], [leftPoint(2), rightPoint(2)], 'color', 'k', 'LineWidth', 1);
% hold on;
% line([rightPoint(1), upPoint(1)], [rightPoint(2), upPoint(2)], 'color', 'k', 'LineWidth', 1);
% hold on;
% line([upPoint(1), leftPoint(1)], [upPoint(2), leftPoint(2)], 'color', 'k', 'LineWidth', 1);
%% �Ե㼯����X���С�����������
pointSet = [x, y];
pointNum = length(pointSet);
[X, I] = sort(pointSet(:, 1), 'ascend');
Y = zeros(pointNum, 1);
for i = 1:pointNum
    Y(i, 1) = pointSet(I(i), 2);
end
pointSet = [X, Y];
%% ������ʵ��
%%%%%��ʼ������ʼ��%%%%%
%�±�洢�����Σ����Ա����ڵ������λ����Բ��һ��Ϊһ�����꣬1��3�зֱ�Ϊ�����¡����¡��ϣ���һ��ΪX���ڶ���ΪY
triangleList(1).list(1, :) = leftPoint';
triangleList(1).list(2, :) = rightPoint';
triangleList(1).list(3, :) = upPoint';
%�洢��Ҫ���ӵıߣ�ÿ��Ϊһ����
%��һ��Ϊ��һ����x���꣬�ڶ���Ϊһ����y���ꣻ������Ϊ�ڶ�����x���꣬������Ϊ�ڶ�����y����
tempBuffer = [];
%�洢delaunay������
triangles.list = [];
%��ǰdelaunay��������Ŀ
DtriangleNum = 0;

[circleCenter, R] = circumcircleBuilding(triangleList(1).list); %�õ����Բ��Բ�ĺͰ뾶������Ϊ��������������
hold on;
%rectangle('Position',[circleCenter(1)-R,circleCenter(2)-R,2*R,2*R],...
%            'EdgeColor', 'b', 'Curvature',[1,1],'linewidth',1); %�������Բ
axis equal

%%%%%��������㷨��������%%%%%
for i = 1:pointNum
    triangleNum = length(triangleList);
    tempBuffer = [];
    ps = [];
    del_lists = [];
    for j = 1:triangleNum
        [circleCenter, R] = circumcircleBuilding(triangleList(j).list()); %�õ����Բ��Բ�ĺͰ뾶
        inCircle = isInCircle(pointSet(i, :), circleCenter, R);    %inCircle=1: ��Բ�ڣ�������Բ��
        if inCircle == 1
            %���õ��ڴ����������Բ�ڣ��򽫸������εĸ����ߴ���tempbuffer�������������δ�triangleList��ɾ��
            temp(1, :) = [triangleList(j).list(1, :), triangleList(j).list(2, :)];
            temp(2, :) = [triangleList(j).list(1, :), triangleList(j).list(3, :)];
            temp(3, :) = [triangleList(j).list(2, :), triangleList(j).list(3, :)];
            tempBuffer = [tempBuffer; temp];    %�õ����еı�
            del_lists = [del_lists, j]; %�õ���Բ�ڵ�����������
        else
            %���õ��ڴ����������Բ�⣬���жϸõ��Ƿ��ڸ����������Բ�Ҳ�
            inRight = isInCircleRight(circleCenter, R, pointSet(i, :));  %inRight��Ϊ1�����ʾ��Բ�Ҳ�
            if inRight == 1
                %����Բ�Ҳ࣬���ʾ��������ΪDelaunay�����Σ��ʽ��������η���triangles
                DtriangleNum = DtriangleNum + 1;
                triangles(DtriangleNum).list = triangleList(j).list;    %���������η���triangles
            end
        end
    end
    triangleList(del_lists) = [];  %�������Ϲ���������δ��б���ɾ��
    
    %��tempBuffer��Ϊ�գ����ʾ�õ�����Щ�����ε�Բ�ڡ�
    %Ҫȥ���ظ��ıߣ����ظ��ı�ȫ��ȥ���������������ظ�����Ҫ��������ȫ����ȥ����
    tempBuffer(:, 5) = 0;   %��tempBuffer�����и�ֵΪ0������û���ظ�
    %����⵽�ظ������ظ������еĵ����м�1
    if ~isempty(tempBuffer)
        for k = 1:size(tempBuffer, 1)-1
            for s = k+1:size(tempBuffer, 1)
                if isequal(tempBuffer(k, :), tempBuffer(s, :)) == 1
                    tempBuffer(k, 5) = tempBuffer(k, 5) + 1;
                    tempBuffer(s, 5) = tempBuffer(s, 5) + 1;
                end
            end
        end
    end
    %ȥ���ظ��ߣ���tempBuffer�����в�Ϊ��ıߣ�
    [rows, ~] = find(tempBuffer(:, 5) ~= 0);    %�ҵ�tempBuffer���е����в�Ϊ0����
    tempBuffer(rows, :) = [];    %ȥ�����е����в�Ϊ0����
    
    %���õ���tempBuffer��ÿ���������ӣ������µ������Σ�������triangleList��
    triangleNum = length(triangleList);
    for w = 1:size(tempBuffer, 1)
        triangleList(triangleNum+w).list(1, :) =  pointSet(i, :);
        triangleList(triangleNum+w).list(2, :) =  tempBuffer(w, 1:2);
        triangleList(triangleNum+w).list(3, :) =  tempBuffer(w, 3:4);
    end
end

%��ԭ�ο���ҳ���������������������ʵ�����У��������ɵ�delaunay������ȱ�������һ����������������
triangles = [triangles, triangleList];  

%%%%%ȥ���볬�������������ӵı�%%%%%
[~, n] = size(triangles);
del2_list = [];
for i = 1:n
    flag = 0;
    [row, ~] = find(triangles(i).list(:, 1) == leftPoint(1));
    if triangles(i).list(row, 2) == leftPoint(2)
        flag = 1;
    end
    [row, ~] = find(triangles(i).list(:, 1) == rightPoint(1));
    if triangles(i).list(row, 2) == rightPoint(2)
        flag = 1;
    end
    [row, ~] = find(triangles(i).list(:, 1) == upPoint(1));
    if triangles(i).list(row, 2) == upPoint(2)
        flag = 1;
    end

    if flag
        del2_list = [del2_list, i];
    end
end
triangles(del2_list) = [];  %ȥ����Щ������
%% �������ɵ�delaunay�����ʷ�ͼ
[~, n] = size(triangles);
del3 = [];
for i = 1:n
    for j = 1:n
        if i == j
            break;
        end
        if isequal(triangles(i).list, triangles(j).list)
            del3 = [del3, j];
        end
    end
end
triangles(del3) = [];

[~, n] = size(triangles);
for i = 1:n
    hold on;
    line([triangles(i).list(1, 1), triangles(i).list(2, 1)], [triangles(i).list(1, 2), triangles(i).list(2, 2)], 'color', 'k', 'LineWidth', 1);
    hold on;
    line([triangles(i).list(2, 1), triangles(i).list(3, 1)], [triangles(i).list(2, 2), triangles(i).list(3, 2)], 'color', 'k', 'LineWidth', 1);
    hold on;
    line([triangles(i).list(1, 1), triangles(i).list(3, 1)], [triangles(i).list(1, 2), triangles(i).list(3, 2)], 'color', 'k', 'LineWidth', 1);
end