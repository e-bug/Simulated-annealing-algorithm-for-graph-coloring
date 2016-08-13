%% The script loads the adjacent matrix and save the best config which minimizes the residual energy

clc
clear

% set problem
N=100;
c=5;
q=3;

trials = 10;

maxIter = 5000;

% initial beta
beta_0 = maxIter/1000;

% variable which counts how many times consecutively I reject
% when count becomes big --> I am stuck in a minimum
count = 0;

% array of the value of beta over time
betav=zeros(1,maxIter);

% minimum value of h ever reached during all iterations
h_best = N;

% array of minimum value of h of each trial
h_min = ones(1,trials);

for k = 1:trials
    
    % Take in input the adjacent matrix
    B=load('graph_adjacency_matrix.mat');
    G = B.A;
    
    % generate casual initial configuration
    vertex_color = ceil(rand(1,N)*q);
    
    h_vett = zeros(1,maxIter);

    step_boost=maxIter;
    
    % compute initial H
    h = h_init(G, vertex_color, N);
    
    h_min(k)=h;
    h_vett(1) = h;
    count = 0;
    h_step = 0;
    beta=beta_0;
    
    for step=2:maxIter        
        % choose vertex to change
        v = ceil(rand(1,1)*N);

        % choose color to change
        color_new = ceil(rand(1,1)*q);
        
        % array of node connected to the choosen one
        v_adj = G(:,v);

        % compute delta
        delta = compute_delta(v_adj, vertex_color, N, v, color_new);
        
        
        % accept or reject based on metropolis algorithm
        [h, h_min(k), count, vertex_color] = accept_reject(delta, vertex_color, h, ...
                                             beta, h_min(k), v, count, color_new);
                
        h_vett(step) = h;

        % Do I find a proper coloring?
        if h==0
            break 
        end

      % in the first phase i keep the temperature low
      if step>maxIter/5
          % i am not in the first phase
             if count == maxIter/300
                 % I am stuck in a minimum
                 % update beta --> i increase temperature for some steps
                 h_step=h;
                 beta=maxIter/50/h_step;
                 step_boost=step;

             end
                 
             if (step<step_boost+maxIter/1000) && (step<(1-0.05)*maxIter)
                 % I keep the temperature high for only a certain number of
                 % steps
                 
                 % it is better not to increase the temperature when I am
                 % close to the final iteration --> I don't want to go far
                 % from the minimum reached at the end...
                 
                 beta=beta+maxIter/50/h_step/(maxIter/1000);    
                 
             else
                 % update the beta at the default value (low temperature)
                 beta = beta_0;
             end
      end
    end
    
    % do I find a better configuration in this trial?
    % I update the result
    if (h_best > h_min(k))
        % record data
        result.colors = vertex_color;
        result.energy = h_min(k);
        result.final_step = step;
    end
   
 
end

% save result
save('result_404.mat', 'result');