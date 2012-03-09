function fvplot(transform,fv)
% fvplot takes as input the output of fvplay (an n x m matrix with n objects / subjects (rows) and m features (columns) and plots a mean
% subtracted histogram and heat map.
%
% USAGE: fvplot(fvobject,type)
% INPUT: transform: transformed n x m data matrix, with n objects and m features
%         fv: fv data object
% OUTPUT: graphical... plots!
%
% PLOT DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x = transform(fv.index1,:)*fv.m';
xdat = transform(fv.index2,:);
%Aligning the axes
xmin = min(min(x));
xmax = max(max(x));
bins = [xmin : (xmax - xmin)/20 : xmax];

%Draw Fig 1
figure(1);
subplot(2,2,1);
hist(x, bins);
title([ 'Group 1 '] );
subplot(2,2,2);
imagesc(transform(fv.index1,:));
colormap(hot);

figure(1);
subplot(2,2,3);
xc = transform(fv.index2,:)*fv.m';
xcdat = transform(fv.index2,:);
hist(xc, bins);
title([ 'Group 2 ']);
subplot(2,2,4);
imagesc(transform(fv.index2,:));
colormap(hot);

pcPlotter(6,fv);

return
end

% Given a number i, plot the ith rank approximation and all the first i
% principal components
function pcPlotter(max_pc,fv)
%Step 1 : Take svds of you data
u = fv.u1;
s = fv.s1;
v = fv.v1;
uc = fv.u2;
sc = fv.s2;
vc = fv.v2;

figure(3);
subplot(2, max_pc+1, 1);
sred = s; sred(max_pc+1:end,max_pc+1:end) = sred(max_pc+1:end,max_pc+1:end).*0; 
group1_nrank_approx = u * sred * v';
imagesc(group1_nrank_approx);
colormap(hot);

subplot(2, max_pc+1, max_pc+1+1);
scred = sc; scred(max_pc+1:end,max_pc+1:end) = scred(max_pc+1:end,max_pc+1:end).*0; 
group2_nrank_approx = uc * scred * vc';
imagesc(group2_nrank_approx);
colormap(hot);

for i = 1 : max_pc
%Group1 (i'th principal component)
sred = s .* 0; sred(i,i) = s(i,i); 
group1_pc_i = u * sred * v'; 
subplot(2, max_pc+1, i+1);
imagesc(group1_pc_i);
colormap(hot);

%Group2 (i'th principal component)
scred = sc .* 0; scred(i,i) = sc(i,i); 
group2_pc_i = uc * scred * vc'; 
subplot(2, max_pc+1, max_pc+1+i+1);
imagesc(group2_pc_i);
colormap(hot);
end;
end
