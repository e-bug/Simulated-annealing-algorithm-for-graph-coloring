function [ delta ] = compute_delta( v_adj, vertex_color, N, v, color_new )
%% difference of number bad pairs between new proposed and old config           
   
%  delta = "new - old"
    
    delta = 0;
    
    for i=1:N
      % vertex is adjacent?
      if (v_adj(i)==1) 
          % in the old config, did they have same color?
          if(vertex_color(i)== vertex_color(v))
              delta=delta-1;
          end
          % in the new config, do they have same color?
          if(vertex_color(i)== color_new)
            delta = delta+1;            
          end
       end
    end

end

