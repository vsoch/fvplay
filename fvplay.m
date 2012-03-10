function data = fvplay(fv,type)
% fvplay takes as input an fv data object prepared by fvprep, and
% allows the user to select a transform to plot (to explore the data)
% Returns the data, and next use fvplot to display plot in figures 1 and 2
%
% USAGE: fvplot(fvobject,type)
% INPUT: fv: the fv data object prepared by fvprep
%	 type: options include:
%			quad: quadratic transformation
%			sqrt: square root transform
%			exp: exponential transformation
%			sig: sigmoid transformation
%			log: logarithmic transformation
%			abs: absolute value transform
% OUTPUT: data: transformed n x m data matrix with n subjects (rows)
%		and m features (columns)
%
% LOG TRANSFORM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LOG (subtract mean, take log)
if strcmp(type,'log')

data = zeros(size(fv.features_vectors,1),length(fv.features_vectors));
for i=1:size(fv.features_vectors,1)
    for j=1:length(fv.features_vectors)
        data(i,j) = log(abs(fv.features_vectors(i,j) - fv.m(i)));
    end
end

% SQUARE ROOT TRANSFORM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif strcmp(type,'sqrt')
data = zeros(size(fv.features_vectors,1),length(fv.features_vectors));
for i=1:size(fv.features_vectors,1)
    for j=1:length(fv.features_vectors)
        data(i,j) = sqrt(abs(fv.features_vectors(i,j) - fv.m(i)));
    end
end

% QUADRATIC TRANSFORM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif strcmp(type,'quad')
data = zeros(size(fv.features_vectors,1),length(fv.features_vectors));
for i=1:size(fv.features_vectors,1)
    for j=1:length(fv.features_vectors)
        data(i,j) = (fv.features_vectors(i,j) - fv.m(i)) .* (fv.features_vectors(i,j) - fv.m(i));
    end
end

% EXPONENTIAL TRANSFORM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif strcmp(type,'exp')
data = zeros(size(fv.features_vectors,1),length(fv.features_vectors));
for i=1:size(fv.features_vectors,1)
    for j=1:length(fv.features_vectors)
        data(i,j) = exp(fv.features_vectors(i,j) - fv.m(i));
    end
end


% ABS VALUE TRANSFORM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif strcmp(type,'abs')
data = zeros(size(fv.features_vectors,1),length(fv.features_vectors));
for i=1:size(fv.features_vectors,1)
    for j=1:length(fv.features_vectors)
        data(i,j) = abs(fv.features_vectors(i,j) - fv.m(i));
    end
end

% SIGMOID TRANSFORM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif strcmp(type,'sig')
data = zeros(size(fv.features_vectors,1),length(fv.features_vectors));
for i=1:size(fv.features_vectors,1)
    for j=1:length(fv.features_vectors)
        data(i,j) = smf(fv.features_vectors(i,j) - fv.m(i),[0 1]);
    end
end
end
end
