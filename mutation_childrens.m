function pop_c = mutation_childrens (pop_c, nMutation)
    
    nPop = numel(pop_c);
    
    for k=1:nMutation
        
        i=randi([1 nPop]);
        p=pop_c(i);
        
        pop_c(i).x = mutate(p.x);
        
        pop_c(i).cost = cost_function(pop_c(i).x);
        
    end


end