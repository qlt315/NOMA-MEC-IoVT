%% Decoding and Power Allocation

% SIC Decoding
S = Omega;   % Priority-based SIC decoding  
[~, S_order] = sort(S);  % Descending order pf SIC decoding

% Power allocation
P = zeros(1,N);
Max_power = 0.1;   % Maximum transmit power of users = 20dBm = 0.09998 W
Xi = 0.5;
for j=1:N
    order_index = S_order(j);
    if S(order_index) == min(S)  % The first decoding
        P(1,order_index) = Max_power;  
        order_index_pre = order_index;  % The index of the previous user
        P_pre = Max_power;  % The transmit power of the previous user
    else
        P(1,order_index) = (sum(Channel_coff(:,order_index_pre).*A(:,order_index_pre ...
            ))^2 * P_pre) / (sum(Channel_coff(:,order_index).*A(:,order_index ...
            ))^2*(Xi+1));
        order_index_pre = order_index;
        P_pre = P(1,order_index);
    end
end