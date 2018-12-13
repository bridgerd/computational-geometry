%本函数找到所有delaunay三角形的相邻三角形
%除了边界的三角形，大部分由三个
function triangles = findNeighborTriangles(triangles)

[~, n] = size(triangles);
for i = 1:n
    triangles(i).neighbors = [];
    triangles(i).linindex = [];
    for j = 1:n
        if i ~= j
            neig = 0;
            index = [];
            for k = 1:3
                for s = 1:3
                    if triangles(i).list(k, 1) == triangles(j).list(s, 1)...
                            && triangles(i).list(k, 2) == triangles(j).list(s, 2)
                        index = [index, k];
                        neig = neig + 1;    %有一个点重合
                    end
                end
            end
            if neig == 2
                triangles(i).neighbors = [triangles(i).neighbors, j];   %有两个点重合，说明一条边重合，即相邻
                triangles(i).linindex = [triangles(i).linindex; index]; %相邻边的index，第一列点和第二列点
            end
        end
    end
end