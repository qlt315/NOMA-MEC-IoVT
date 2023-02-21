function P = power_allocation_MM(A)
%% global variable
global N
global M
global G
global Data_size
global Channel_coff
global Bandwidth
global Sigma_n
global Omega

%% SIC Decoding and Power Allocation
Num_user = 0;
max_error = 0.1;
max_iter = 20;
results = zeros(1,max_iter);  % Eq. (12)
results_real = zeros(1,max_iter);  % Real Tx_rate
% SIC Decoding
S = Omega;   % Priority-based SIC decoding  

% Power Allocation Initilization
rng(315);
P_max = 0.1;
P_min = 0.00001;
P = P_min + (P_max - P_min)*rand(1,N);

Weight = mapminmax(Omega .* Data_size,0.1,1);


% R_tilde_last = 1;  % uplink rate of last iteration
% R_tilde_curr = 2;  % uplink rate of current iteration

P_last = P;
for t=1:max_iter
    % Power allocation
    cvx_begin quiet
    variable P_cvx(1,N);
    expression Tx_rate_cvx(1,N); % Eq. (12)
    expression Weighted_Tx_rate_cvx(1,N); % Eq. (10a)
    
    Ass_matrix  = zeros(M,N);
    Group_matrix = zeros(G,N);

    % Obtain association and group matrix by A
    for j=1:N
        Ass_BS = ceil(find(A(:,j))/G);
        Ass_matrix(Ass_BS,j) = 1;
    
        Ass_group = find(A(:,j)) - (Ass_BS-1)*G;
        Group_matrix(Ass_group,j) = 1;
    end
     
    for j=1:N   % Calculate Eq. (12) for each user
        % variable initilization
        R_tilde_2_sum = 0;
        R_tilde_3_sum_1 =0;
        R_tilde_3_sum_2 = 0;
    
        % Find all the users associate to the same BS
        Ass_BS = find(Ass_matrix(:,j));    % index of the associate BS of the current user
        if isempty(Ass_BS)  % this user is out
            Tx_rate_cvx(1,j) = 0;
            continue;
        else
            Num_user = Num_user + 1;
        end

    
        Ass_user = [];            % index of all the users associate to the same BS
        for i=1:N
            if Ass_matrix(Ass_BS,i) == 1 && i ~= j
                Ass_user  = [Ass_user,i];
            end
        end
            
    
        % Find all the users on the same sub-channel
        Ass_group = find(Group_matrix(:,j));  % index of the group of the current user
        Gro_user = [];      % index of all the users on the same sub-channel
        for i =1:length(Ass_user)
            if Group_matrix(Ass_group,Ass_user(i)) == 1 
                Gro_user = [Gro_user,Ass_user(i)];
            end
        end
                
    
        % Find all the users decode behind the current user
        S_cur = S(j);
        Beh_user = [];
        for i =1:length(Gro_user)
            if S((Gro_user(i))) > S_cur
                Beh_user = [Beh_user,Gro_user(i)];
            end
        end
        
    
        for i=1:length(Beh_user)
            R_tilde_2_sum = R_tilde_2_sum + abs(sum(Channel_coff(:,Beh_user(i)).*A(:,Beh_user(i))))^2*P_last(Beh_user(i));
        end
        R_tilde_1_sum = R_tilde_2_sum + abs(sum(Channel_coff(:,j).*A(:,j)))^2*P_cvx(j);
        R_tilde_2 = Bandwidth*log(R_tilde_2_sum + Sigma_n^2)/log(2); % second term of Eq. (12)
        R_tilde_1 = Bandwidth*log(R_tilde_1_sum + Sigma_n^2)/log(2); % first term of Eq. (12)
    
        for i=1:length(Beh_user)
            R_tilde_3_sum_2 = R_tilde_3_sum_2 + abs(sum(Channel_coff(:,Beh_user(i)).*A(:,Beh_user(i))))^2*(P_last(Beh_user(i)));  % denominator of the third term of Eq. (12)
        end

        R_tilde_3_sum_2 = R_tilde_3_sum_2 + Sigma_n^2;

        for i=1:length(Beh_user)
            R_tilde_3_sum_1 = R_tilde_3_sum_1 + abs(sum(Channel_coff(:,Beh_user(i)).*A(:,Beh_user(i))))^2*(P_cvx(Beh_user(i))-P_last(Beh_user(i))); % molecule of the third term of Eq. (12)
        end

        R_tilde_3 = Bandwidth* 1/log(2) * (R_tilde_3_sum_1 / R_tilde_3_sum_2);
    
        Tx_rate_cvx(1,j) = R_tilde_1 - R_tilde_2 - R_tilde_3;  % Eq. (12) for the j-th user
        Weighted_Tx_rate_cvx(1,j) = Tx_rate_cvx(1,j) * Weight(1,N);
    end
    maximize(sum(Weighted_Tx_rate_cvx));
    subject to
    P_min <= P_cvx <= P_max;
    % Tx_rate_cvx >= 2000000;
    cvx_end
    
    P_last = P_cvx;
    % sum(Tx_rate_cvx);
end
P = P_cvx;


end