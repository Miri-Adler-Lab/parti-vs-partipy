%% === ParTI Analysis ===
% usage:
%[arc, arcOrig, pc, errs, pval] = ParTI(...
%    geneExpression, 5, 8, [], [], 0, [], [], [], 0.05, prefix);
%
% ParTI argument map for this call:
%   1) DataPoints      = geneExpression
%   2) algNum          = 5      (PCHA algorithm)
%   3) dim             = 8      (PCA dimensionality inspected by ParTI)
%   4) DiscFeatName    = []     (no discrete feature labels)
%   5) EnMatDis        = []     (no discrete feature matrix)
%   6) cols            = 0      (booleanization helper; NOT delta)
%   7) ContFeatName    = []     (no continuous feature labels)
%   8) EnMatCont       = []     (no continuous feature matrix)
%   9) GOcat2Genes     = []     (no GO mapping matrix)
%  10) binSize         = 0.05   (enrichment bin size)
%  11) OutputFileName  = prefix (base name for output files)

%% DELTA NOTE (important):
% The ParTI(...) call below does NOT receive delta as an input argument.
% In this codebase, delta is hardcoded inside the ParTI package files at:
%  ..\parti\CalculateSimplexArchErrorsPCHA.m 
% 
%  The default runs set delta to 0.5.
%  To run all runs with delta = 0:
%   set delta=0 in the file above.
% For more details, see https://github.com/AlonLabWIS/ParTI
%%
% === Add required paths ===
addpath(genpath('/sci/labs/miri.adler/avia.walfisch/particode'));
%%
% === Locate CSV file in current folder ===
d = dir('*.csv');
if isempty(d)
    error('No CSV file found in the current directory.');
end
csv_filename = d(1).name;
[~, prefix, ~] = fileparts(csv_filename);  % sets prefix for all outputs
fprintf('Found CSV file: %s\n', csv_filename);

% === Start logging ===
timestamp = datestr(now, 'yyyymmdd_HHMM');
diary_filename = sprintf('%s_log_%s.txt', prefix, timestamp);
diary(diary_filename);

fprintf('[%s] Script started.\n', datestr(now, 'yyyy-mm-dd HH:MM:SS'));

% === Load gene expression data from CSV ===
t_load = tic;
geneExpressionStruct = importdata(csv_filename);
if ~isfield(geneExpressionStruct, 'data') || ~isfield(geneExpressionStruct, 'textdata')
    error('CSV file not loaded correctly. Check file path and format.');
end
geneNames = geneExpressionStruct.textdata(1, 2:end);  % row vector of gene names
geneExpression = geneExpressionStruct.data;           % matrix [cells x genes]
fprintf('Loaded gene expression in %.2f sec\n', toc(t_load));

% === Run ParTI ===
[arc, arcOrig, pc, errs, pval] = ParTI(...
    geneExpression, 5, 8, [], [], 0, [], [], [], 0.05, prefix);


fprintf('ParTI finished');

save([prefix '_arc.mat'],     'arc');
save([prefix '_arcOrig.mat'], 'arcOrig');
save([prefix '_errs.mat'],    'errs');
save([prefix '_pval.mat'],    'pval');

% === Run ParTI_lite on raw gene features ===
ParTI_lite(...
    geneExpression, 5, 8, [], [], 0, ...
    geneNames, geneExpression, [], 0.05, prefix, arcOrig);

% === Build GO matrix and run ParTI_lite on GO features ===
[GOExpression, GONames, ~, GOcat2Genes] = MakeGOMatrix(...
    geneExpression, upper(geneNames), ...
    {'MSigDB/c2.cp.v4.0.symbols.gmt', 'MSigDB/c5.all.v4.0.symbols.gmt'}, ...
    20);

ParTI_lite(...
    geneExpression, 5, 8, [], [], 0, ...
    GONames, GOExpression, [], 0.05, [prefix '_GO'], arcOrig);

diary off;
exit;
