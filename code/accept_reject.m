function [ h, h_min, count, vertex_color] = accept_reject(delta, vertex_color, h, beta, h_min, v, count, color_new)
%% metropolis phase
    
    if delta <= 0
      % i accept and update config
      vertex_color(v) = color_new;
      h = h + delta;
      
      % I am no more stuck
      count = 0;
       
      % update min value of h
       if h_min >= h
          h_min = h;
       end
       
    else
                % acceptance probability
                  p = exp(-beta * delta);
                  
                  % realization of random variable Uniform [0 1]
                  a=rand(1,1);
                  
                  %accept with probability p
                  if (a < p)
                      % update config
                    vertex_color(v) = color_new;
                    h = h +delta;
                    
                    
                    % I am no more stuck
                    count=0;
                  else
                      % reject
                      % increase count
                      count=count +1;
                  end

     end

end