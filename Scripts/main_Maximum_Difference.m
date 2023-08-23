clear all;
iteration_num = 0;
% Pamameters Initialization
System_init;

% Maximum Difference-based Association and Grouping
Maximum_Difference;

% SIC Decoding and Power Allocaton
P = power_allocation_MM(A);

% SINR and TX rate calculation
Tx_rate = rate_calculation(A,P);

% Computing resource allocation
Graph_init;
D_total_aver = sum(sum(GF)) / (N*100)
Tx_aver = sum(Tx_rate) / N