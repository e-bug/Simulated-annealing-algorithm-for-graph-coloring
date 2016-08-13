clc
clear

N=1000;
q=5;

maxIter = 10000;

% initial beta
beta_0 = 1; 

% frequency of update beta
% every 10 steps I update beta
frequency = 10;

% bound for beta
lower_bound = 0;
upper_bound = 100;

%schedule used
schedule = @(x,y) [y - log(((x)/ maxIter) )*(x)/ maxIter;
                   y + 0.01
                   ];

num_sched = 2;

% I compute the average residual energy varying c
vett_c = 2:1:8;

for sch = 1:num_sched
    
    % average and variance of di h_min
    avg=zeros(1,length(vett_c));
    variance=zeros(1,length(vett_c));

    for m = 1:length(vett_c)
        
        c = vett_c(m);
        
        trials = 50;

        h_fin = ones(1, trials);
        h_min = ones(1, trials);

        betav=zeros(1,maxIter);
        
        for k = 1:trials

            % Takes in input the adjacent matrix
            [G,vertex_color]= generate_graph(N,c,q);

            h_vett = zeros(1,maxIter);

            % compute initial H
            h = h_init(G, vertex_color, N);

            h_vett(1) = h;
            count = 0;
            h_min(k) = h;
            beta = beta_0;

            for step=2:maxIter        
                % choose vertex to change
                v = ceil(rand(1,1)*N);

                % choose color to change
                color_new = ceil(rand(1,1)*q);
                
                % array of node connected to the choosen one
                v_adj = G(:,v);

                % compute delta
                delta = compute_delta(v_adj, vertex_color, N, v, color_new);

                [h, h_min(k), count, vertex_color] = accept_reject(delta, vertex_color, h, ...
                                                     beta, h_min(k), v, count, color_new);

                h_vett(step) = h;

                if h<=0
                    break
                end

               betav(step) = beta;

              if beta > lower_bound && beta < upper_bound
                  
               if mod(step,frequency)==0
                    b = schedule(step,beta);                  
                    beta = b(sch);
                    
               end
               
              end

            end  
            
            h_fin(k)=h_vett(step);

        end

        avg(m) = mean(h_fin);
        variance(m) = var(h_fin);
        
    end
     
    
    subplot(1,2,1)  
    plot(vett_c, avg);
    xlabel('c')
    ylabel('mean residual energy')
    hold on
    grid on
     

    subplot(1,2,2)
    plot(vett_c, variance);
    xlabel('c')
    ylabel('variance residual energy')
    grid on
    hold on
    

end
