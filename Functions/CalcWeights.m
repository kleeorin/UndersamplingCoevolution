function [weights, N_eff] = CalcWeights(align,theta)
        m=C_InverseWeights(int32(align-1),theta);
        weights=1./m;
        N_eff=sum(weights);
end

