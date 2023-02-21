iteration_num = 0;
cvx_solver sedumi
% Pamameters Initialization
System_init;

% SIC Decoding and Power Allocaton
P = power_allocation_MM(A);

% SINR and TX rate calculation
Tx_rate = rate_calculation(A,P);

% User-Preference Grouping
User_Preference;

% SIC Decoding and Power Allocaton
P = power_allocation_MM(A);

% SINR and TX rate calculation
Tx_rate = rate_calculation(A,P);

% Computing resource allocation
Graph_init;
D_total_aver = sum(sum(GF)) / N
Tx_aver = sum(Tx_rate) / N