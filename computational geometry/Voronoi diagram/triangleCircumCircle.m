%本函数对实现对三角形外接圆圆心的计算
function triangles = triangleCircumCircle(triangles)

%a=((y2-y1)*(y3*y3-y1*y1+x3*x3-x1*x1)-(y3-y1)*(y2*y2-y1*y1+x2*x2-x1*x1))/(2.0*((x3-x1)*(y2-y1)-(x2-x1)*(y3-y1)));
%b=((x2-x1)*(x3*x3-x1*x1+y3*y3-y1*y1)-(x3-x1)*(x2*x2-x1*x1+y2*y2-y1*y1))/(2.0*((y3-y1)*(x2-x1)-(y2-y1)*(x3-x1)));

[~, n] = size(triangles);
for i = 1:n
    x1 = triangles(i).list(1, 1);
    x2 = triangles(i).list(2, 1);
    x3 = triangles(i).list(3, 1);
    y1 = triangles(i).list(1, 2);
    y2 = triangles(i).list(2, 2);
    y3 = triangles(i).list(3, 2);
    triangles(i).center(1) = ((y2-y1)*(y3*y3-y1*y1+x3*x3-x1*x1)-(y3-y1)*(y2*y2-y1*y1+x2*x2-x1*x1))...
                                /(2.0*((x3-x1)*(y2-y1)-(x2-x1)*(y3-y1)));
    triangles(i).center(2) = ((x2-x1)*(x3*x3-x1*x1+y3*y3-y1*y1)-(x3-x1)*(x2*x2-x1*x1+y2*y2-y1*y1))...
                                /(2.0*((y3-y1)*(x2-x1)-(y2-y1)*(x3-x1)));
end