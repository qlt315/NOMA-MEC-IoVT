%该程序是用于Ali那篇中的分组方式
%为了尽可能用距离反映信道，这里将各个信道状态的平均值作为分组依据
% Input data format convert
nearest_BS_id_list = zeros(1,N);
for j=1:N
    [nearest_distance,nearest_BS_id] = min(Distance(:,j));
    nearest_BS_id_list(1,j) = nearest_BS_id;
end


groupnum = G;
BS = M;
C_cap_bs_nor = mapminmax(C_cap_bs, 0, 1);
% Channel_coff => (M*G,N)  to  h => (N,M,G)  
h = zeros(N,M,G);
for j=1:N
    for i=1:M
        for k=1:G
            h(j,i,k) = Channel_coff((i-1)*G+k,j);
        end
    end
end

BSn=zeros(1,N);
Groupn=BSn;
acAli=zeros(N,BS,groupnum);



hz=zeros(N,BS);
for n=1:N
    for bs=1:BS
        hz(n,bs)=mean(h(n,bs,:)+ C_cap_bs_nor(bs));
    end
    [mina,minb]=max(hz(n,:));
    BSn(n)=minb;
end

flagali=0;
for bs=1:BS
    [qpy,qpx]=sort(hz(:,bs));
    igr=0;
    for n=1:N
        if BSn(qpx(n))==bs%说明该用户在该基站处
            if flagali==0
            Groupn(qpx(n))=mod(igr,groupnum)+1;
            else 
                Groupn(qpx(n))=groupnum-mod(igr,groupnum);
            end
            acAli(qpx(n),nearest_BS_id_list(1,n),Groupn(qpx(n)))=1;
            igr=igr+1;
            if mod(igr,groupnum)==0
                flagali=1-flagali;
            end
        end
    end
end


A = zeros(M*G,N);
for j=1:N
    for i=1:M
        for k=1:G
            A((i-1)*G+k,j) = acAli(j,i,k);
        end
    end
end