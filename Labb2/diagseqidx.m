function diags =diagseqidx(F)
% diagnosisSequences.F00
  bidx = find(F.D ==0 & F.P == 0);
%  bidx = find(diagnosisSequences.F50.D ==0 & diagnosisSequences.F50.P == 0);
minidx = bidx(1);
cutoff1 =bidx(find(ischange(bidx,'linear')==1)-1);
[r s] = size(cutoff1);
    if r>1
        
         e1 = cutoff1(1,:)-minidx;
         e2 = cutoff1(2,:)-bidx(find(bidx==cutoff1(1,:))+1);
         e3 = cutoff1(3,:)-bidx(find(bidx==cutoff1(2,:))+1);
         e4 = bidx(end)-bidx(find(bidx==cutoff1(3,:))+1);
         
        seq1 = [bidx(1) cutoff1(r,:)];
        seq2 = [cutoff1(1,:)+1 cutoff1(2,:)-1];
        bias = seq1;
        bidx(find(bidx==cutoff1(1,:))+1)
    elseif r== 0 
        diags = [bidx(1) bidx(end)];
        
    else
    seq1 =[minidx cutoff1+1];
    seq2 =[bidx(find(bidx==cutoff1)+1) bidx(end)];
    diags =[seq1;seq2];
    end
