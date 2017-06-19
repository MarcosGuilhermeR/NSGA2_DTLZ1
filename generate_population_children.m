function popc = generate_population_children (pop, nPop, nCrossover, individual)
    
    
    
    popc=repmat(individual,nCrossover,1);
    for k=1: 2 : nCrossover
        
        i1=randi([1 nPop]);
        p1=pop(i1);
        
        i2=randi([1 nPop]);
        p2=pop(i2);
        
        %get children
        [x1,x2]= crossover(p1.x,p2.x);
        
        %replace children
        popc(k).x = x1;
        popc(k+1).x = x2;
        
        %get cost children
        popc(k).cost= cost_function(popc(k).x);
        popc(k+1).cost= cost_function(popc(k+1).x);
        
    end


end