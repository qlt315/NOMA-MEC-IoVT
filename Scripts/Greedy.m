%这是一个贪心算法
%第一步寻找J中最小的两点间距
%
function [fuhuan,flagJ]=Greedy(J,GF,INF,alpha)
[G,N]=size(GF);
flagJ=0;

w=zeros(1,(N+G));%记录每个用户的分组信息
fuhuan=zeros(1,(N+G));%防止算法无输出
fz=zeros(1,(G+N));%用于放置分组信息，将所有用户按照其分组编号排序；
fzx=1;%探查到第几个位置
huancsh=zeros(1,(G-1));%（环初始化）用于记录找到不断最小的顺序
huanjl=zeros(1,(G-1));%（环距离）用于记录找到不断最小的总权值
fzg=fz;%矩阵fz里用户对应的分组编号
gfz=zeros(G,(N+G));%反过来，使得gfz前几个数值就是它所包含的用户，但是具体是用户编号还是用户的fz编号要仔细考量
for j=1:G
    gfzx=1;%探查到了gfz第j行的第几个位置
    for i=1:(N)
        if GF(j,i)~=0
            fz(fzx)=i;
            fzg(fzx)=j;
            fzx=fzx+1;
            gfz(j,gfzx)=i;
            gfzx=gfzx+1;
            w(i)=j;%记录每个用户的分组信息
        end
        if i==N
            fz(fzx)=i+j;
            fzg(fzx)=j;
            fzx=fzx+1;
            gfz(j,gfzx)=i+j;%这样设置的话，gfz与fz是一一对应的
            gfzx=gfzx+1;
            w(N+j)=j;%记录每个用户的分组信息
        end
    end
end
Jbeifen=J;%后面会对J里的值进行操作，所以还是备份一下比较好
Jbeiyong=J;
LLLmin=INF;
huanmin=fuhuan;

for iii=1:ceil((G+N)*alpha)
    
    [L,X]=min(min(Jbeiyong'));
    [L,Y]=min(min(Jbeiyong));
    if L>=0
        break;
    end
    Jbeiyong(X,Y)=INF;
    
    
    
    
    
    J=Jbeifen;
    for n=1:(G+N)%用于防止后来者用到这里
        if w(n)==w(X)
            J(n,:)=INF;
            J(:,n)=INF;
        end
    end
    
    huancsh(1)=Y;
    huanjl(1)=L+Jbeifen(Y,X);
    for n=1:(G+N)%用于防止后来者用到这里
        if w(n)==w(Y)
            J(n,:)=INF;
            J(:,n)=INF;
        end
    end
    
    for qqq=2:(G-1)
        [xyL,Y]=min(J(Y,:));
        huancsh(qqq)=Y;
        for n=1:(G+N)%用于防止后来者用到这里
            if w(n)==w(Y)
                J(n,:)=INF;
                J(:,n)=INF;
            end
        end
        
        huanjl(qqq)=huanjl(qqq-1)-Jbeifen(huancsh(qqq-1),X)+xyL+Jbeifen(Y,X);
    end
    [LLL,YYY]=min(huanjl);
    if LLL<0
        fuhuan(1)=X;
        fuhuan(2:(YYY+1))=huancsh(1:YYY);
        fuhuan(YYY+2)=X;
    end
    
    if LLL<LLLmin
        LLLmin=LLL;
        huanmin=fuhuan;
    end
end
if LLLmin<0
    fuhuan=huanmin;
    flagJ=1;
end