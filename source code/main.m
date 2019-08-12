%_________________________________________________________________________%
%  Grasshopper Optimization Algorithm (GOA) source codes demo 1.0         %
%                                                                         %
%  Developed in MATLAB R2016a                                             %
%                                                                         %
%  Author and programmer: Seyedali Mirjalili                              %
%                                                                         %
%         e-Mail: ali.mirjalili@gmail.com                                 %
%                 seyedali.mirjalili@griffithuni.edu.au                   %
%                                                                         %
%       Homepage: http://www.alimirjalili.com                             %
%                                                                         %
%  Main paper: S. Saremi, S. Mirjalili, A. Lewis                          %
%              Grasshopper Optimisation Algorithm: Theory and Application %
%               Advances in Engineering Software , in press,              %
%               DOI: http://dx.doi.org/10.1016/j.advengsoft.2017.01.004   %
%                                                                         %
%_________________________________________________________________________%

% You can simply define your cost in a seperate file and load its handle to fobj 
% The initial parameters that you need are:
%__________________________________________
% fobj = @YourCostFunction
% dim = number of your variables
% Max_iteration = maximum number of generations
% SearchAgents_no = number of search agents
% lb=[lb1;lb2;...;lbn] where lbn is the lower bound of variable n 
% ub=[ub1;ub2;...;ubn] where ubn is the upper bound of variable n
% If all the variables have equal lower bound you can just
% define lb and ub as two single number numbers

% To run GOA: [Best_score,Best_pos,GOA_cg_curve]=GOA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj)
%__________________________________________

clear all 
clc

SearchAgents_no=100; % Number of search agents

Function_name='F1'; % Name of the test function that can be from F1 to F23 (Table 1,2,3 in the paper)

Max_iteration=100; % Maximum numbef of iterations

% Load details of the selected benchmark function
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);

[Target_score,Target_pos,GOA_cg_curve, Trajectories,fitness_history, position_history]=GOA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);

figure('Position',[454   445   894   297])
%Draw search space
subplot(1,5,1);
func_plot(Function_name);
title('Parameter space')
xlabel('x_1');
ylabel('x_2');
zlabel([Function_name,'( x_1 , x_2 )'])
box on
axis tight

subplot(1,5,2);
hold on
for k1 = 1: size(position_history,1)
    for k2 = 1: size(position_history,2)
        plot(position_history(k1,k2,1),position_history(k1,k2,2),'.','markersize',1,'MarkerEdgeColor','k','markerfacecolor','k');
    end
end
plot(Target_pos(1),Target_pos(2),'.','markersize',10,'MarkerEdgeColor','r','markerfacecolor','r');
title('Search history (x1 and x2 only)')
xlabel('x1')
ylabel('x2')
box on
axis tight

subplot(1,5,3);
hold on
plot(Trajectories(1,:));
title('Trajectory of 1st grasshopper')
xlabel('Iteration#')
box on
axis tight

subplot(1,5,4);
hold on
plot(mean(fitness_history));
title('Average fitness of all grasshoppers')
xlabel('Iteration#')
box on
axis tight

%Draw objective space
subplot(1,5,5);
semilogy(GOA_cg_curve,'Color','r')
title('Convergence curve')
xlabel('Iteration#');
ylabel('Best score obtained so far');
box on
axis tight
set(gcf, 'position' , [39         479        1727         267]);


display(['The best solution obtained by GOA is : ', num2str(Target_pos)]);
display(['The best optimal value of the objective funciton found by GOA is : ', num2str(Target_score)]);
