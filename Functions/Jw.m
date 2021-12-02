
function [J,h]=Jw(W,q)
   n=((q^2-2*q)+sqrt((2*q-q^2)^2+8*size(W,1)*q*q))/2/q/q;
   J=zeros(q,q,n,n);
   h=zeros(q,n);
   count=1;
   for i=1:n
        for j=i+1:n
            for a=1:q
                for b=1:q
                    J(a,b,i,j)=W(count);
                    J(b,a,j,i)=W(count);

                    count=count+1;
                end
            end
        end
   end
   for i=1:n
      for a=1:q
        h(a,i)=W(count);
        count=count+1;
      end
    end
end