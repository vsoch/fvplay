function fv = fvprep(inputdata,labels)
% fvprep: Prepares data objects for use with rest of package.
%
% USAGE: fvprep(rawdata,labels)
% INPUT: rawdata: an n x m matrix of doubles, with n objects / subjects 		(rows) each with m features (columns)
%        labels: a single column vector of size n x 1 with limited to
%		values of -1 and 1 to distinguish the two classes
% OUTPUT: fv.features_vectors: raw data
%	fv.index1 - indices in inputdata for label 1 (1)
%	fv.index2 - indices in inputdata for label 2 (-1)
%       fv.m      - all means of features (columns)
%       fv.u1, fv.s1, fv.v1: svd output for group 1
%	fv.u2, fv.s2, fv.v2: svd output for group 2
%
% PREPARING DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Prepare indices
fprintf('%s\n','Preparing data... group 1 = 1, group 2 = -1');
fv.features_vectors = inputdata;
fv.index1 = find(labels==1);
fv.index2 = find(labels==-1);

% Perform svd
fprintf('%s\n','Performing singular value decomposition (svd)...');
[fv.u1 fv.s1 fv.v1] = svd(inputdata(fv.index1,:));
[fv.u2 fv.s2 fv.v2] = svd(inputdata(fv.index2,:));

% Prepare mean vector
fv.m = mean(inputdata);

fprintf('%s\n','Finished preparing data.  Next, specify model.');

end
