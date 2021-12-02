function [F] = Frob(J)
F=sqrt(permute((sum(sum(J.^2,1),2)),[4,3,2,1]));
end

