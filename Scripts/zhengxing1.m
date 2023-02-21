function PPP=zhengxing1(P,h)
[m,n]=size(P);
PPP=P;
for i=1:m
    [x,y]=sort(h(i,P(i,:)),'descend');
    PPP(i,:)=P(i,y);
end
    
    






