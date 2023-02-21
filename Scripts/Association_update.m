% Change the A and GF according to the direction of the negative ring
if Neg_ring(1) <= N
    Group_origin = find(A(:,Neg_ring(1)));
else
    Group_origin = Neg_ring(1) - N;
end

for k=1:length(Neg_ring)
    if Neg_ring(k) ~= 0 && Neg_ring(k+1) ~= 0
        if Neg_ring(k) <= N  % User k is an actual user
            
            Group_k = find(A(:,Neg_ring(k)));
                % the sub-channel of user k+1
            if Neg_ring(k+1) <= N  % User k+1 also an actual user
                Group_k_after = find(A(:,Neg_ring(k+1)));
                if Neg_ring(k+2) == 0  % User k+1 is the last user in the negative ring
                    % Group transfer 
                    A(Group_k,Neg_ring(k)) =0;
                    A(Group_origin,Neg_ring(k)) = 1;
                else
                    % Group transfer 
                    A(Group_k,Neg_ring(k)) =0;
                    A(Group_k_after,Neg_ring(k)) = 1;
                    A(Group_k_after,Neg_ring(k+1)) = 0;
                end

                

            else  % User k+1 is a virtual user
                Group_k_after = Neg_ring(k+1)-N;
                A(Group_k,Neg_ring(k)) =0;
                A(Group_k_after,Neg_ring(k)) = 1;

            end
        else   % User k is a virtual user
            if Neg_ring(k+1) <= N  % User k+1 is an actual user
                Group_k_after = find(A(:,Neg_ring(k+1)));
                if Neg_ring(k+2) == 0  % User k+1 is the last user in the negative ring
                continue;

                else
                % Group transfer 
                A(Group_k_after,Neg_ring(k+1)) = 0;
                end

            else % User k and k+1 are both virtual user
                continue;
            end
        end
    else
        break;
    end
end


                



