%% Delaunay三角剖分
%Author: Qiao Lu
%Date: 2018.12.10
%Reference: https://www.cnblogs.com/zhiyishou/p/4430017.html
function triangles = DT2(x, y)
%% 加载点集
% x = x(1:50);
% y = y(1:50);
plot(x, y, 'r.', 'Markersize', 20);
axis equal
hold on; grid on;
%% 构造超级三角形
Xmax = max(x);
Xmin = min(x);
Ymax = max(y);
Ymin = min(y);

hold on;
upPoint = [Xmin-0.01 + (Xmax+0.02 - (Xmin-0.01))/2, Ymax+0.02+0.4]; %超级三角形上顶点
h = upPoint(2) - (Ymax+0.02);
w = upPoint(1) - (Xmin-0.01);
arc = atan(h/w);
h1 = upPoint(2) - (Ymin-0.01);
w1 = h1/arc;
leftPoint = [upPoint(1)-w1; Ymin-0.01-0.1]; %超级三角形左下顶点
rightPoint = [upPoint(1)+w1, Ymin-0.01-0.1];    %超级三角形右下顶点

%%%%%画出超级三角形%%%%%
% line([leftPoint(1), rightPoint(1)], [leftPoint(2), rightPoint(2)], 'color', 'k', 'LineWidth', 1);
% hold on;
% line([rightPoint(1), upPoint(1)], [rightPoint(2), upPoint(2)], 'color', 'k', 'LineWidth', 1);
% hold on;
% line([upPoint(1), leftPoint(1)], [upPoint(2), leftPoint(2)], 'color', 'k', 'LineWidth', 1);
%% 对点集按照X轴从小到大进行排序
pointSet = [x, y];
pointNum = length(pointSet);
[X, I] = sort(pointSet(:, 1), 'ascend');
Y = zeros(pointNum, 1);
for i = 1:pointNum
    Y(i, 1) = pointSet(I(i), 2);
end
pointSet = [X, Y];
%% 逐点插入实现
%%%%%开始变量初始化%%%%%
%下表存储三角形，即对本表内的三角形画外接圆，一行为一个坐标，1至3行分别为：左下、右下、上，第一列为X，第二列为Y
triangleList(1).list(1, :) = leftPoint';
triangleList(1).list(2, :) = rightPoint';
triangleList(1).list(3, :) = upPoint';
%存储将要连接的边，每行为一条边
%第一列为第一个点x坐标，第二列为一个点y坐标；第三列为第二个点x坐标，第四列为第二个点y坐标
tempBuffer = [];
%存储delaunay三角形
triangles.list = [];
%当前delaunay三角形数目
DtriangleNum = 0;

[circleCenter, R] = circumcircleBuilding(triangleList(1).list); %得到外接圆的圆心和半径，输入为三角形三个顶点
hold on;
%rectangle('Position',[circleCenter(1)-R,circleCenter(2)-R,2*R,2*R],...
%            'EdgeColor', 'b', 'Curvature',[1,1],'linewidth',1); %画出外接圆
axis equal

%%%%%进入插入算法迭代过程%%%%%
for i = 1:pointNum
    triangleNum = length(triangleList);
    tempBuffer = [];
    ps = [];
    del_lists = [];
    for j = 1:triangleNum
        [circleCenter, R] = circumcircleBuilding(triangleList(j).list()); %得到外接圆的圆心和半径
        inCircle = isInCircle(pointSet(i, :), circleCenter, R);    %inCircle=1: 在圆内；否则不再圆内
        if inCircle == 1
            %若该点在此三角形外接圆内，则将该三角形的各条边存入tempbuffer，并将该三角形从triangleList中删除
            temp(1, :) = [triangleList(j).list(1, :), triangleList(j).list(2, :)];
            temp(2, :) = [triangleList(j).list(1, :), triangleList(j).list(3, :)];
            temp(3, :) = [triangleList(j).list(2, :), triangleList(j).list(3, :)];
            tempBuffer = [tempBuffer; temp];    %得到所有的边
            del_lists = [del_lists, j]; %得到在圆内的三角形索引
        else
            %若该点在此三角形外接圆外，则判断该点是否在该三角形外接圆右侧
            inRight = isInCircleRight(circleCenter, R, pointSet(i, :));  %inRight若为1，则表示在圆右侧
            if inRight == 1
                %若在圆右侧，则表示该三角形为Delaunay三角形，故将该三角形放入triangles
                DtriangleNum = DtriangleNum + 1;
                triangles(DtriangleNum).list = triangleList(j).list;    %将该三角形放入triangles
            end
        end
    end
    triangleList(del_lists) = [];  %将不符合规则的三角形从列表中删除
    
    %若tempBuffer不为空，则表示该点在有些三角形的圆内。
    %要去掉重复的边（将重复的边全部去掉，即若两条边重复，则要将两条边全部都去掉）
    tempBuffer(:, 5) = 0;   %将tempBuffer第五列赋值为0，代表没有重复
    %若检测到重复，将重复的两行的第五列加1
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
    %去掉重复边（即tempBuffer第五列不为零的边）
    [rows, ~] = find(tempBuffer(:, 5) ~= 0);    %找到tempBuffer所有第五列不为0的行
    tempBuffer(rows, :) = [];    %去掉所有第五列不为0的行
    
    %将该点与tempBuffer的每条边相连接，构成新的三角形，并放入triangleList中
    triangleNum = length(triangleList);
    for w = 1:size(tempBuffer, 1)
        triangleList(triangleNum+w).list(1, :) =  pointSet(i, :);
        triangleList(triangleNum+w).list(2, :) =  tempBuffer(w, 1:2);
        triangleList(triangleNum+w).list(3, :) =  tempBuffer(w, 3:4);
    end
end

%在原参考网页中下面这个表述，但经过实际运行，发现生成的delaunay三角形缺少与最后一个点相连的三角形
triangles = [triangles, triangleList];  

%%%%%去掉与超级三角形相连接的边%%%%%
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
triangles(del2_list) = [];  %去掉这些三角形
%% 画出生成的delaunay三角剖分图
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