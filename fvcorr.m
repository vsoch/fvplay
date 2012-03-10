% fvcorr takes as input a data matrix and associated labels (in format -1 and 1)
% and calculates the cross correlation matrix.
% USAGE: fvcorr(data, labels)
% INPUT: 
%	 data: a n x M matrix with n subjects, m columns of features
%    labels: a n X 1 column of labels, 0 and 1
% OUTPUT: ccdata: cross correlation matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function corr_matrix = fvcorr(alldata,labels) 
    % Separate groups
    tot_size = size(alldata,1);
    adhd = alldata(labels == 1,:);
    ctrl = alldata(labels == 0,:);
    
    % Calculate means and total size
    means = mean(alldata);
    tot_size = size(adhd,1) + size(ctrl,1);
    
    % Create a square matrix to hold alldata n X alldata n correlations
    corr_matrix = zeros(tot_size);

    % Scale data to be between 0 and 1
    % Since we are using Z scores, these are already normalized
    
    % Plot cc matrix
    for j=1:tot_size
        for k=j:tot_size
                
        if k <= size(adhd,1) && j <= size(adhd,1)
            % j and k are both adhd
            dat_j = adhd(j,:);
            dat_k = adhd(k,:);
        elseif k <= size(adhd,1) && j > size(adhd,1)
            % k is adhd, j is control
            dat_j = ctrl(j-size(adhd,1),:);
            dat_k = adhd(k,:);
        elseif k > size(adhd,1) && j > size(adhd,1)
            % k is control, j is control
            dat_j = ctrl(j-size(adhd,1),:);
            dat_k = ctrl(k-size(adhd,1),:);
        elseif k > size(adhd,1) && j <= size(adhd,1)
            % k is control,  j is adhd
            dat_j = adhd(j,:);
            dat_k = ctrl(k-size(adhd,1),:);
        end
        
        % Do correlations and save value to matrix
        answer = corrcoef(dat_j,dat_k);
        corr_matrix(j,k) = answer(1,2);
        
    end
   
    figure(1);
    imagesc(corr_matrix);
    colormap(hot);
end