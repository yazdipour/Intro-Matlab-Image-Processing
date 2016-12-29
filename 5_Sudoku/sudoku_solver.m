function D = sudoku_solver(D)

onefound = 1;
N = 0;
poss = 1:9;

while onefound
    splits = {};
    onefound = 0;
    for m = 1:9
        rowdata = nonzeros(D(m,:)');
        for n = 1:9
            E = D(m,n);
            if E ~= 0, continue, end
            
            coldata = nonzeros(D(:,n));
            blk = [ceil(m/3) ceil(n/3)]-1;
            blkdata = nonzeros(D(blk(1)*3+[1:3],blk(2)*3+[1:3]));
            
            EE = zeros(1,9);
            RCB = [rowdata; coldata; blkdata(:)];
            EE(RCB) = 1;
            Enew = find(~EE);
            
            if isempty(Enew)
                D = []; return;
            elseif length(Enew) == 1;
                onefound = 1;
                D(m,n) = Enew;
                rowdata = nonzeros(D(m,:)');
            else
                splits{end+1} = [m n Enew];
            end
        end
    end
end

if isempty(splits)
    return
end

splitlength = cellfun(@length,splits);
splits = splits{find(splitlength == min(splitlength),1)};
m = splits(1); n = splits(2);

for test = 3:length(splits)
    D(m,n) = splits(test);
    D0 = sudoku_solver(D);
    if ~isempty(D0)
        D = D0;
        return
    end
end
D = [];