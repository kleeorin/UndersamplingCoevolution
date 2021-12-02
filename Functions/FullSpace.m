function [seqs_full] = FullSpace(q,L)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
seqs_numbered=((1:q^L)-1)';
         seqs_full=zeros(size(seqs_numbered,1),L);
         for i=1:size(seqs_numbered,1)
             seqs_full(i,:)=mod(floor(seqs_numbered(i) ./ q .^ ((L-1):-1:0)), q);
         end
         seqs_full=seqs_full+1;
end

