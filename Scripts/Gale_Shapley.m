% h -> (G*M,N)
h = Channel_coff;
groupnum =  M*G;
C_cap_bs_nor = mapminmax(C_cap_bs, 0, 1);
C_cap_bs_nor_tmp = zeros(G*M,N);
for m=1:M
    C_cap_bs_nor_tmp(G*(m-1)+1:G*(m-1)+G,:) = C_cap_bs_nor(1,m);
end

%Gale-Shapley (GS) algorithm
[PFUEX,PFUE]=sort(h+C_cap_bs_nor_tmp,1,'descend');%用户的偏好序列
[PFCX,PFC]=sort(h+C_cap_bs_nor_tmp,2,'descend');%信道的偏好序列
weifenn=1:N;
weifennn=N;
qingqiu=zeros(groupnum,N);%它是这样一个矩阵，第i行第j列的数据若为零，则分组i的偏好序列中排序为j的用户请求去分组i中
for jijiji=1:1000
    flagfff=0;%判断该次循环是否所有用户被分好
    for iii=1:N%第iii个未分组用户进行请求
        if weifenn(iii)~=0%若该用户未分配
            flagfff=1;
            nnn=weifenn(iii);%该未分组用户的编号
            for gggnnn=1:groupnum
                if PFUE(gggnnn,nnn)~=0%待会儿会写如果等于0就说明被拒绝过
                    weifenn(nnn)=0;%证明该用户已经分配好
                    ggg=PFUE(gggnnn,nnn);%该分组的编号
                    PFUE(gggnnn,nnn)=0;%如果等于0就说明被拒绝过
                    weifennn=weifennn-1;%未分组用户数减一
                    break
                end
            end
            for nnnng=1:N%该用户在该分组偏好序列中的位置
                if PFC(ggg,nnnng)==nnn%找到了
                    qingqiu(ggg,nnnng)=nnn;%就改变其值
                    break
                end
            end
        end
    end
    for jjj=1:groupnum%对每个分组进行探查
        yonghus=0;%判断该组用户是否满了
        for nnnh=1:N%探查每个位置
            if qingqiu(jjj,nnnh)~=0%该位置非空才会继续进行
                yonghus=yonghus+1;%看该用户是该组第几顺位
                if yonghus>(N/groupnum)%如果改用户超出
                    weifennn=weifennn+1;%未分组用户数加一
                    nnnnn=PFC(jjj,nnnh);%看看当前位置的用户的编号
                    weifenn(nnnnn)=nnnnn;%就在未分组用户中加上该用户
                    qingqiu(jjj,nnnh)=0;%把该用户移出“留下的”用户
                end
            end
        end
    end
    if flagfff==0
        break
    end
end
fenzzzz=zeros(groupnum,(N/groupnum));
for iiiiii=1:groupnum
    nnnnnn=0;
    for jjjjjj=1:N
        if qingqiu(iiiiii,jjjjjj)~=0
            nnnnnn=nnnnnn+1;
            fenzzzz(iiiiii,nnnnnn)=qingqiu(iiiiii,jjjjjj);
        end
    end
end
[PFUEX,PFUE]=sort(h,1,'descend');%用户的偏好序列
for ijijijij=1:1000000%反复寻找
    flagijijijij=0;
    for i=1:groupnum%所有分组
        for j=1:(N/groupnum)%遍历所有用户
            nnnnn=fenzzzz(i,j);%找到该用户的编号
            flagggggg=0;
            for ggggg=1:(groupnum)%找是否有自己愿意换过去的,从当前用户最想去的分组开始
                gggggm=PFUE(ggggg,nnnnn);%当前分组
                if PFUE(ggggg,nnnnn)==i%就是说到了目前的分组，那么后边的都可以不要
                    break
                end
                for nnnnnm=1:(N/groupnum)%如果上一个if没跳出，就是找到了想换过去的分组，那么再找是否该分组有用户想过去
                    nnnnnmm=fenzzzz(gggggm,nnnnnm);%目前试探的对方用户的编号
%                     nnnnnmm
%                     h(i,nnnnnmm)
%                     h(gggggm,nnnnnmm)
                    if h(i,nnnnnmm)>h(gggggm,nnnnnmm)%对方有交换的意愿,就交换
                        yz=fenzzzz(gggggm,nnnnnm);
                        fenzzzz(gggggm,nnnnnm)=fenzzzz(i,nnnnnm);
                        fenzzzz(i,nnnnnm)=yz;
                        flagggggg=1;%一旦交换成立，就得跳出当前用户的循环
                        flagijijijij=1;%一旦交换成功，就得执行下次寻找
                        break
                    end
                end
                if flagggggg==1
                    break
                end
            end
        end
    end
    if flagijijijij==0%一旦无交换成功，就跳出
        break
    end
end
fenzzzz=zhengxing1(fenzzzz,h);

% Output data convert
A = zeros(M*G,N);
for i=1:G*M
    for j=1:N/groupnum
        user_id = fenzzzz(i,j);
        A(i,user_id) = 1;
    end
end
        
       
            
            
            
            
            
            
            
            
            
            
