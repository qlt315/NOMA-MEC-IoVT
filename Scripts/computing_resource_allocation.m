function C = computing_resource_allocation(Ass_BS_q,Gro_q_user)

%% global variable
global C_cap_bs
global W_req
global Omega


%% COMPUTING_RESOURCE_ALLOCATION 
cvx_begin quiet
    variable C(1,length(Gro_q_user));  % We just foucus on the resource allocation of group of user q
    expression D_pro_edge_CVX(1,length(Gro_q_user));
    for k=1:length(Gro_q_user)
        D_pro_edge_CVX(1,k) = Omega(1,Gro_q_user(k)) * W_req(1,Gro_q_user(k)) * inv_pos(C(1,k)) * 10^(-3);
    end

    T_total_edge_aver = 1/length(Gro_q_user) * sum(D_pro_edge_CVX);
    minimize(T_total_edge_aver);
    subject to
    C >= 0;
    sum(C(1,:)) == C_cap_bs(1,Ass_BS_q);
cvx_end


    
end

