%������ʵ�ֹ������������Բ������Ϊ�����ε��������㣬���Ϊ���ԲԲ�ĺ����Բ�뾶
function [circleCenter, R] = circumcircleBuilding(points)

circleCenter = [(points(2,1)^2+points(2,2)^2) - (points(1,1)^2+points(1,2)^2), ...
                (points(3,1)^2+points(3,2)^2) - (points(2,1)^2+points(2,2)^2)]...
                 / ([2*(points(2,1)-points(1,1)), 2*(points(3,1)-points(2,1)); ...
                    2*(points(2,2)-points(1,2)), 2*(points(3,2)-points(2,2))]);
temp = circleCenter - points(1, :);
temp = temp.^2;
R = sqrt(sum(temp));