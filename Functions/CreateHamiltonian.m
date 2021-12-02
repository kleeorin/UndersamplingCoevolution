function [J,h] = CreateHamiltonian(q,L,J0,contacts,sectors,h0,conserved)

h=zeros(q,L);      %direct conservation energies
J=zeros(q,q,L,L);  %all the rest

for i=1:size(conserved,2)
        h(1:3,conserved(i))=h0;
end

for i=1:q
    for j=1:size(contacts,1)
        J(i,i,contacts(j,1),contacts(j,2))=J0;
        J(i,i,contacts(j,2),contacts(j,1))=J0;

    end
end

for j=1:size(sectors,1)
    sector=unique(sectors(j,:));
    for i=1:q
        for ii=1:size(sector,2)
            for iii=ii+1:size(sector,2)
                J(i,i,sector(ii),sector(iii))=J0 ;
                J(i,i,sector(iii),sector(ii))=J0 ;
            end
        end
    end
end

[J,h]=IsingGauge(J,h);
end

