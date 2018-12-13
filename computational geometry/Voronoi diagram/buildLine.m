%本函数实现将相邻三角形外接圆圆心相连
%对于没有外接圆的边，标记其中垂线射线(端点为接圆圆心)
function triangles = buildLine(triangles, Xmax, Xmin, Ymax, Ymin)

Xmid = Xmin + (Xmax-Xmin)/2;
Ymid = Ymin + (Ymax-Ymin)/2;
[~, n] = size(triangles);
for i = 1:n
    triangles(i).neighborCircleCenters = [];
    if size(triangles(i).neighbors, 2) ~= 3
        if size(triangles(i).neighbors, 2) == 1
            center = triangleCircumCircle(triangles(triangles(i).neighbors(1)));
            center = center(1).center;
            triangles(i).neighborCircleCenters = [triangles(i).neighborCircleCenters; center];
            %下面为中垂线射线
            tbl = tabulate(triangles(i).linindex(:));
            temp = find(tbl(:, 2) == 0);
            bian = [tbl(temp(1)), tbl(2, 1); tbl(temp(1)), tbl(3, 1)];
            for k = 1:2
                x11 = triangles(i).list(bian(k, 1), 1);
                x21 = triangles(i).list(bian(k, 2), 1);
                y11 = triangles(i).list(bian(k, 1), 2);
                y21 = triangles(i).list(bian(k, 2), 2);
                if x11 < x21
                    x1 = x11 + (x21-x11)/2;
                    if y11 < y22
                        y1 = y11 + (y21-y11)/2;
                    else
                        y1 = y21 + (y11-y21)/2;
                    end
                else
                    x1 = x21 + (x11-x21)/2;
                    if y11 < y21
                        y1 = y11 + (y21-y11)/2;
                    else
                        y1= y21 + (y11-y21)/2;
                    end
                end
                
                x2 = triangles(i).center(1);
                y2 = triangles(i).center(2);
                
                     if abs(x1 - x2) < 0.0000001
                    x = x1;
                    if y1 > Ymid
                        y = y1 + 1;
                    else
                        y = y1 - 1;
                    end
                else
                    if x1 > Xmid
                        x = x1 + 1;
                        y = (x-x1) / (x1-x2) * (y1-y2) + y1;
                    else
                        x = x1 - 1;
                        y = (x-x1) / (x1-x2) * (y1-y2) + y1;
                    end
                end
                
                triangles(i).neighborCircleCenters = [triangles(i).neighborCircleCenters; [x, y]];
            end
        elseif size(triangles(i).neighbors, 2) == 2
            for j = 1:2
                center = triangleCircumCircle(triangles(triangles(i).neighbors(j)));
                center = center(1).center;
                triangles(i).neighborCircleCenters = [triangles(i).neighborCircleCenters; center];
            end
                %下面为中垂线射线
                tbl = tabulate(triangles(i).linindex(:));
                temp = find(tbl(:, 2) == 1);
                bian = [tbl(temp(1), 1), tbl(temp(2), 1)];
                x11 = triangles(i).list(bian(1), 1);
                x21 = triangles(i).list(bian(2), 1);
                y11 = triangles(i).list(bian(1), 2);
                y21 = triangles(i).list(bian(2), 2);
                if x11 < x21
                    x1 = x11 + (x21-x11)/2;
                    if y11 < y22
                        y1 = y11 + (y21-y11)/2;
                    else
                        y1 = y21 + (y11-y21)/2;
                    end
                else
                    x1 = x21 + (x11-x21)/2;
                    if y11 < y21
                        y1 = y11 + (y21-y11)/2;
                    else
                        y1= y21 + (y11-y21)/2;
                    end
                end
                %%%求解析式
                x2 = triangles(i).center(1);
                y2 = triangles(i).center(2);
                
                if abs(x1 - x2) < 0.0000001
                    if abs(y1 - y2) < 0.00001
                        x = x1;
                        y = y1;
                    else
                        x = x1;
                        if y1 > Ymid
                            y = y1 + 1;
                        else
                            y = y1 - 1;
                        end
                    end
                else
                    if abs(x1 - Xmid) < 0.0001
                        
                    else
                        if x1 > Xmid
                            x = x1 + 1;
                            y = (x-x1) / (x1-x2) * (y1-y2) + y1;
                        else
                            x = x1 - 1;
                            y = (x-x1) / (x1-x2) * (y1-y2) + y1;
                        end
                    end
                end
                    
                triangles(i).neighborCircleCenters = [triangles(i).neighborCircleCenters; [x, y]];
        end
    else
        for j = 1:3
            center = triangleCircumCircle(triangles(triangles(i).neighbors(j)));
            center = center(1).center;
            triangles(i).neighborCircleCenters = [triangles(i).neighborCircleCenters; center];
        end
    end
end