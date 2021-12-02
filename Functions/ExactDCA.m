function [J,h,wt]=ExactDCA(q,lambdaJ,lambdah,theta,J_init,h_init,align)
    % similarity weighting
    if theta>0
        [W,N_eff]=CalcWeights(align,theta);
    else
        N_eff=size(align,1);
        W=zeros(size(align,1),1)+1;
    end
    
    %find data statistics
    [fi,fij]=CalcStatsWeighted(q,align,W/N_eff);
    L=size(align,2);
    
    %Generate all seqs
    seqs=FullSpace(q,L);
    %Minimization options
    options.method='lbfgs'; %Minimization scheme. Default: 'lbfgs', 'cg' for conjugate gradient (use 'cg' if out of RAM).
    options.Display='on';
    options.useMex=0;

    options.progTol=1e-20; %Threshold for when to terminate the descent. Default: 1e-9. 

    wr0=Wj(J_init,h_init);
    %[w,fval,exitflag,output,grad,hessian] = fminunc(@(x) LogLike(x,q,L,align,seqs,lambdaJ,lambdah,fi,fij),wr0,options);
    [w,wt]=minFunc(@(x) LogLike(x,q,L,align,seqs,lambdaJ,lambdah,fi,fij),wr0,options);

    [J,h]=Jw(w,q);
    
    [J,h]=IsingGauge(J,h);
end


function [LL,grad]=LogLike(wr,q,N,align,seqs,lambdaJ,lambdah,fi,fij)
    grad=wr*0;
    [J,h]=Jw(wr,q);

    
    fi_tot=h*0;
    fij_tot=J*0;
    Z=0;
    Y=zeros(size(seqs,1),1);
    

    Y=E_dca(h,J,seqs,q);
    Y_MSA=E_dca(h,J,align,q);

    
    Z=sum(exp(Y));
    E=mean(Y_MSA);
    
    reg=lambdaJ*sum(J(:).^2)+lambdah*sum(h(:).^2);
    
    LL=log(Z)-E+reg;
    
    
    
    %% now gradient of it
    %occurences

% inputX=repmat(seqs,1,1,N);
% inputY=permute(inputX,[1,3,2]);
% for a=1:q 
%         fi_tot(a,:)=sum((seqs==a).*repmat(exp(Y),1,N)/Z);
%         for b=1:q
%             fij_tot(a,b,:,:)=permute(sum((inputX==a).*(inputY==b).*repmat(exp(Y),1,N,N)/Z),[2 3 1]);            
%         end
% end
% for i=1:N
%     fij_tot(:,:,i,i)=0;
%     
% end
    [fi_tot,fij_tot]=CalcStatsWeighted(q,seqs,exp(Y)/Z);



    gradh=fi_tot-fi+2*lambdah*h;
    gradJ=fij_tot-fij+2*lambdaJ*J;
    grad=Wj(gradJ,gradh);
    
%%


end
