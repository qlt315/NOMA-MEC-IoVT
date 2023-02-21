%% Initialization

% Global Variables
global Data_size;
global N;
global M;
global G;
global Channel_coff
global W_req
global C_cap_bs
global Omega
global Bandwidth
global Sigma_n

% User and BS location initialization
N = 100;  % Number of users
M = 4;   % Number of BS
G = 5;  % Number of group of each BS
cvx_solver SDPT3
rng(315);
User_location_X = rand(1,N)*600;
User_location_Y = rand(1,N)*600;

BS_location_X = zeros(1,M);
BS_location_Y = zeros(1,M);
BS_location_X(1,1) = 200;
BS_location_Y(1,1) = 200;
BS_location_X(1,2) = 400;
BS_location_Y(1,2) = 200;
BS_location_X(1,3) = 200;
BS_location_Y(1,3) = 400;
BS_location_X(1,4) = 400;
BS_location_Y(1,4) = 400;


Distance = zeros(M,N);
for i=1:M
    for j=1:N
        Distance(i,j) = sqrt((User_location_X(1,j)-BS_location_X(1,i)).^2 + (User_location_Y(1,j)-BS_location_Y(1,i)).^2);
    end
end


% User parameter initilization
% D_th = rand(1,N) + 1;  % Delay threshold [1,2]
Data_size = 100 + rand(1,N) * 100;   % Task data size [100,200] kB
W_req = 15 + rand(1,N)*15;   % Workload request [15,30] Mbit/s
Omega = randperm(N);  % Priority weight  [1,N]
C_cap_bs = 5 +rand(1,M)*10;  % Computing capacity of BS [5,15] Gbit/s

% Strategy initialization
A = zeros(M*G,N);  % User association and grouping matrix




% User association and grouping initialization

for j=1:N
    [nearest_distance,nearest_BS_id] = min(Distance(:,j));
    random_group_number = randi([1 G]);
    A((nearest_BS_id-1)*G+random_group_number,j) = 1;
end



% NOMA Channel
Bandwidth = 2*10^6;   % Bandwidth for each group 2MHz
Sigma_n = 3.981071705534951e-21*Bandwidth;    % Variance of AWGN (W)=-174dBm/Hz


beta = abs(randn(M*G,N) + randn(M*G,N)*1i).^2/2;   % Rayleigh fading cofficient  ~CN(0,1)
PL=128.1+37.6.*log10(Distance/1000);
% Shadow_fad_tmp = 10.^(PL/10);  % Shadow fading cofficient
Large_scale_fading = zeros(M*G,N);
for j=1:N
    for i=1:M
        for g=1:G
            Large_scale_fading(G*(i-1)+g,j) = PL(i,j);
        end
    end
end
    
    
% Channel_coff = beta ./ Shadow_fad / (Sigma_n);   % Channel cofficient 

Channel_coff = beta.* sqrt(10.^(-Large_scale_fading/10));




