function plot_costs(pop)

    costs=[pop.cost];
    
    plot(costs(1,:),costs(2,:),'r*','MarkerSize',8);
    xlabel('1^{st} Objective');
    ylabel('2^{nd} Objective');
    title('Non-dominated Solutions (F_{1})');
    grid on;

end