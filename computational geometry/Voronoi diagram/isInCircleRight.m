%�������жϵ��Ƿ��ڸ����������Բ���ұߣ������ұߣ����������Ϊdelaunay������
%�ú�������ĵ㣨point�����������Բ��
%�ô�������Բ�Ҳࡱ��ʾ���x�����Բ����һ���x���궼��
%Բ��x�������ĵ�ΪԲ��x������ϰ뾶
function inRight = isInCircleRight(circleCenter, R, point)

inRight = false;
maxPointInCircleX = circleCenter(1) + R;    %Բ������x����ֵ
if point(1) >= maxPointInCircleX
    inRight = true; %����ֵΪ�棬��ʾ�õ��ڸ����Բ�Ҳ�
end