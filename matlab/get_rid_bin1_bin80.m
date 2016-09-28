function [data_no_1_80] = get_rid_bin1_bin80(data)
pos = data(:,8);
%where_1 = find(pos == 1);
where_80 = find(pos == 80);
where_t = [where_80'];
where_t = sort(where_t);
data(where_t,:) = [];
data_no_1_80 = data;
end


