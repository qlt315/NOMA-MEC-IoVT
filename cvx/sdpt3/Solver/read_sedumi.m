%%*******************************************************************
%%  Read in a problem in SeDuMi format.
%%
%%  [blk,A,C,b,perm] = read_sedumi(fname,b,c,K)
%%
%%  Input: fname.mat = name of the file containing SDP data in
%%                     SeDuMi format.
%%
%% Important note: Sedumi's notation for free variables "K.f"
%%                 is coded in SDPT3 as blk{p,1} = 'u', where
%%                 "u" is used for unrestricted variables.
%%
%% SDPT3: version 3.1
%% Copyright (c) 1997 by
%% K.C. Toh, M.J. Todd, R.H. Tutuncu
%% Last Modified: 16 Sep 2004
%%******************************************************************

function [blk,Avec,C,b,perm] = read_sedumi(fname,b,c,K,smallblkdim)

if (nargin < 5)
    smallblkdim = 50;
end

A = 0;
At = 0;
if ischar(fname)
    %%
    %%  load the matlab file containing At, c, b, and K
    %%
    K.f = []; K.l = []; K.q = [];
    compressed = 0;
    if exist([fname,'.mat.gz'],'file');
        compressed = 1;
        unix(['gunzip ', fname,'.mat.gz']);
    elseif exist([fname,'.gz'],'file');
        compressed = 2;
        unix(['gunzip ', fname,'.gz']);
    elseif exist([fname,'.mat.Z'],'file');
        compressed = 3;
        unix(['uncompress ', fname,'.mat.Z'],'file');
    elseif exist([fname,'.Z'],'file');
        compressed = 4;
        unix(['uncompress ', fname,'.Z']);
    end
    if exist([fname,'.mat'],'file') || exist(fname,'file')
        eval(['load ', fname]);
    else
        fprintf('*** Problem not found, please specify the correct path or problem. \n');
        blk = []; Avec = []; C = []; b = [];
        return;
    end
    if (compressed == 1)
        unix(['gzip ', fname,'.mat']);
    elseif (compressed == 2)
        unix(['gzip ', fname]);
    elseif (compressed == 3)
        unix(['compress ', fname,'.mat']);
    elseif (compressed == 4)
        unix(['compress ', fname]);
    end
elseif (nargin < 4)
    error('read_sedumi: need 4 input ');
else
    A = fname;
end
%%
if exist('c','var')
    if (size(c,1) == 1), c = c'; end;
end
if exist('C','var')
    c = C; %#ok
    if (size(c,1) == 1), c = c'; end;
end
if (size(b,1) == 1), b = b'; end;
if (norm(A,'fro') > 0) && (size(A,2) == length(b)); At = A; end
%%
if (norm(At,'fro')==0), At = A'; end;
nn = size(At,1); if (max(size(c)) == 1); c = c*ones(nn,1); end;
if ~isfield(K,'f'); K.f = 0; end
if ~isfield(K,'l'); K.l = 0; end
if ~isfield(K,'q'); K.q = 0; end
if ~isfield(K,'s'); K.s = 0; end
if (K.f == 0) || isempty(K.f); K.f = 0; end;
if (K.l == 0) || isempty(K.l); K.l = 0; end;
if (sum(K.q) == 0) || isempty(K.q); K.q = 0; end
if (sum(K.s) == 0) || isempty(K.s); K.s = 0; end
%%
%%
%%
% m = length(b);
rowidx = 0;  idxblk = 0;
if ~(K.f == 0)
    len = K.f;
    idxblk = idxblk + 1;
    blk{idxblk,1} = 'u'; blk{idxblk,2} = K.f;
    Atmp = At(rowidx+1:rowidx+len,:);
    Avec{idxblk,1} = Atmp;
    C{idxblk,1} = c(rowidx+1:rowidx+len);
    perm{idxblk} = [];
    rowidx = rowidx + len;
end
if ~(K.l == 0)
    len = K.l;
    idxblk = idxblk + 1;
    blk{idxblk,1} = 'l'; blk{idxblk,2} = K.l;
    Atmp = At(rowidx+1:rowidx+len,:);
    Avec{idxblk,1} = Atmp;
    C{idxblk,1} = c(rowidx+1:rowidx+len);
    perm{idxblk} = [];
    rowidx = rowidx + len;
end
if ~(K.q == 0)
    len = sum(K.q);
    idxblk = idxblk + 1;
    blk{idxblk,1} = 'q';
    if size(K.q,1) <= size(K.q,2);
        blk{idxblk,2} = K.q;
    else
        blk{idxblk,2} = K.q';
    end
    Atmp = At(rowidx+1:rowidx+len,:);
    Avec{idxblk,1} = Atmp;
    C{idxblk,1} = c(rowidx+1:rowidx+len);
    perm{idxblk} = [];
    rowidx = rowidx + len;
