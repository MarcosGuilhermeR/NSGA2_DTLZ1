clc;
clear;
close all;

nVar = 1;           %Number of Decision Variables
varSize=[1 nVar];   % Size of Decision Variables Matrix

%interval
varMin = -15;
varMax = 17;

MaxIt=1000;         % Maximum Number of Iterations

nPop=20;            % Population Size

pCrossover=1.0; %100%                   % Crossover Percentage
nCrossover=2*round(pCrossover*nPop/2);  % Number of Parnets (Offsprings)

pMutation=0.1; %10%                     % Mutation Percentage
nMutation=round(pMutation*nPop);        % Number of Mutants

z =[0.0                     1.0
    0.0019057598985027      0.9145957398892804
    0.007973141625871335    0.8293882416385395
    0.018787052710227268    0.7446553127731871
    0.03500931008842547     0.6607938102040649
    0.05736050382937567     0.5783594440001696
    0.08657317003036984     0.49810679025878146
    0.12330287412986476     0.42101269441818806
    0.16799383482414626     0.34825281517429063
    0.22072451787020958     0.28109795828345635
    0.28109806402660525     0.22072442416826693
    0.34825293326546103     0.16799375280472675
    0.42101282468397955     0.12330280363308306
    0.4981069182809522      0.08657311665811863
    0.5783595824126606      0.05736046023979017
    0.6607939586249912      0.03500927592559855
    0.7446554535516892      0.018787030349399776
    0.8293883906937969      0.007973127011407639
    0.9145958968735524      0.0019057527325288105
    1.0                     0.0];

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
        
        if nit == 1 || nit == 25 || nit == 200 || nit == 500 || nit == 1000
%             DESCOMENTAR
%             disp(nit)
%             disp([pop.cost]');
            
            if nit == 1000
                a = [pop.cost]';
                igd = calculate_IGD (z, a);
                if igd > maior_igd
                    maior_igd = igd;
                end
                
                if igd < menor_igd
                    menor_igd = igd;
                end
                
                soma_igd = soma_igd + igd;
            end
        end
        % Plot F1 Costs DESCOMENTAR
%         figure(1);
%         plot_costs(pop);
%         pause(0.01);
        
        nit = nit + 1;
        
        
    end
    disp (t);
end
media_igd = soma_igd / 20;
disp(['Menor IGD: ', num2str(menor_igd), ' IGD Médio: ', num2str(media_igd), ' Maior IGD: ',num2str(maior_igd)]);
