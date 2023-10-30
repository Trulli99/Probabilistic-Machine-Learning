function Y = F_DBN_t2(X,AddSm)
if nargin <2
    AddSm = 0.01; %Additive smoothing [*]
end
n = size(X.like,1);
Y = X; nc = size(X.like,2);
% % ---
prio0 = ones(1,nc)/nc;
like0 = X.like(1,:);
post0 = like0.* prio0;
N = sum(post0);
post0 = post0/N;
prio1 = post0;
L1 = X.like(2,:) .* prio1 .* prio0;
L = L1 .* like0 .* prio1 .* prio0; %
N = sum(L);
prio2 = L/N;
for k=3:n
    L0 = X.like(k-2,:);
    L1 = X.like(k-1,:);
    L2 = X.like(k,:);
    L = L2 .* L1 .* L0 .* prio2 .* prio1 .* prio0; %
    N = sum(L);
    post2 = L/N;
    % ---
    Y.like(k,:) = post2;
    % % % ======================================================
    prio0 = prio1;
    prio0 = prio0 + AddSm; prio0 = prio0 / sum(prio0);
    prio1 = prio2;
    prio1 = prio1 + AddSm; prio1 = prio1 / sum(prio1);
    prio2 = post2;
    prio2 = prio2 + AddSm; prio2 = prio2 / sum(prio2);
end
end %END Function