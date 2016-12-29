function [Plocal,del] = identifynumbers_fun(pts,Pnew,NT,IBW)

% No blobs, quick return
if isempty(Pnew)
    Plocal = nan;
    del = [];
    return
end

% Use the vertices to transform the blob coordinates
try
    T = cp2tform(pts(1:4,:),[0.5 0.5; 9.5 0.5; 9.5 9.5; 0.5 9.5],'projective');
catch
    Plocal = nan;
    del = [];
    return
end
Plocal = (tformfwd(T,Pnew));
Plocal = round(2*Plocal)/2;

% "del" represents those blobs which are not in digit-like locations
del = find(sum(Plocal - floor(Plocal) > 0 |  Plocal < 1 | Plocal > 9,2)) ;
Plocal(del,:) = [];
Pnew(del,:) = [];

if any(isnan(Plocal(:))) || isempty(Plocal)
    Plocal = nan;
    del = [];
    return
end


% The actual identification algorithm
try
    Plocal(end,3) = 0;
    for k = 1:size(Pnew,1)
        for s = [0 -1 1 -2 2 -3 3 -4 4 -5 5]
            N = bwselect(IBW,Pnew(k,1) + s ,Pnew(k,2));
            if any(N(:))
                break
            end
        end
        if s == 5
            Plocal = nan;
            return
            %continue
        end
        
        [i,j] = find(N);
        N = N(min(i):max(i),min(j):max(j));
        N0 = N;
        
        % Resize to be 20x20
        N = imresize(N,[20 20]);
        
        %for each digit, S(v) represents the degree of matching
        for v = 1:9
            S(v) = sum(sum(N.*NT{v}));
        end
        
        Plocal(k,3) = find(S == max(S),1);
        
        if (Plocal(k,3) == 5 || Plocal(k,3) == 6) && abs(S(5) - S(6)) < 0.1 %If it's a 5 or 6, use the Euler number
            E = regionprops(N,'EulerNumber');
            if ~E(1).EulerNumber
                Plocal(k,3) = 6;
            end
        end
        
    end
catch
    %keyboard
end
Plocal = sortrows(Plocal);