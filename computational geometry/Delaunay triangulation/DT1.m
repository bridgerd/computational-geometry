%% ʹ��matlab�Դ�����delaunay()ʵ��delaunay�����ʷ�
load seamount
figure;
plot(x(1:20), y(1:20), '.', 'Markersize', 12);
axis equal;
hold on;
grid on;
tri = delaunay(x(1:20),y(1:20));
triplot(tri, x(1:20), y(1:20));