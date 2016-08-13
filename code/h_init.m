function [ h ] = h_init( G, vertex_color, N )

    h = 0;
    for i=1:N
        for j=i:N
        % vertex is adj ?
        % Have they got the same color?
            if (G(i,j) == 1 && (vertex_color(i) == vertex_color(j)))
                  h = h+1;
            end
        end
    end

end

