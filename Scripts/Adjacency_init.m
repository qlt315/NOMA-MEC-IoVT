% Adjacency matrix generation
INF=100000000000000000000000;
J = ones(N+G*M,N+G*M)*INF;
tic;
for p=1:(N + G*M)
   for q=1:(N + G*M)
        if p<=N && q<=N  % Actual user -> Actual user
            A_sim = A;  % the grouping matrix after transfering
            % Obtain the average total latency of group of user q
            Group_p = find(A(:,p)); % Get group of user p
            Group_q = find(A(:,q)); % Get group of user q
            
            if Group_q == Group_p  % user p and user q are in the same sub-channel
                continue;
            else
                

                T_total_aver_before = 0;  % Average total latency of group of user q before transfer
                Gro_q_user = find(A(Group_q,:));  % Index of all the users in the same group as user q
                for j=1:length(Gro_q_user)
                    T_total_aver_before = T_total_aver_before + Omega(1,Gro_q_user(j))*(D_tra(1,Gro_q_user(j)) + D_pro_edge(1,Gro_q_user(j)));
                end
        
               T_total_aver_before = T_total_aver_before / (length(Gro_q_user));
                
        
        
                % Group transfer simulation   
                A_sim(Group_p,p) =0;
                A_sim(Group_q,p) = 1;
                A_sim(Group_q,q) = 0;
                Gro_q_user = find(A_sim(Group_q,:));  % Index of all the users in the same group as user q except q
                D_tra_sim = zeros(1,length(Gro_q_user));
                
                % Decoding and Power Allocation
                P = power_allocation_MM(A_sim);
             
                % Calculate SINR and TX_rate
                Tx_rate_sim = rate_calculation(A_sim,P);
                
                % Total latency of group of user q after tranfering  
                T_total_aver_after = 0;  % Average total latency of group of user q after transfer
                if isempty(Gro_q_user)
                else
                    % Transmision delay calculation
                    Ass_BS = find(Ass_matrix(:,p));   % the BS associated to group of user q (p)
                    for j=1:length(Gro_q_user)
                        D_tra_sim(1,j) = Data_size(1,Gro_q_user(j)) * 1000 / Tx_rate_sim(1,Gro_q_user(j));
                    end
                    
                    % Computing resouce allocation (CVX)
                    D_pro_edge_sim = zeros(1,length(Gro_q_user));
                    Ass_BS_q = ceil(find(A_sim(:,p))/G);  % new BS associate to user p (i.e., user q)
                    C = computing_resource_allocation(Ass_BS_q,Gro_q_user);
                    for k=1:length(Gro_q_user)
                        D_pro_edge_sim(1,k) = W_req(1,Gro_q_user(k))  / (C(1,k)* 10^(3)) ;
                    end
                    
                    for j=1:length(Gro_q_user)
                        T_total_aver_after = T_total_aver_after + Omega(1,Gro_q_user(j))*(D_tra_sim(1,j) + D_pro_edge_sim(1,j));
                    end
                    
                    T_total_aver_after = T_total_aver_after / (length(Gro_q_user));
                end
                J(p,q) = T_total_aver_after - T_total_aver_before;
                if J(p,q) == 0
                    keyboard;
                end
                    
                
            end

        elseif p>N && q<=N            % Virtul user p -> Actual user q
             % Obtain the average total latency of group of user q
            Group_p = p-N; % Get group of user p
            Group_q = find(A(:,q)); % Get group of user q
            A_sim = A;  % the grouping matrix after transfering
            if Group_q == Group_p  % user p and user q are in the same sub-channel
                continue;
            else
                Gro_q_user = find(A(Group_q,:));  % Index of all the users in the same group as user q
                T_total_aver_before = 0;  % Average total latency of group of user q before transfer
                Ass_BS_q = ceil(find(A(:,q))/G);  % BS associate to user q 
                for j=1:length(Gro_q_user)
                    T_total_aver_before = T_total_aver_before + Omega(1,Gro_q_user(j))*(D_tra(1,Gro_q_user(j)) + D_pro_edge(1,Gro_q_user(j)));
                end
        
               T_total_aver_before = T_total_aver_before / (length(Gro_q_user));
                
        
        
                % Group transfer simulation   
                A_sim(Group_q,q) = 0;
                Gro_q_user = find(A_sim(Group_q,:));  % Index of all the users in the same group as user q except q
                D_tra_sim = zeros(1,length(Gro_q_user));
               



        
                %% Decoding and Power Allocation
                P = Power_Allocation_MM(A_sim);
             
                % Calculate SINR and TX_rate
                Tx_rate_sim = rate_calculation(A_sim,P);
                
                T_total_aver_after = 0;  % Average total latency of group of user q after transfer
                if isempty(Gro_q_user)
                else  
                    % Transmision delay calculation
                    for j=1:length(Gro_q_user)
                        Ass_BS = find(Ass_matrix(:,Gro_q_user(j)));   % the BS associated to user j
                        D_tra_sim(1,j) = Data_size(1,Gro_q_user(j)) * 1000 / Tx_rate_sim(1,Gro_q_user(j));
                    end
                    
                    % Computing resouce allocation (CVX)
                    D_pro_edge_sim = zeros(1,length(Gro_q_user));
                    C = computing_resource_allocation(Ass_BS_q,Gro_q_user);
                    for k=1:length(Gro_q_user)
                        D_pro_edge_sim(1,k) = W_req(1,Gro_q_user(k))  / (C(1,k)* 10^(3)) ;
                    end
                        
                    % Total latency of group of user q after tranfering    
                    
        
                    for j=1:length(Gro_q_user)
                        T_total_aver_after = T_total_aver_after + Omega(1,Gro_q_user(j))*(D_tra_sim(1,j) + D_pro_edge_sim(1,j));
                    end
                
                
                    T_total_aver_after = T_total_aver_after / (length(Gro_q_user));
                end
                J(p,q) = T_total_aver_after - T_total_aver_before;
                if J(p,q) == 0
                    keyboard;
                end
            end


        elseif p<=N && q>N        % Actual user p -> Virtul user q
             % Obtain the average total latency of group of user q
            A_sim = A;  % the grouping matrix after transfering
            Group_p = find(A_sim(:,p)); % Get group of user p
            Group_q = q-N; % Get group of virtual user q
            
            if Group_q == Group_p  % user p and user q are in the same sub-channel
                continue;
            else
                Gro_q_user = find(A(Group_q,:));  % Index of all the users in the same group as user q
                if isempty(Gro_q_user)
                    T_total_aver_before = 0;
                else    
                    T_total_aver_before = 0;  % Average total latency of group of user q before transfer
        
                    for j=1:length(Gro_q_user)
                        T_total_aver_before = T_total_aver_before + Omega(1,Gro_q_user(j))*(D_tra(1,Gro_q_user(j)) + D_pro_edge(1,Gro_q_user(j)));
                    end
            
                    T_total_aver_before = T_total_aver_before / (length(Gro_q_user));
                end
                
        
        
                % Group transfer simulation   
                A_sim(Group_p,p) =0;
                A_sim(Group_q,p) = 1;

                Gro_q_user = find(A_sim(Group_q,:));  % Index of all the users in the same group as user q
                D_tra_sim = zeros(1,length(Gro_q_user));
                
    
                %% Decoding and Power Allocation
                P = power_allocation_MM(A_sim);
             
                % Calculate SINR and TX_rate
                Tx_rate_sim = rate_calculation(A_sim,P);
                
                % Transmision delay calculation
                T_total_aver_after = 0;  % Average total latency of group of user q after transfer
                if isempty(Gro_q_user)
                else
                    for j=1:length(Gro_q_user)
                        D_tra_sim(1,j) = Data_size(1,Gro_q_user(j)) * 1000 / Tx_rate_sim(1,Gro_q_user(j));
                    end
                
                    % Computing resouce allocation (CVX)
                    D_pro_edge_sim = zeros(1,length(Gro_q_user));
                    Ass_BS_q = ceil(find(A_sim(:,p))/G);  % new BS associate to user p
                    C = computing_resource_allocation(Ass_BS_q,Gro_q_user);
                    for k=1:length(Gro_q_user)
                        D_pro_edge_sim(1,k) = W_req(1,Gro_q_user(k))  / (C(1,k)* 10^(3)) ;
                    end
                    
                    % Total latency of group of user q after tranfering
                    
        
                    for j=1:length(Gro_q_user)
                        T_total_aver_after = T_total_aver_after + Omega(1,Gro_q_user(j))*(D_tra_sim(1,j) + D_pro_edge_sim(1,j));
                    end
            
                    T_total_aver_after = T_total_aver_after / (length(Gro_q_user));
                end
    
                J(p,q) = T_total_aver_after - T_total_aver_before;
                if J(p,q) == 0
                    keyboard;
                end
                
            end

        elseif p>N && q>N    % Virtul user p -> Virtul user q
            continue;
        end
        
    end
end
toc        
           