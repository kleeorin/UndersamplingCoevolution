addpath('Functions')
%%
% Scope
N=400;

% Seed
seed=1;
rng(seed)

% Model parameters
q=10;
L=20;
contacts=[2 5;4 7;6 9];
mid_sector=[11 12 13 14 14 14];
sector=[15 16 17 18 19 20];
conserved=[];
J0=2;
h0=0;
sectors_list=[sector;mid_sector];

% Produce the model 
[J,h]=CreateHamiltonian(q,L,J0,contacts,sectors_list,h0,conserved);
NORMS=Frob(J);
ref=NORMS(sector(1),sector(2));

% MonteCarlo parameters
delta_t=200000;

%% Create main MSA
full_align=Mex_IndepMonteCarlo(N,Wj(J,h),q,delta_t);
full_align=full_align(randperm(size(full_align,1)),:);
align300=full_align(1:300,:);