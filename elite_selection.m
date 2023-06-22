%% 用轮盘赌选择个体
% input：pop元胞种群，fitvalue：适应度值
% output：new_pop选择以后的元胞种群
% function [new_pop] = selection(pop, fit_value)
function [elite, selection_new_pop] = selection(pop, fit_value, x, a, b)
%pop = new_pop1;
    [px, ~] = size(pop);
%     elite = {};
    % 初始种群适应度排序，同时种群按照适应度顺序排序
    [~, index_fit] = sort(fit_value);
    for i_index1 = 1 : px
        pop_index{i_index1, 1} = pop{index_fit(i_index1), 1};
    end

    elite = pop_index{end, 1};

    totale_fit = sum(fit_value);
    p_fit_value = fit_value / totale_fit;
    p_fit_value = cumsum(p_fit_value);
    % 随机数从小到大排列
    ms = sort(rand(px, 1));
    fitin = 1;
    newin = 1;
    while newin <= px
        if(ms(newin)) < p_fit_value(fitin)
            selection_new_pop{newin, 1} = pop{fitin, 1};
            newin = newin + 1;
        else
            fitin = fitin + 1;
        end
    end


%     totale_fit = sum(fit_value);
%     p_fit_value = fit_value / totale_fit;
%     p_fit_value = cumsum(p_fit_value);
%     % 随机数从小到大排列
%     ms = sort(rand(px, 1));
%     fitin = 1;
%     newin = 1;
%     while newin <= px
%         if(ms(newin)) < p_fit_value(fitin)
%             new_pop{newin, 1} = pop{fitin, 1};
%             newin = newin + 1;
%         else
%             fitin = fitin + 1;
%         end
%     end
% 
%     % 初始种群适应度排序，同时种群按照适应度顺序排序
% [~, index_fit] = sort(fit_value);
% for i_index1 = 1 : px
%     pop_index{i_index1, 1} = pop{index_fit(i_index1), 1};
% end
% 
% % 轮盘赌选择结果按照适应度排序，同时种群按照适应度顺序排序
% path_value = cal_path_value(new_pop, x);
% path_smooth = cal_path_smooth(new_pop, x);
% selection_fit_value = a .* path_value .^ -1 + b .* path_smooth .^ -1;
% [~, index_fit] = sort(selection_fit_value);
% for i_index2 = 1 : px
%     new_pop_index{i_index2, 1} = new_pop{index_fit(i_index2), 1};
% end
% 
% % 轮盘赌+精英选择
% if mod(px, 2) == 1
%     selection_new_pop = [pop_index( ceil(px/2) + 1 : end); new_pop_index( ceil(px/2) : end)];
% else
%     selection_new_pop = [pop_index(px/2 + 1: end); new_pop_index(px/2 + 1: end)];
% end
end