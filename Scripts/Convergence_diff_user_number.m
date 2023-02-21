user_list = [20,40,60,80];

convergence_list = zeros(length(user_list),10);


for user_flag = 1:length(user_list)
    user_flag
    N = user_list(user_flag);
    main_BellmanFord;
    convergence_list(user_flag,:) = convergence_BF_list;
end

figure(1)
plot(1:10,convergence_list(1,:),"-o",'Markersize',7,'linewidth',2); hold on;
plot(1:10,convergence_list(2,:),"-d",'Markersize',7,'linewidth',2); 
plot(1:10,convergence_list(3,:),"-*",'Markersize',7,'linewidth',2); 
plot(1:10,convergence_list(4,:),"-s",'Markersize',7,'linewidth',2); 

grid on;
legend('EBFSA, N=20', "EBFSA, N=40",'EBFSA, N=60',"EBFSA, N=80");
xlabel('Number of Iterations'),ylabel('Weighted Average Total Delay');
set(gca,'FontName','Times New Roman','FontSize',14);

    
