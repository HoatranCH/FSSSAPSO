% HSSAPSO main function
% Le Xuan Thang
clc
clear
close all
poolobj = parpool;
%% Parameters
CostFunction=@(x) one6_Aim_between_pin_and_rigid(x);
Max_iter = 100; % Max Iterations
nPop = 20; % Number of variables
Boundary=[1.90E11 2.2E11
    1e11 2e11
    1e11 2e11
    8E4 9E8
    8E4 9E8
    1e11 2e11
    1e11 2e11];
nVar = length(Boundary);
VarMax=Boundary(:,2);
VarMin=Boundary(:,1);
%Get pwd
Path_dir = pwd;


% For standard and best value in 30 times run the function
% input--
Time2run = 30; % times to run the function
A = zeros(Time2run,1); % A = X*1; store the value of Best fitness for X times to run
B = zeros(Time2run,Max_iter); % A = X*max_iter; store the value of Best fitness for X times to run
% end input--
tic;
parfor i_times = 1 : Time2run
    
    [GlobalBest_Cost,GlobalBest_Position,BestCosts]=...
        HSSAPSO_NamO2(nPop,Max_iter,VarMin,VarMax,nVar,CostFunction);
    
    A(i_times,1) = GlobalBest_Cost;
    B(i_times,:) = BestCosts;
end
% Time caculate
time = toc;
disp(['Time for running is: ' num2str(time) ' s']);

% Get best value of fitness
[Best_A,No_A] = min(A);
% Best time
Converage_curve_best = B(No_A,:);
% Average of Best value
Aver_A = mean(A);
% Standard deviation
STD_A = std(A);
% Standard errors of mean - SEM
SEM_A = STD_A / sqrt(length(A));

% fprintf(['\n Function F' num2str(function_i) '\n' ...
%     'G_Best = ' num2str(Best_A) '\n'...
%     'Average_Best = ' num2str(Aver_A) '\n'...
%     'STD =  ' num2str(STD_A) '\n'...
%     'SEM = ' num2str(SEM_A) '\n']);
% 
% % Store the results
% Results_Best_of_Function(function_i,1) = Best_A;
% Results_Converage_curve_best(function_i,:) = Converage_curve_best;
% Results_Average_of_Function(function_i,1) = Aver_A;
% Results_STD_of_Function(function_i,1) = STD_A;
% Results_SEM_of_Function(function_i,1) = SEM_A;

%% Results
figure();
semilogy(Converage_curve_best(1:1:end),'-b','LineWidth',1);
title('HSSAPSO NamO Bridge ')
xlabel('Iterations');
ylabel('Best Cost')
grid on;

delete(poolobj)
% save
save('NamOBridge_data_HSSAPSO.mat')

% command = pwd;
% cd(Path_dir)
% eval(['cd ' '.\Figure']);
% % save figure
% saveas(figure(),'HSSAPSO_NamOBridge.fig');
% close all
