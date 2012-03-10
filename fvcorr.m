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
    
    % Create title
    title({'Correlations for Z Scores, ADHD (1 to 101) vs Control (102 to 189)'});

    % Create line
    annotation('line',[0.1296875 0.90546875],...
    [0.49 0.49],'LineWidth',4);

    % Create line
    annotation('line',[0.5375 0.5375],...
    [0.114068441064639 0.923954372623574],'LineWidth',4);

    % Create textbox
    annotation('textbox',...
    [0.0385 0.699619771863118 0.0630625 0.0380228136882123],'String',{'ADHD'},...
    'FitBoxToText','off',...
    'LineStyle','none');

    % Create textbox
    annotation('textbox',...
    [0.702718750000003 0.0189353612167299 0.0630625 0.0380228136882123],...
    'String',{'CONTROL'},...
    'FitBoxToText','off',...
    'LineStyle','none');

    % Create textbox
    annotation('textbox',...
    [0.03584375 0.268973384030418 0.0630625 0.0380228136882123],...
    'String',{'CONTROL'},...
    'FitBoxToText','off',...
    'LineStyle','none');

    % Create textbox
    annotation('textbox',...
    [0.298343750000001 0.0142205323193915 0.0630625 0.0380228136882123],...
    'String',{'ADHD'},...
    'FitBoxToText','off',...
    'LineStyle','none');

end