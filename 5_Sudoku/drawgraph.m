function Msol = drawsudoku(M)

% Basically, show the input M, and solution Msol, in a table

% D1 = cell(9);
% for m = 1:9
%     for n = 1:9
%         if M(m,n)
%             D1{m,n} = M(m,n);
%         end
%     end
% end
D1 = num2cell(M);

%Call the sudoku solver, return if it fails
Msol = sudoku_solver(M);
if isempty(Msol)
    return
else
    D2 = num2cell(Msol);
end

figure;
set(gcf,'units','pixels','Position',[200 200 800 400]);


h1 = uitable('Data',D1,'FontSize',16,'ColumnWidth',...
    num2cell(repmat(30,1,9)),'columne',false(1,9));
set(h1,'units','norm','position',[.05 .05 .4 .9]);
h2 = uitable('Data',D2,'FontSize',16,'ColumnWidth',num2cell(repmat(30,1,9)));
set(h2,'units','norm','position',[.55 .05 .4 .9]);