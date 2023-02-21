alpha_list = [1,5,10,20];

convergence_list = zeros(length(alpha_list),10);


for alpha_flag = 1:length(alpha_list)
    alpha_flag
    alpha = alpha_list(alpha_flag);
    main_Greedy;
    convergence_list(alpha_flag,:) = convergence_Greedy_list;
end

figure(1)
plot(1:10,convergence_list(1,:),"-o",'Markersize',7,'linewidth',2); hold on;
plot(1:10,convergence_list(2,:),"-d",'Markersize',7,'linewidth',2); 
plot(1:10,convergence_list(3,:),"-*",'Markersize',7,'linewidth',2); 
plot(1:10,convergence_list(4,:),"-s",'Markersize',7,'linewidth',2); 

grid on;
legend('FGSA, \alpha=0.5', "FGSA, \alpha=1",'FGSA, \alpha=5',"FGSA, \alpha=10");
xlabel('Number of Iterations'),ylabel('Weighted Average Total Delay');
set(gca,'FontName','Times New Roman','FontSize',14);
set(gca,'XTick',(1:1:10));
    
