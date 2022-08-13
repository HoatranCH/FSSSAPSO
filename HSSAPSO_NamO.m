function [GlobalBest_Cost,GlobalBest_Position,BestCosts]=...
    HSSAPSO_NamO(nPop,Max_iter,VarMin,VarMax,nVar,CostFunction)

VelMax = 0.3*(VarMax-VarMin);
VelMin = -VelMax;

c1_pso = 2;
c2_pso = 2;
VarSize=[1 nVar];
w=1;
wdamp=0.99;


BestCosts = zeros(1,Max_iter);

%Initialize the positions of salps
Salp_Positions = zeros (nPop,nVar);
Salp_Velocity = zeros (nPop,nVar);


GlobalBest_Position = zeros(1,nVar);
GlobalBest_Cost = inf;

Salp_Cost = zeros(nPop,1);
Salp_Best_Position = zeros(nPop,nVar);
Salp_Best_Cost = zeros(nPop,1);

%calculate the fitness of initial salps
for i=1:size(Salp_Positions,1)
    
    Salp_Positions(i,:) = unifrnd(VarMin(:,1),VarMax(:,1));
    Salp_Velocity(i,:) = unifrnd(VelMin(:,1),VelMax(:,1));
    
    
    Salp_Cost(i,1)=CostFunction(Salp_Positions(i,:));
    
    Salp_Best_Position(i,:) = Salp_Positions(i,:);
    Salp_Best_Cost(i,1) = Salp_Cost(i,1);
    
    if Salp_Best_Cost(i,1) < GlobalBest_Cost
        GlobalBest_Position = Salp_Best_Position(i,:);
        GlobalBest_Cost = Salp_Best_Cost(i,1);
    end
    
end

%Main loop
it=2; % start from the second iteration since the first iteration was dedicated to calculating the fitness of salps

while it<Max_iter+1
    
    c1 = 2*exp(-(4*it/Max_iter)^2); % Eq. (3.2) in the paper
    
    for i=1:size(Salp_Positions,1)
        
        if i<=nPop*4/10
            
            c2=rand(nVar,1);
            c3=unifrnd(-1,1,1,1);
            %% % Eq. (3.1) in the paper %%%%%%%%%%%%%%
            if c3 > 0.618
                Salp_Positions(i,:) = GlobalBest_Position(:)...
                    +c1.*((VarMax(:,1)-VarMin(:,1)).*c2(:,1)...
                    +VarMin(:,1));
                
            elseif c3 < -0.618
                Salp_Positions(i,:) = GlobalBest_Position(:)...
                    -c1.*((VarMax(:,1)-VarMin(:,1)).*c2(:,1)...
                    +VarMin(:,1));
            else
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %% PSO
                % Update Velocity
                Salp_Velocity(i,:) = w*Salp_Velocity(i,:) ...
                    + c1_pso * rand(VarSize).*(Salp_Best_Position(i,:) - Salp_Positions(i,:)) ...
                    + c2_pso * rand(VarSize).*(GlobalBest_Position - Salp_Positions(i,:));
                
                % Apply limits Velocity
                    Salp_Velocity(i,:)=max(Salp_Velocity(i,:),VelMin(:,1)');
                    Salp_Velocity(i,:)=min(Salp_Velocity(i,:),VelMax(:,1)');
                
                % Update Position
                Salp_Positions(i,:) = Salp_Positions(i,:) + Salp_Velocity(i,:);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            end
            
            
        elseif i>nPop*4/10 && i<=nPop*7/10
            point1 = Salp_Positions(i-1,:);
            point2 = Salp_Positions(i,:);
            Salp_Positions(i,:)=(point2+point1)/2 ; % % Eq. (3.4) in the paper
            
        else
            point1 = Salp_Positions(i-1,:);
            point2 = Salp_Positions(i,:);
            Salp_Positions(i,:)=w*(point2+c1*point1)/2 ; % % Eq. (3.4) in the paper
        end    
        
        %Control Boundary
        Salp_Positions(i,:)=max(Salp_Positions(i,:),VarMin(:,1)');
        Salp_Positions(i,:)=min(Salp_Positions(i,:),VarMax(:,1)');
        
        Salp_Cost(i,1) = CostFunction(Salp_Positions(i,:));
        if Salp_Cost(i,1) < Salp_Best_Cost(i,1)
            Salp_Best_Position(i,:) = Salp_Positions(i,:);
            Salp_Best_Cost(i,1) = Salp_Cost(i,1);
            if Salp_Best_Cost(i,1) < GlobalBest_Cost
                %Use it when you want to take position of function have results equal to 0
                GlobalBest_Position = Salp_Positions(i,:);
                GlobalBest_Cost = Salp_Cost(i,1);
            end
        end
    end
    
    w = w * wdamp;
    BestCosts(it)=GlobalBest_Cost;
    disp(['Iterations' num2str(it) '  Best Cost = ' num2str(GlobalBest_Cost)]);
    it = it + 1;
   
end
