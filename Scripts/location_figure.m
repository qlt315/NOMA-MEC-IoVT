% Plot the location and association of the users and BSs
% Input: Ass_matrix and Group_matrix, M=4, N=40, G=5
Num_ass = zeros(1,M);  % Calculate the number of users connect to each BS
user_group_1_1_X = [];user_group_1_1_Y = [];
user_group_1_2_X = [];user_group_1_2_Y = [];
user_group_1_3_X = [];user_group_1_3_Y = [];
user_group_1_4_X = [];user_group_1_4_Y = [];
user_group_1_5_X = [];user_group_1_5_Y = [];


user_group_2_1_X = [];user_group_2_1_Y = [];
user_group_2_2_X = [];user_group_2_2_Y = [];
user_group_2_3_X = [];user_group_2_3_Y = [];
user_group_2_4_X = [];user_group_2_4_Y = [];
user_group_2_5_X = [];user_group_2_5_Y = [];



user_group_3_1_X = [];user_group_3_1_Y = [];
user_group_3_2_X = [];user_group_3_2_Y = [];
user_group_3_3_X = [];user_group_3_3_Y = [];
user_group_3_4_X = [];user_group_3_4_Y = [];
user_group_3_5_X = [];user_group_3_5_Y = [];


user_group_4_1_X = [];user_group_4_1_Y = [];
user_group_4_2_X = [];user_group_4_2_Y = [];
user_group_4_3_X = [];user_group_4_3_Y = [];
user_group_4_4_X = [];user_group_4_4_Y = [];
user_group_4_5_X = [];user_group_4_5_Y = [];




for j=1:N
    if Ass_matrix(1,j) == 1
        Num_ass(1,1) = Num_ass(1,1) +1;
        if Group_matrix(1,j) == 1
            user_group_1_1_X = [user_group_1_1_X,User_location_X(1,j)];
            user_group_1_1_Y = [user_group_1_1_Y,User_location_Y(1,j)];
        elseif Group_matrix(2,j) == 1
            user_group_1_2_X = [user_group_1_2_X,User_location_X(1,j)];
            user_group_1_2_Y = [user_group_1_2_Y,User_location_Y(1,j)];
        elseif Group_matrix(3,j) == 1
            user_group_1_3_X = [user_group_1_3_X,User_location_X(1,j)];
            user_group_1_3_Y = [user_group_1_3_Y,User_location_Y(1,j)];
        elseif Group_matrix(4,j) == 1
            user_group_1_4_X = [user_group_1_4_X,User_location_X(1,j)];
            user_group_1_4_Y = [user_group_1_4_Y,User_location_Y(1,j)];
        else
            user_group_1_5_X = [user_group_1_5_X,User_location_X(1,j)];
            user_group_1_5_Y = [user_group_1_5_Y,User_location_Y(1,j)];
        end
        
    elseif Ass_matrix(2,j) == 1
        Num_ass(1,2) = Num_ass(1,2) +1;
        if Group_matrix(1,j) == 1
                user_group_2_1_X = [user_group_2_1_X,User_location_X(1,j)];
                user_group_2_1_Y = [user_group_2_1_Y,User_location_Y(1,j)];
            elseif Group_matrix(2,j) == 1
                user_group_2_2_X = [user_group_2_2_X,User_location_X(1,j)];
                user_group_2_2_Y = [user_group_2_2_Y,User_location_Y(1,j)];
            elseif Group_matrix(3,j) == 1
                user_group_2_3_X = [user_group_2_3_X,User_location_X(1,j)];
                user_group_2_3_Y = [user_group_2_3_Y,User_location_Y(1,j)];
            elseif Group_matrix(4,j) == 1
                user_group_2_4_X = [user_group_2_4_X,User_location_X(1,j)];
                user_group_2_4_Y = [user_group_2_4_Y,User_location_Y(1,j)];
            else
                user_group_2_5_X = [user_group_2_5_X,User_location_X(1,j)];
                user_group_2_5_Y = [user_group_2_5_Y,User_location_Y(1,j)];
        end
        
    elseif Ass_matrix(3,j) == 1
        Num_ass(1,3) = Num_ass(1,3) +1;
        if Group_matrix(1,j) == 1
                user_group_3_1_X = [user_group_3_1_X,User_location_X(1,j)];
                user_group_3_1_Y = [user_group_3_1_Y,User_location_Y(1,j)];
            elseif Group_matrix(2,j) == 1
                user_group_3_2_X = [user_group_3_2_X,User_location_X(1,j)];
                user_group_3_2_Y = [user_group_3_2_Y,User_location_Y(1,j)];
            elseif Group_matrix(3,j) == 1
                user_group_3_3_X = [user_group_3_3_X,User_location_X(1,j)];
                user_group_3_3_Y = [user_group_3_3_Y,User_location_Y(1,j)];
            elseif Group_matrix(4,j) == 1
                user_group_3_4_X = [user_group_3_4_X,User_location_X(1,j)];
                user_group_3_4_Y = [user_group_3_4_Y,User_location_Y(1,j)];
            else
                user_group_3_5_X = [user_group_3_5_X,User_location_X(1,j)];
                user_group_3_5_Y = [user_group_3_5_Y,User_location_Y(1,j)];
        end
        
    else
        Num_ass(1,4) = Num_ass(1,4) +1;
        if Group_matrix(1,j) == 1
                user_group_4_1_X = [user_group_4_1_X,User_location_X(1,j)];
                user_group_4_1_Y = [user_group_4_1_Y,User_location_Y(1,j)];
            elseif Group_matrix(2,j) == 1
                user_group_4_2_X = [user_group_4_2_X,User_location_X(1,j)];
                user_group_4_2_Y = [user_group_4_2_Y,User_location_Y(1,j)];
            elseif Group_matrix(3,j) == 1
                user_group_4_3_X = [user_group_4_3_X,User_location_X(1,j)];
                user_group_4_3_Y = [user_group_4_3_Y,User_location_Y(1,j)];
            elseif Group_matrix(4,j) == 1
                user_group_4_4_X = [user_group_4_4_X,User_location_X(1,j)];
                user_group_4_4_Y = [user_group_4_4_Y,User_location_Y(1,j)];
            else
                user_group_4_5_X = [user_group_4_5_X,User_location_X(1,j)];
                user_group_4_5_Y = [user_group_4_5_Y,User_location_Y(1,j)];
        end
             
    end
