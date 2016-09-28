function [scaled_vector] = scale(vector)
scaled_vector = (vector - min(vector))/(max(vector)-min(vector));
end

