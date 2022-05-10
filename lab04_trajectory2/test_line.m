% Тестування траекторного керування методом фукнції
clear all
% Координати початку ЛЗШ
x_start = 1
y_start = 1

% Координати закінчення ЛЗШ
x_target = 3
y_target = 2

% Розрахунок функції лінії заданного шляху
% f(x,y)= a_line*x + b_line*y + c_line
a_line = y_target - y_start
b_line = -(x_target - x_start)
% Нормалізація рівняння лінії
n_line = norm([a_line, b_line])
a_line = a_line/n_line
b_line = b_line/n_line
% Обчислення коефіціенту зміщення
c_line = -(a_line*x_target+b_line*y_target)

% Розрахунок функції фінішної лінії (нормальної)
% f(x,y)= a_finish*x + b_finish*y + c_finish
a_finish = b_line
b_finish = -a_line
c_finish = -(a_finish*x_target+b_finish*y_target)

% Тестова точка
x_point = 3
y_point = -0.5

% Бокове зміщення - відстань до ЛЗШ
z_point = a_line*x_point + b_line*y_point + c_line
% Відстань до фінішної лінії
l_point = a_finish*x_point + b_finish*y_point + c_finish

figure(1)
plot([x_start,x_target],[y_start,y_target],'bo-','linewidth',2,...
     [x_point],[y_point],'ro');
grid on
axis equal

