%% 使用matlab自带函数Voronoi
load seamount
figure;
plot(x(1:50), y(1:50), '.', 'Markersize', 12);
axis equal;
hold on;
grid on;
tri = delaunay(x(1:50),y(1:50));
triplot(tri, x(1:50), y(1:50));
voronoi(x(1:50), y(1:50));