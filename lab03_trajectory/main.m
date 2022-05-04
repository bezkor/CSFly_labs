%
clear classes
global disturbance


% Формування польотного плану
flight_plan_x=[0 250 750 1250 1500]
flight_plan_y=[0 0 500 0 0]

tflight=[0:1:800];
start_pos=[flight_plan_x(1),flight_plan_y(1),0];

flight_plan=zeros(1,4);
for i=1:length(flight_plan_x)-1,
  flight_plan(i,:)=[flight_plan_x(i),...
                    flight_plan_y(i),...
                    flight_plan_x(i+1),...
                    flight_plan_y(i+1)];
end;

% Модель вітрових збурень
% (1) - складова збурення вздовж осі x
% (2) - складова збурення вздовж осі y
% (3) - моментра складова збурення = 0
disturbance = @(t) [0,0,0]';

% Польот на ППМ
sim_model_direct=@(t,x) model_direct(t,x,flight_plan,disturbance)
[t,y_direct]=ode45(sim_model_direct,tflight,start_pos);

% Польот за ЛЗШ
sim_model_angle=@(t,x) model_angle(t,x,flight_plan,disturbance)
[t,y_angle]=ode45(sim_model_angle,tflight,start_pos);

% Виконати коррекцію польотного плану:
% - розрахувати мінімальний радіус повороту
% - розрахувати упередження виконання маневру
% - провести симуляцію за скорегованим планом польоту
% - порівняти результати симуляції

% Візуалізація виконання польотного плану
figure(1)
plot(flight_plan_x,flight_plan_y,'b.--','LineWidth',1,...
     y_direct(:,1),y_direct(:,2),'r-','LineWidth',2,...
     y_angle(:,1),y_angle(:,2),'g-','LineWidth',2);
axis equal
grid on
legend('План польоту','Польот на ППМ','Польот за ЛЗШ');

