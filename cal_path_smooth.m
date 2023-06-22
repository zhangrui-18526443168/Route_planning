%% 计算路径平滑度函数
function [path_smooth] = cal_path_smooth(pop, x)
[n, ~] = size(pop);
path_smooth = zeros(1, n);
% 循环计算每一条路劲的平滑度
for i = 1 : n
    if n == 1
        single_pop = pop;
    else
        single_pop = pop{i, 1};
    end
    [~, m] = size(single_pop);
    % 路径有m个格子，需计算m-1次
    for j = 1 : m - 2
        x_now = mod(single_pop(1, j), x) + 1;   % 点i所在列（从左到右编号1.2.3...）
        y_now = fix(single_pop(1, j) / x) + 1;  % 点i所在行（从上到下编号1.2.3...）
        % 点i+1所在列、行
        x_next1 = mod(single_pop(1, j + 1), x) + 1;
        y_next1 = fix(single_pop(1, j + 1) / x) + 1;
        % 点i+2所在列、行
        x_next2 = mod(single_pop(1, j + 2), x) + 1;
        y_next2 = fix(single_pop(1, j + 2) / x) + 1;

        % 计算i与i+1的斜率
        if x_now ~= x_next1
            k1 = (x_next1 - x_now) / (y_next1 - y_now);
        else
            k1 = Inf;
        end
        % 计算i+1与i+2的斜率
        if x_next1 ~= x_next2
            k2 = (x_next2 - x_next1) / (y_next2 - y_next1);
        else
            k2 = Inf;
        end
        
         % 计算两条路径之间的夹脚
        a1 = (x_next1 - x_now) .^ 2 + (y_next1 - y_now) .^ 2;
        b1 = (x_next2 - x_next1) .^ 2 + (y_next2 - y_next1) .^ 2;
        c1 = (x_next2 - x_now) .^ 2 + (y_next2 - y_now) .^ 2;
        d = (a1 + b1 - c1) / (2 * sqrt(a1) * sqrt(b1));
        angle = acos(d);

        % 路径惩罚值
        if (k1 == Inf && k2 == Inf) || (k1 ~= Inf && k2 ~= Inf && k1 == k2)
            path_smooth(1, i) = path_smooth(1, i);
        elseif 0 < (pi - angle) && (pi - angle) < (pi / 2)
            path_smooth(1, i) = path_smooth(1, i) + 25;
        elseif pi - angle == (pi / 2)
            path_smooth(1, i) = path_smooth(1, i) + 50;
        elseif pi - angle == (3/2*pi)
            path_smooth(1, i) = path_smooth(1, i) + 100;
        else
            path_smooth(1, i) = path_smooth(1, i) + 200;
        end

%         c2 = (x_now - x_next2)^2 + (y_now - y_next2)^2;
%         %若大于4小于等于8，说明此栅格与隔一个的栅格隔一行或一列且列或行相邻
%         if c2 < 8 && c2 > 4
%             path_smooth(1, i) = path_smooth(1, i) + 5;
%         %若大于1小于等于4，说明此栅格与隔一个的栅格为对角，也可能或同行或同列垮了一格
%         elseif c2 <= 4 && c2 > 1
%             path_smooth(1, i) = path_smooth(1, i) + 30;
%         %若等于1，说明此栅格与隔一个的栅格是上下或左右相邻，其路径不如直接从此格到邻格，显然冗余了。
%         elseif    c2 <= 1
%             path_smooth(1, i) = path_smooth(1, i) + 5000;
%         %否则不设置值，也即值为0，此时此栅格与隔一个的栅格是正方形对角的关系，最好。
%         end
    end
end