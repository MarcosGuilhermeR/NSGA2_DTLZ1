function pop_c = mutation_childrens (pop_c, nMutation)
    
    nPop = numel(pop_c);
    
    for k=1:nMutation
        
        i=randi([1 nPop]);
        p=pop_c(i);
        
        pop_c(k).x = mutate(p.x);
        
        pop_c(k).cost = cost_function(pop_c(k).x);
        
    end


end