end

figure(1);
% BS location
scatter(BS_location_X(1),BS_location_Y(1),300,'k','s','filled'); hold on;
scatter(BS_location_X(2),BS_location_Y(2),300,'k','d','filled');
scatter(BS_location_X(3),BS_location_Y(3),300,'k','o','filled');
scatter(BS_location_X(4),BS_location_Y(4),300,'k','^','filled');

% User location
scatter(user_group_1_1_X,user_group_1_1_Y,55,[0 0.4470 0.7410],'s','filled');
scatter(user_group_1_2_X,user_group_1_2_Y,55,[0.8500 0.3250 0.0980],'s','filled');
scatter(user_group_1_3_X,user_group_1_3_Y,55,[0.9290 0.6940 0.1250],'s','filled');
scatter(user_group_1_4_X,user_group_1_4_Y,55,[0.4940 0.1840 0.5560],'s','filled');
scatter(user_group_1_5_X,user_group_1_5_Y,55,[0.4660 0.6740 0.1880],'s','filled');

scatter(user_group_2_1_X,user_group_2_1_Y,50,[0 0.4470 0.7410],'d','filled');
scatter(user_group_2_2_X,user_group_2_2_Y,50,[0.8500 0.3250 0.0980],'d','filled');
scatter(user_group_2_3_X,user_group_2_3_Y,50,[0.9290 0.6940 0.1250],'d','filled');
scatter(user_group_2_4_X,user_group_2_4_Y,50,[0.4940 0.1840 0.5560],'d','filled');
scatter(user_group_2_5_X,user_group_2_5_Y,50,[0.4660 0.6740 0.1880],'d','filled');

scatter(user_group_3_1_X,user_group_3_1_Y,50,[0 0.4470 0.7410],'o','filled');
scatter(user_group_3_2_X,user_group_3_2_Y,50,[0.8500 0.3250 0.0980],'o','filled');
scatter(user_group_3_3_X,user_group_3_3_Y,50,[0.9290 0.6940 0.1250],'o','filled');
scatter(user_group_3_4_X,user_group_3_4_Y,50,[0.4940 0.1840 0.5560],'o','filled');
scatter(user_group_3_5_X,user_group_3_5_Y,50,[0.4660 0.6740 0.1880],'o','filled');

scatter(user_group_4_1_X,user_group_4_1_Y,50,[0 0.4470 0.7410],'^','filled');
scatter(user_group_4_2_X,user_group_4_2_Y,50,[0.8500 0.3250 0.0980],'^','filled');
scatter(user_group_4_3_X,user_group_4_3_Y,50,[0.9290 0.6940 0.1250],'^','filled');
scatter(user_group_4_4_X,user_group_4_4_Y,50,[0.4940 0.1840 0.5560],'^','filled');
scatter(user_group_4_5_X,user_group_4_5_Y,50,[0.4660 0.6740 0.1880],'^','filled');



grid on;
set(gca,'xgrid','on','gridlinestyle','-','Gridalpha',0.5)
set(gca,'ygrid','on','gridlinestyle','-','Gridalpha',0.5)
%legend('MEC-BS m_1', "MEC-BS m_2",'MEC-BS m_3',"MEC-BS m_4","An IoVT device associate to MEC-BS m_1","An IoVT device associate to MEC-BS m_2","An IoVT device associate to MEC-BS m_3","An IoVT device associate to MEC-BS m_4",'Location','WestOutside');
set(gca,'FontName','Times New Roman','FontSize',14);
xticks(0:100:600); yticks(0:100:600);
xlabel('Distance (Km)'),ylabel('Distance (Km)');





figure(2);
yyaxis left
bar1 = bar(1:M,[C_cap_bs;zeros(1,M)]); 
ylabel('Computing Capability (Mbit/s)');
%legend(p2,"Proposed (Greedy)");
grid on;
set(gca,'xgrid','on','gridlinestyle','-','Gridalpha',0.5)
set(gca,'ygrid','on','gridlinestyle','-','Gridalpha',0.5)
yyaxis right
bar2 = bar(1:M,[zeros(1,M);Num_ass]);

ylabel('Number of IoVT Device Associated');
%legend(p3,"Proposed (Greedy)");
grid on;
set(gca,'xgrid','on','gridlinestyle','-','Gridalpha',0.5)
set(gca,'ygrid','on','gridlinestyle','-','Gridalpha',0.5)
%legend('Proposed (Bellman-Ford)', "Proposed (Greedy)");
xlabel('Index of MEC-BS');
set(gca,'FontName','Times New Roman','FontSize',14);
legend([bar1(1),bar2(1)],'Computing Capability (Mbit/s)',"Number of IoVT Device Associated");
