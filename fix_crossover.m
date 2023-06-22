%%交叉操作
%input：pop：父代种群，pc：交叉的概率
%output：newpop：交叉后的种群
function [new_pop] = crossover(pop, PCint, x, a, b, i, max_gen)
% pop = new_pop1;
[px, ~] = size(pop);
% 判断路径点数是奇数或是偶数
parity = mod(px, 2);
new_pop = {};

% 计算新种群的适应度值,并排序
path_value = cal_path_value(pop, x);
path_smooth = cal_path_smooth(pop, x);
fit_value = a .* path_value .^ -1 + b .* path_smooth .^ -1;
[~, index_fit] = sort(fit_value);
for i = 1 : px
    pop_index{i, 1} = pop{index_fit(i), 1};
end

% 将种群分为高质量种群和低质量种群
high_pop_index = pop_index(1 : floor(px/2));
low_pop_index = pop_index(floor(px/2) + 1 : end);
[high_size, ~] = size(high_pop_index);
[low_size, ~] = size(low_pop_index);

% 循坏选择交叉
for i = 1 : 2 : px-1
    % 随机从高质量种群和低质量种群分别选出一个
    high_index = randi(high_size);
    low_index = randi(low_size);
    high_pop_crossover = high_pop_index{high_index, 1};
    low_pop_crossover = low_pop_index{low_index, 1};
    %crossover_point = randi(min(size(high_pop_crossover), size(low_pop_crossover)));
    [lia, locb] = ismember(high_pop_crossover, low_pop_crossover);
    [~, n] = find(lia == 1);  % 要查找特定的值，使用==。返回找到的值在lia中的索引
    [~, m] = size(n);
    % 若随机数小于交叉概率，且A中有三个以上路径节点与B中的相同
    if rand < PCint - 0.2*(i/max_gen) && (m >= 3)
        % 生成一个2到m-1的随机数(去除开头和结尾)，在两条路径的相同节点中随机选取一个节点用于交叉
        r = round(rand(1,1)*(m-3)) + 2;
        crossover_index1 = n(1, r);
        crossover_index2 = locb(crossover_index1);
        crossover_child1 = [high_pop_crossover(1 : crossover_index1), low_pop_crossover(crossover_index2+1 : end)];
        crossover_child2 = [low_pop_crossover(1 : crossover_index2), high_pop_crossover(crossover_index1+1 : end)];
        four_pop(1, 1) = {high_pop_crossover};
        four_pop(2, 1) = {low_pop_crossover};
        four_pop(3, 1) = {crossover_child1};
        four_pop(4, 1) = {crossover_child2};
        % 计算适应度值并排序，选出前两个体
        path_value = cal_path_value(four_pop, x);
        path_smooth = cal_path_smooth(four_pop, x);
        fit_value = a .* path_value .^ -1 + b .* path_smooth .^ -1;
        [~, index_fit] = sort(fit_value);
        for j = 1 : 4
            four_pop_index{j, 1} = four_pop{index_fit(j), 1};
        end
        new_pop{i, 1} = four_pop_index{3, 1};
        new_pop{i+1, 1} = four_pop_index{4, 1};
        % 否则不交叉
    else
        new_pop{i, 1} = high_pop_crossover;
        new_pop{i+1, 1} = low_pop_crossover;
    end
    if parity == 1
        new_pop{px, 1} = pop{px, 1};
    end
end
end




% 两两交叉
% for i = 1 : 2 : px-1
%     singal_now_pop = pop{i, 1};
%     singal_next_pop = pop{i+1, 1};
%     % [lia, locb] = ismember(A,B)确定 A 的哪些元素同时也在 B 中及其在 B 中的相应位置
%     [lia, locb] = ismember(singal_now_pop, singal_next_pop);
%     [~, n] = find(lia == 1);  % 要查找特定的值，使用==。返回找到的值在lia中的索引
%     [~, m] = size(n);
%     % 若随机数小于交叉概率，且A中有三个以上路径节点与B中的相同
%     if (rand < PC) && (m >= 3)
%         % 生成一个2到m-1的随机数(去除开头和结尾)，在两条路径的相同节点中随机选取一个节点用于交叉
%         r = round(rand(1,1)*(m-3)) + 2;
%         crossover_index1 = n(1, r);
%         crossover_index2 = locb(crossover_index1);
%         new_pop{i, 1} = [singal_now_pop(1:crossover_index1), singal_next_pop(crossover_index2+1:end)];
%         new_pop{i+1, 1} = [singal_next_pop(1:crossover_index2), singal_now_pop(crossover_index1+1:end)];
%         % 否则不交叉
%     else
%         new_pop{i, 1} = singal_now_pop;
%         new_pop{i+1, 1} = singal_next_pop;
%     end
%     % 若有奇数条路径，除最后一条外，其余已按照if条件进行了交叉处理，因此最后一条不变
%     if parity == 1
%         new_pop{px, 1} = pop{px, 1};
%     end
% end
