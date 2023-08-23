Ass_matrix  = zeros(M,N);
Group_matrix = zeros(G,N);

% Obtain association and group matrix by A
for j=1:N
    Ass_BS = ceil(find(A(:,j))/G);
    Ass_matrix(Ass_BS,j) = 1;

    Ass_group = find(A(:,j)) - (Ass_BS-1)*G;
    Group_matrix(Ass_group,j) = 1;
end


SINR = zeros(1,N);
Tx_rate = zeros(1,N);


for j=1:N
    % Find all the users associate to the same BS
    Ass_BS = find(Ass_matrix(:,j));    % index of the associate BS of the current user


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
    
    SINR_den_sum = 0;   % denominator of the SINR, which is convenient for SINR calculation
    for i=1:length(Beh_user)
        SINR_den_sum = SINR_den_sum + abs(sum(Channel_coff(:,Beh_user(i)).*A(:,Beh_user(i))))^2*P(Beh_user(i));
    end


    SINR(1,j) = abs(sum(Channel_coff(:,j).*A(:,j)))^2*P(j) / (SINR_den_sum + Sigma_n);
    Tx_rate(1,j) = Bandwidth*log2(1+SINR(1,j));
end