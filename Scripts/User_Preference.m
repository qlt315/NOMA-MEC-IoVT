% h -> (G*M,N)
h = Channel_coff;
groupnum =  M*G;
% User preference algorithm
[PFUEX,PFUE]=sort(h,1,'descend');%用户的偏好序列
[PFCC,PFC]=sort(Omega,'descend');%信道的偏好序列,这个偏好需要提前到主程序中去，不然不对
fenzu=zeros(groupnum,N/groupnum);
for jj=1:N
    j=PFC(jj);
    flagooo=0;
    for i=1:groupnum
        for z=1:(N/groupnum)
            if fenzu(PFUE(i,j),z)==0%用户j的第i偏好分组
                fenzu(PFUE(i,j),z)=j;
                flagooo=1;
                break;
            end
            if flagooo==1
                break
            end
        end
        if flagooo==1
            break
        end
    end
end
for ijijijij=1:1000000%反复寻找
    flagijijijij=0;
    for i=1:groupnum%所有分组
        for j=1:(N/groupnum)%遍历所有用户
            nnnnn=fenzu(i,j);%找到该用户的编号
            flagggggg=0;
            for ggggg=1:(groupnum)%找是否有自己愿意换过去的,从当前用户最想去的分组开始
                gggggm=PFUE(ggggg,nnnnn);%当前分组
                if PFUE(ggggg,nnnnn)==i%就是说到了目前的分组，那么后边的都可以不要
                    break
                end
                for nnnnnm=1:(N/groupnum)%如果上一个if没跳出，就是找到了想换过去的分组，那么再找是否该分组有用户想过去
                    nnnnnmm=fenzu(gggggm,nnnnnm);%目前试探的对方用户的编号
%                     nnnnnmm
%                     h(i,nnnnnmm)
%                     h(gggggm,nnnnnmm)
                    if h(i,nnnnnmm)>h(gggggm,nnnnnmm)%对方有交换的意愿,就交换
                        yz=fenzu(gggggm,nnnnnm);
                        fenzu(gggggm,nnnnnm)=fenzu(i,nnnnnm);
                        fenzu(i,nnnnnm)=yz;
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
fenzu=zhengxing1(fenzu,h);

% Output data convert
A = zeros(M*G,N);
for i=1:G*M
    for j=1:N/groupnum
        user_id = fenzu(i,j);
        A(i,user_id) = 1;
    end
end
        
        
        
        
        
        
        
        
        
        
        
        
        
        
