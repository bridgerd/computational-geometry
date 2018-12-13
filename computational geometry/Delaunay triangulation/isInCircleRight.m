%本函数判断点是否在该三角形外接圆的右边，若在右边，则该三角形为delaunay三角形
%该函数输入的点（point）必须在外接圆外
%该处“点在圆右侧”表示点的x坐标比圆上任一点的x坐标都大
%圆上x坐标最大的点为圆心x坐标加上半径
function inRight = isInCircleRight(circleCenter, R, point)

inRight = false;
maxPointInCircleX = circleCenter(1) + R;    %圆上最大的x坐标值
if point(1) >= maxPointInCircleX
    inRight = true; %返回值为真，表示该点在该外接圆右侧
end