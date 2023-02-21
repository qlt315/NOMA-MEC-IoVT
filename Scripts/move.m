function GF=move(GF,qpx,g1,n1,g2,h,rr,rh)%直接上，直接对两个分组分别重新算一遍就好了
[G,N]=size(GF);
bnj1=0;%分组1的bn减一数据
bnj2=0;%分组2的bn减一数据
GF(g1,n1)=0;
for n=1:N%顺带把两个分组都解决掉
    if GF(g1,qpx(g1,n))~=0
        GF(g1,qpx(g1,n))=bnj1*(rr(qpx(g1,n))+1)+rh(g1,qpx(g1,n));
        bnj1=GF(g1,qpx(g1,n));
    end
    if qpx(g2,n)==n1%对n1进行操作
        GF(g2,qpx(g2,n))=bnj2*(rr(qpx(g2,n))+1)+rh(g2,qpx(g2,n));
        bnj2=GF(g2,qpx(g2,n));
        continue;
    end
    if GF(g2,qpx(g2,n))~=0
        GF(g2,qpx(g2,n))=bnj2*(rr(qpx(g2,n))+1)+rh(g2,qpx(g2,n));
        bnj2=GF(g2,qpx(g2,n));
    end
    
end



