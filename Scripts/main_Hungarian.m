clear all
% Pamameters Initialization
System_init;

% Hungarian-based assoication
Hungarian;

% SIC Decoding and Power Allocaton
P = power_allocation_MM(A);

% SINR and TX rate calculation
Tx_rate = rate_calculation(A,P);

% Computing resource allocation
Graph_init;
D_total_aver = sum(sum(GF)) / (N*100)
Tx_aver = sum(Tx_rate) / N