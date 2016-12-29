function mysudokusolver()
%%
 filename ='SUDOKU_PUZZLE.txt';

%% Read file
inputfile = dlmread(filename);

%% Call the solver
solved = sudoku_solver(inputfile);

%% Show
figure;
% Changing Figure location and size
set(gcf,'units','pixels','Position',[200 200 800 400]); 
% Matrix to Cell to Show in Table 
D1 = num2cell(inputfile);

if isempty(solved)
    D2 = cell(9);
else
    D2 = num2cell(solved);
end

h1 = uitable('Data',D1,'FontSize',16,'ColumnWidth',...
    num2cell(repmat(30,1,9)),'columne',false(1,9));
set(h1,'units','norm','position',[.05 .05 .4 .9]);
h2 = uitable('Data',D2,'FontSize',16,'ColumnWidth',num2cell(repmat(30,1,9)));
set(h2,'units','norm','position',[.55 .05 .4 .9]);