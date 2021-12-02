function [E] = E_dca(h,J,seq,q)
    E = zeros(size(seq,1),1);
    for k=1:size(seq,1)
    for i = 1:size(seq,2)
        ai = seq(k,i) ;
        E(k) =E(k)+h(ai,i) ;
        for j = (i+1):size(seq,2)
            aj = seq(k,j);
                %if i~=j
            E(k) = E(k)+J(ai,aj,i,j);
                %end
        end
    end
    end

end

