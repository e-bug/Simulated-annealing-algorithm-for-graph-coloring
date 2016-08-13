clc
clear

N=1000;
q=5;

maxIter = 20000;

% initial beta
beta_0 = maxIter/1000;

lower_bound = 0;
upper_bound = 1000;

vett_c = 2:1:8;


    avg=zeros(1,length(vett_c));
    variance=zeros(1,length(vett_c));

    for m = 1:length(vett_c)
        
        c = vett_c(m);
        
        trials = 10;

        count = 0;

        h_fin = ones(1, trials);
        h_min = ones(1, trials);

        betav=zeros(1,maxIter);
        
        for k = 1:trials

            % Takes in input the adjacent matrix
            [G,vertex_color]= generate_graph(N,c,q);

            h_vett = zeros(1,maxIter);

            % calcolo H inizialeif beta > lower_bound && beta < upper_bound
            h = h_init(G, vertex_color, N);
            
            stepboost=1500;
          
            
            h_vett(1) = h;
            count = 0;
            h_min(k) = h;
    
            h_step = 0;
    
            beta=beta_0;
            

            for step=2:maxIter        
                % choose vertex to change
                v = ceil(rand(1,1)*N);

                % choose color to change
                color_new = ceil(rand(1,1)*q);

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

       if step>maxIter/5
             if count == maxIter/300           
                 h_step=h;
                 beta=maxIter/50/h_step;
                 stepboost=step;
                 
             end
                 
             if (step<stepboost+maxIter/1000) && (step<(1-0.05)*maxIter) 
                 beta=beta+maxIter/50/h_step/(maxIter/1000);         
             else
                 beta=beta_0;
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
    legend('boost')
    hold on
    grid on
     

    subplot(1,2,2)
    plot(vett_c, variance);
    legend('boost')
    xlabel('c')
    ylabel('variance residual energy')
    grid on
    hold on