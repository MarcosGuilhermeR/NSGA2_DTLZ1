clc;
clear;
close all;

nVar = 7;           %Number of Decision Variables
varSize=[1 nVar];   % Size of Decision Variables Matrix

%interval
varMin = 0;
varMax = 1;

MaxIt=400;         % Maximum Number of Iterations

nPop=10;            % Population Size

pCrossover=1.0; %100%                   % Crossover Percentage
nCrossover=2*round(pCrossover*nPop/2);  % Number of Parnets (Offsprings)

pMutation=0.1; %10%                     % Mutation Percentage
nMutation=round(pMutation*nPop);        % Number of Mutants

z =[1       0       0
    0       1       0
    0       0       1
    0.33    0.33    0.33
    0.33    0.66    0
    0.33    0       0.66
    0.66    0.33    0
    0       0.33    0.66
    0       0.66    0.33
    0.66    0       0.33];

soma_igd = 0;
menor_igd = inf;
maior_igd = 0;
for t=1: 20
    %Definition individual
    individual.x=[];
    individual.cost=[];
    individual.rank=[];
    individual.dominationSet=[];
    individual.dominatedCount=[];
    individual.crowdingDistance=[];
    
    %Create clean population
    pop=repmat(individual,nPop,1);
    
    %Generate initial population
    for i=1:nPop
        
        pop(i).x=unifrnd(varMin,varMax,varSize);
        pop(i).cost= cost_function(pop(i).x);
    end
    
    nit = 0;
    while nit <= MaxIt
        %Crossover
        pop_c = generate_population_children (pop, nPop, nCrossover, individual);
        
        %mutation
        pop_c = mutation_childrens (pop_c, nMutation);
        
        %merge
        pop = [pop; pop_c];
        
        %fast_non_dominated_sort
        [pop, F]=fast_non_dominated_sort(pop);
        
        
        %Print Fronts
        %     nf = numel(F);
        %
        %     for i=1: nf
        %         fprintf('Fronteira %i',i); disp(F{i})
        %     end
        
        %calculate crowding distance
        pop = crowding_distance(pop, F);
        
        %main loop
        i=1;
        popn = [];
        
        np = 0;
        nf = numel(F{1});
        while (np + nf <= nPop)
            
            popn = [popn; pop([F{i}])];
            
            i= i + 1;
            
            np = numel(popn);
            nf = numel(F{i});
        end
        
        % Sort Based on Crowding Distance
        popr = pop(F{i});
        [~, CDSO]=sort([popr.crowdingDistance],'descend');
        
        %"Truncating"
        popr = popr(CDSO);
        popn=[popn; popr(1: nPop-np)];
        
        pop = popn;
        
        
        
        %fast_non_dominated_sort
        %[~, F]=fast_non_dominated_sort(pop);
        
        % Show Iteration Information
        %disp(['Iteration ' num2str(nit) ': Number of F1 Members = ' num2str(numel(F{1}))]);
        
%        if nit == 1 || nit == 25 || nit == 200 || nit == 500 || nit == 1000
%             DESCOMENTAR
%             disp(nit)
%             disp([pop.cost]');
            
            if nit == 400
                a = [pop.cost]';
                igd = calculate_IGD (z, a);
                disp (['T: ',num2str(t),sprintf('\t'),'IGD: ', num2str(igd)]);
                if igd > maior_igd
                    maior_igd = igd;
                end
                
                if igd < menor_igd
                    menor_igd = igd;
                end
                
                soma_igd = soma_igd + igd;
            end
%        end
        % Plot F1 Costs DESCOMENTAR
%         figure(1);
%         plot_costs(pop);
%         pause(0.01);
        
        nit = nit + 1;
        
        
    end
end
media_igd = soma_igd / t;
disp(['Menor IGD: ', num2str(menor_igd),sprintf('\t'), 'IGD Médio: ', num2str(media_igd),sprintf('\t'), 'Maior IGD: ',num2str(maior_igd)]);
