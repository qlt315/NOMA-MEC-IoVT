%这段代码是为了防止出现：
%松弛后被松弛节点的后继节点中存在前缀节点的同组用户
%为了这件事，貌似需要建立一个数组来存储前缀节点了…………
%接下来的是每次进行松弛的话所要进行的操作
qzjd(fz(n),:)=qzjd(gfz(g,v),:);
qzjd(fz(n),gfz(g,v))=1;
qzfz(fz(n),:)=qzfz(gfz(g,v),:);
qzfz(fz(n),w(gfz(g,v)))=1;
% for mme=1:(N+G)
%     if qzjd(mme,fz(n))==1%说明mme是其后缀节点
%         if qzfz(fz(n),w(mme))==1%说明是出现了重复，要对mme进行更新
%             if qzjd(fz(n),mme)~=1%就是说这次是同组非同用户
%                 dis(mme)=maxedge;
%                 dfs(mme)=0;%并更新树的前缀节点
%             end
%         end
%     end
% end
qzsz(fz(n),2:end)=qzsz(gfz(g,v),1:(N+G-1));
qzsz(fz(n),1)=gfz(g,v);
if qzsz(fz(n),(G+1))~=0
    flagtcl=1;
    tcjd=fz(n);
end






            
        