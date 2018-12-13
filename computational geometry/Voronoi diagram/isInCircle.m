function inCircle = isInCircle(point, circleCenter, R)

inCircle = false;

temp = point - circleCenter;
temp = temp.^2;
distance = sqrt(sum(temp));
if distance <= R
    inCircle = true;
end