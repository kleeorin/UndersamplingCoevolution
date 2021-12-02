function [fi,fij] = CalcStatsWeighted(q,align,p)
%p=p/sum(p);
L=size(align,2);
N=size(align,1);
fij=zeros(q,q,L,L);
fi=zeros(q,L);
for i=1:N
     for b1=1:L
            fi(align(i,b1),b1)=fi(align(i,b1),b1)+p(i);
            for b2=(b1+1):L
                fij(align(i,b1),align(i,b2),b1,b2)=fij(align(i,b1),align(i,b2),b1,b2)+p(i);
                fij(align(i,b2),align(i,b1),b2,b1)=fij(align(i,b1),align(i,b2),b1,b2);     
             end
         fij(:,:,b1,b1)=0;
     end
end

end

