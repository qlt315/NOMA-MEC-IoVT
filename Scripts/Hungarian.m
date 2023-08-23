%该程序是匈牙利那篇中的分组方式
%为了尽可能用距离反映信道，这里将各个信道状态的平均值作为分组依据
%该算法与ali的那篇是有区别的，区别就在于，ali里是Z字形分组，这里更像蛇形
%为了实现蛇形，我设置了一个变量fanzhuan来进行控制
% Input data format convert
nearest_BS_id_list = zeros(1,N);
for j=1:N
    [nearest_distance,nearest_BS_id] = min(Distance(:,j));
    nearest_BS_id_list(1,j) = nearest_BS_id;
end


groupnum = G*M;
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

% Use the average value of each channel as the grouping basis
BSn=zeros(1,N);
Groupn=BSn;
BS_G_N=zeros(BS,groupnum,N);
BS_G_N_i=zeros(BS,groupnum);
acxy=zeros(N,BS,groupnum);


maxnum=ceil(N/groupnum/BS); % Maximum number of users per group
if maxnum==(N/groupnum/BS)
    maxnum=maxnum+1;
end
hz=zeros(N,BS);
h_linshi=h;

for n=1:N
    for bs=1:BS
        hz(n,bs)=mean(h_linshi(n,bs,:)+ C_cap_bs_nor(bs));
    end
    [mina,minb]=max(hz(n,:));
    BSn(n)=minb;
end


for qqdd=1:(groupnum-1)
    Groupn=zeros(1,N);
    BS_G_N=zeros(BS,groupnum,N);
    BS_G_N_i=zeros(BS,groupnum);
    acxy=zeros(N,BS,groupnum);
    for n=1:N
        
        [mina,minb]=max(h_linshi(n,BSn(n),:));
        Groupn(n)=minb;
        acxy(n,nearest_BS_id_list(1,j),Groupn(n))=1;
        BS_G_N(BSn(n),Groupn(n),BS_G_N_i(BSn(n),Groupn(n))+1)=n;
        BS_G_N_i(BSn(n),Groupn(n))=BS_G_N_i(BSn(n),Groupn(n))+1;
    end
    for bs=1:BS
        for g=1:groupnum
            if BS_G_N_i(bs,g)>maxnum
                [ggga,gggb]=sort(h_linshi(BS_G_N(bs,g,1:BS_G_N_i(bs,g))));
                
                h_linshi(BS_G_N(bs,g,gggb(1:(BS_G_N_i(bs,g)-maxnum))),bs,g)=0;
                
            end
        end
    end
    
    
    
    
    
    
end

% Output data format convert  acxy -> (N,M,G)
A = zeros(M*G,N);
for j=1:N
    for i=1:M
        for k=1:G
            A((i-1)*G+k,j) = acxy(j,i,k);
        end
    end
end
