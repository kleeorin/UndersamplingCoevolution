%function [align] = Mex_IndepMonteCarlo(N,w,q,delta_t)

function [align] = Mex_IndepMonteCarlo(N, w, q, delta_t)
 q = double(q);
 L = int32(((q^2 - 2 * q)+sqrt((2*q-q^2)^2 + 8 * size(w, 1) * q * q))/2/q/q);

      seed = randi(intmax-N);
      align = double(transpose(C_MSA_MonteCarlo(int32(seed), w, int32(N), int32(q), L, int32(delta_t))));

%     align=zeros(N,L);
%     parfor i=1:N 
%         align_init=randi(q,L,1);
%         seed=randi(intmax);
%         align(i,:)=C_OneMonteCarlo(int32(seed),int32(align_init),w,int32(q),L,int32(delta_t));
%     end    
end

