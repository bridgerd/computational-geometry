%本函数实现构造三角形外接圆，输入为三角形的三个顶点，输出为外接圆圆心和外接圆半径
function [circleCenter, R] = circumcircleBuilding(points)

circleCenter = [(points(2,1)^2+points(2,2)^2) - (points(1,1)^2+points(1,2)^2), ...
                (points(3,1)^2+points(3,2)^2) - (points(2,1)^2+points(2,2)^2)]...
                 / ([2*(points(2,1)-points(1,1)), 2*(points(3,1)-points(2,1)); ...
                    2*(points(2,2)-points(1,2)), 2*(points(3,2)-points(2,2))]);
temp = circleCenter - points(1, :);
temp = temp.^2;
R = sqrt(sum(temp));