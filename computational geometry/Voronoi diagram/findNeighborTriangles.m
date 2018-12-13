%�������ҵ�����delaunay�����ε�����������
%���˱߽�������Σ��󲿷�������
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
                        neig = neig + 1;    %��һ�����غ�
                    end
                end
            end
            if neig == 2
                triangles(i).neighbors = [triangles(i).neighbors, j];   %���������غϣ�˵��һ�����غϣ�������
                triangles(i).linindex = [triangles(i).linindex; index]; %���ڱߵ�index����һ�е�͵ڶ��е�
            end
        end
    end
end