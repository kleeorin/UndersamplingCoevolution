addpath('Functions')
addpath('Functions/minFunc/')
%% 
% Alignment properties
L=6;
q=2;

% Inference parameters
lambda_J=0.0001;
lambda_h=0.0001;
theta=0;

% Initial guess
J0=zeros(q,q,L,L);
h0=zeros(q,L);

%% run the inference
[J,h]=ExactDCA(q,lambda_J,lambda_h,theta,J0,h0,align)