function [J,h]=IsingGauge(J_in,h_in)
J=J_in;
h=h_in;
L=size(J,3);
q=size(J,1);
     for i=1:L
          h(:,i)=h(:,i)+(sum(mean(J(:,:,:,i),1),3)'-mean(h(:,i))-sum(mean(mean(J(:,:,i,:),2),1),4));
     end
     for i=1:L
         for j=1:L
         J(:,:,i,j)=J(:,:,i,j)+(-repmat(mean(J(:,:,i,j)),q,1)-repmat(mean(J(:,:,i,j),2),1,q)+mean(mean(J(:,:,i,j))));
         end
     end
end


