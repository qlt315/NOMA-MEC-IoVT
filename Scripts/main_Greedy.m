convergence_Greedy_list = zeros(1,10);
iteration_num = 0;
alpha = 5;
cvx_solver sedumi
% Pamameters Initialization
System_init;


% SIC Decoding and Power Allocaton
P = power_allocation_MM(A);

% SINR and TX rate calculation
Tx_rate = rate_calculation(A,P);

% GF generation  GF -> size:[G*M,N] 
% GF(i,j) represents the total latency of user j when user j on the
% subchannel i; GF(i,j)=0 means user j is not on the sub-channel i
Graph_init;

% Adjacency matrix generation  J -> size:[M*G+N,M*G+N]
% J(i,j) means if move user i to the sub-channel of user j and remove user
% j from its current sub-channel, the variation of total latency
% of the sub-channel of user j
Adjacency_init;  

% Negative ring searching and update grouping matrix B by greedy
    for flag_bell=1:10
        GF_copy=GF;
        % if there exist negative ring, then flagJ=1 and obtain negatve ring Neg_ring，or flagJ=0 and exit
        iteration_num = iteration_num + 1;
        GF_copy=GF;
        D_total_aver = sum(sum(GF)) / N;
        Tx_aver = sum(Tx_rate) / N;
        fprintf("Iteration Number=%f:",iteration_num); 
        fprintf("Average Total Delay=%f:",D_total_aver);
        fprintf("Average Tx Rate=%f:",Tx_aver);
        % if there exist negative ring, then flagJ=1 and obtain negatve ring Neg_ring，or flagJ=0 and exit
        [Neg_ring,flagJ]=Greedy(J,GF,INF,alpha);
        if flagJ==1
            Association_update;  % if there exist negative ring, then flagJ=1 and update the GF according to the nagative ring
            % SIC Decoding and Power Allocaton
            Power_allocation;
            % SINR and TX rate calculation
            SINR_calculation;
            Graph_init;   % Update the GF
            Adjacency_init;  % Update the adjacency matrix
        convergence_Greedy_list(1,flag_bell) = sum(sum(GF));
%             if sum(max(GF'))>sum(max(GF_copy'))
%                 wrong_flag=wrong_flag+1
%                 break;
%             end
        else
            break;
        end
    end