end
if ~(K.s == 0)
    blksize = K.s;
    if (size(blksize,2) == 1); blksize = blksize'; end
    blknnz = [0, cumsum(blksize.*blksize)];
    deblkidx = find(blksize > smallblkdim);
    if ~isempty(deblkidx)
        for p = 1:length(deblkidx)
            idxblk = idxblk + 1;
            n = blksize(deblkidx(p));
            pblk{1,1} = 's'; pblk{1,2} = n;
            blk(idxblk,:) = pblk;
            Atmp = At(rowidx+blknnz(deblkidx(p))+(1:n*n),:);
            %%
            %% column-wise positions of upper triangular part
            %%
            tmp = triu(ones(n)); tmp = tmp(:);
            idxtriu = find(tmp);
            %%
            %% row-wise positions of lower triangular part
            %%
            tmp = tril(reshape(1:n*n,n,n)); tmp = tmp(:);
            idxtmp = find(tmp);
            [dummy,idxsub] = sort(rem(tmp(idxtmp),n)); %#ok
            idxtril = [idxtmp(idxsub(n+1:end));idxtmp(idxsub(1:n))];
            %%
            tmp2 = sqrt(2)*triu(ones(n),1) + speye(n,n);
            tmp2 = tmp2(:);
            dd = tmp2(tmp2~=0);
            n2 = n*(n+1)/2;
            Atmptriu = Atmp(idxtriu,:); %#ok
            Atmptril = Atmp(idxtril,:);
            if (norm(Atmptriu-Atmptril,'fro') > 1e-13)
                fprintf('\n warning: constraint matrices not symmetric.');
                fprintf('\n          matrices are symmetrized.\n');
                Atmptriu = 0.5*(Atmptriu+Atmptril);
            end
            Avec{idxblk,1} = spdiags(dd,0,n2,n2)*Atmptriu;
            Ctmp = c(rowidx+blknnz(deblkidx(p))+(1:n*n));
            Ctmp = mexmat(pblk,Ctmp,1);
            C{idxblk,1} = 0.5*(Ctmp+Ctmp'); %#ok
            perm{idxblk,1} = deblkidx(p);
        end
    end
    spblkidx = find(blksize <= smallblkdim);
    if ~isempty(spblkidx)
        cnt = 0;  cnt2 = 0;
        spblksize = blksize(spblkidx);
        nn  = sum(spblksize.*spblksize);
        nn2 = sum(spblksize.*(spblksize+1)/2);
        pos = zeros(nn,1);
        dd  = zeros(nn2,1);
        idxtriu = zeros(nn2,1);
        idxtril = zeros(nn2,1);
        for p = 1:length(spblkidx)
            n = blksize(spblkidx(p));
            n2 = n*(n+1)/2;
            pos(cnt+1:cnt+n*n) = rowidx+blknnz(spblkidx(p))+(1:n*n);
            %%
            %% column-wise positions of upper triangular part
            %%
            tmp  = triu(ones(n)); tmp = tmp(:);
            idxtriu(cnt2+1:cnt2+n2) = cnt+find(tmp);
            %%
            %% row-wise positions of lower triangular part
            %%
            tmp = tril(reshape(1:n*n,n,n)); tmp = tmp(:);
            idxtmp = find(tmp);
            [dummy,idxsub] = sort(rem(tmp(idxtmp),n)); %#ok
            idxtril(cnt2+1:cnt2+n2) = cnt+[idxtmp(idxsub(n+1:end));idxtmp(idxsub(1:n))];
            %%
            tmp2 = sqrt(2)*triu(ones(n),1) + speye(n,n);
            tmp2 = tmp2(:);
            dd(cnt2+1:cnt2+n2) = tmp2(tmp2~=0);
            cnt  = cnt + n*n;
            cnt2 = cnt2 + n2;
        end
        idxblk = idxblk + 1;
        blk{idxblk,1} = 's';  blk{idxblk,2} = blksize(spblkidx);
        Atmp = At(pos,:);
        Atmptriu = Atmp(idxtriu,:);
        Atmptril = Atmp(idxtril,:);
        if (norm(Atmptriu-Atmptril,'fro') > 1e-13)
            fprintf('\n warning: constraint matrices not symmetric.');
            fprintf('\n          matrices are symmetrized.\n');
            Atmptriu = 0.5*(Atmptriu+Atmptril);
        end
        Avec{idxblk,1} = spdiags(dd,0,length(dd),length(dd))*Atmptriu;
        Ctmp = c(pos);
        Ctmp = mexmat(blk(idxblk,:),Ctmp,1);
        C{idxblk,1} = 0.5*(Ctmp+Ctmp');
        perm{idxblk,1} = spblkidx;
    end
end
%%
%%*******************************************************************
