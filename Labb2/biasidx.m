function bias =biasidx(F)

bidx = find(F.D ~=0 & F.P == 0);
%bidx = find(diagnosisSequences.F00.D ~=0 & diagnosisSequences.F00.P == 0  );
minidx = bidx(1)
cutoff =bidx(find(ischange(bidx,'linear')==1)-1);
[r s] = size(cutoff);
if (r>1) | (s>1)
    
    seq1 = [bidx(1) cutoff(1,:)];
    seq2 = [cutoff(1,:)+1 cutoff(2,:)-1];
    bias = seq1
elseif r==0
    bias = [minidx bidx(end)];
else
    bias=[minidx cutoff]
end