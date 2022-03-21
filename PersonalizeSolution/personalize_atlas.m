function personalize_atlas(fc,k,cortex_only,out_path)
%% Find individualized neonatal parcellation
% author: Fiona Molloy
% cite

%% inputs
% fc= your functional connectivity matrix (in Schuh et al. 2018 2x2x2 mm
% space, masked by gray matter (cortex and subcortical)
% mask [included in /PersonalizeSolution/Masks]).
% size should = 23,841 x 23,841

% k = '5' or '8'
% total number of networks. k = 8 only for cortex-only

% cortex_only='y' (yes) or 'n' (no, whole-brain)

% outpath = '~/your_parcellation.nii'
% path to write personalized atlas, as nifti file

%%
k_num=str2double(k);

if sum(size(fc) == [23841, 23841]) ~= 2
    disp('Incorrect size for connectome. Must be 23,841 by 23,841')
    return
end

if strcmp(cortex_only,'y')
    disp('Calculating cortical parcellation...')
    if isempty(intersect (k_num,[5 8]))
        disp('Error: optimal solutions for cortex are k = 5 or 8')
        return
    end
    %load cortex indices
    load('Masks/cortex_ind.mat');
    %load cortex mask
    load(['GroupCentroids/cortex_k' k '.mat']);
    %get only cortex of connectomes
    conn=fc(cortical_indices_connectome,cortical_indices_connectome);
    %find only the non-na values
    i_cls = NaN(size(cls));
    non_na=find(~isnan(conn(1,:)));
    na_ind=find(isnan(conn(1,:)));
    
    %k-nearest neighbors
    i_cls(non_na)=kmeans(conn(non_na,non_na),k_num,'Distance','correlation','Display','off', 'MaxIter',1,'Start',C(:,non_na));
    
    filepath='Masks/cortex_mask.nii.gz';
    
    %make nifti
    temp = niftiread(filepath);
    temp_info=niftiinfo(filepath);
    
    idx = find(temp(:,:,:));
    [x,y,z] = ind2sub(size(temp(:,:,:)), idx);
    
    i_cls(na_ind)=0;
    
    for i=1:20130
        temp(x(i),y(i),z(i))=i_cls(i);
    end
    
    niftiwrite(temp,out_path,temp_info);
    
else
    if strcmp(cortex_only,'n')
        disp('Calculating whole-brain parcellation...')
        if isempty(intersect (k_num,[5]))
            disp('Error: only optimal solutions for whole-brain is k = 5 ')
            return
        end
        
        load(['GroupCentroids/wholebrain_k' k '.mat']);
        i_cls = NaN(size(cls));
        
        non_na=find(~isnan(fc(1,:)));
        na_ind=find(isnan(fc(1,:)));
        
        %k-nearest neighbors
        i_cls(non_na)=kmeans(fc(non_na,non_na),k_num,'Distance','correlation','Display','off', 'MaxIter',1,'Start',C(:,non_na));
        
        %make nifti
        filepath='Masks/wholebrain_mask.nii.gz';
        
        temp = niftiread(filepath);
        temp_info=niftiinfo(filepath);
        
        idx = find(temp(:,:,:)); % find nonzero values in M
        [x,y,z] = ind2sub(size(temp(:,:,:)), idx);
        
        i_cls(na_ind)=0;
        
        for i=1:23841
            temp(x(i),y(i),z(i))=i_cls(i);
        end
        
        niftiwrite(temp,out_path,temp_info);
        
        
    else
        disp('Error: please check cortex_only input')
        return
    end
end


