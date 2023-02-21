%使用有向图后的贪心
shiboyi3gaijin;%得到GF数据
for iqiqiqiq=1:10000000000000%这里就是不断运行到break为止，但是要注意这里的迭代变量不可以与循环内其他for循环中的迭代变量重复
    GFbeifen1=GF;
    GraphJ;%得到邻接矩阵J
    
    [fuhuan,flagJ]=greedyhuan(J,GF,INF);%若有负环，则flagJ=1，得到负环fuhuan，若无负环，则flagJ=0，退出；
    if flagJ==1
        fuhuangengxin1;%若有负环，则flagJ=1，对所得到的负环fuhuan所指向的操作进行更新
        
    if sum(max(GF'))>sum(max(GFbeifen1'))
        woyoucuole=woyoucuole+1
            break;
        end
    else
        break;
    end
end
iqiqiqiq
