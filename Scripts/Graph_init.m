% GF generation  GF -> size:[G*M,N] 
% GF(i,j) represents the total latency of user j when user j on the
% subchannel i; GF(i,j)=0 means user j is not on the sub-channel i

% Obtain association and group matrix by A
Ass_matrix  = zeros(M,N);
Group_matrix = zeros(G,N);
for j=1:N
    Ass_BS = ceil(find(A(:,j))/G);
    Ass_matrix(Ass_BS,j) = 1;

    Ass_group = find(A(:,j)) - (Ass_BS-1)*G;
    Group_matrix(Ass_group,j) = 1;
end

GF = zeros(G*M,N);
% C = zeros(M,N);  % Computing resource allocation matrix
D_tra = zeros(1,N);
D_pro_edge = zeros(1,N);

% Computing resouce allocation (CVX)
        cvx_begin quiet
        variable C(M,N);
        % D_pro_edge = zeros(1,N);
        expression D_pro_edge_CVX(1,N);
        for k=1:N
            Ass_BS = find(Ass_matrix(:,k));   % the BS associated to user k
            D_pro_edge_CVX(1,k) = W_req(1,k) * inv_pos(C(Ass_BS,k)) * 10^(-3);
        end

        T_total_edge_aver = 1/N * sum(Omega.*D_pro_edge_CVX);
        minimize(T_total_edge_aver);
        subject to
        C >= 0;
        for z=1:M
            sum(C(z,:)) == C_cap_bs(1,z);
        end
        


        cvx_end
        for k=1:N
            Ass_BS = find(Ass_matrix(:,k));   % the BS associated to user k
            D_pro_edge(1,k) = W_req(1,k)  / (C(Ass_BS,k)* 10^(3)) ;
        end

 
for i=1:G*M
    for j=1:N
        if A(i,j) ==0   % user j is not in this sub-channel
            continue;
        end
        % user j is in sub-channel i
    
        % Transmit delay calculation
        Ass_BS = find(Ass_matrix(:,j));   % the BS associated to user j
        Group = find(Group_matrix(:,j));    % the sub-channel of user j
        D_tra(1,j) = Data_size(1,j) * 1000 / Tx_rate(1,j);
    

        GF(i,j) = Omega(1,j)*(D_pro_edge(1,j) + D_tra(1,j));

    end
end
