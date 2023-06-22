
%% 基于遗传算法的栅格法机器人路径规划
clc;
clear;
% 10*10
% Grid = [
%     0 0 0 0 0 0 0 0 0 0;
%     0 0 0 0 0 0 0 1 0 0;
%     0 0 0 1 0 0 0 1 1 0;
%     0 1 1 1 1 0 0 0 1 0;
%     0 0 0 1 0 0 0 0 0 0;
%     1 0 0 1 0 0 1 1 1 1;
%     1 0 0 0 0 0 1 1 0 0;
%     0 0 1 1 0 0 1 0 0 0;
%     0 1 1 1 0 0 0 0 0 0;
%     0 0 0 0 0 1 1 1 0 0;
%     ];

% 输入数据，栅格地图20*20
Grid1 = [
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 1 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0;
    0 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 1 1 1 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 1 1 1 0 1 0 1 1 0 0 0 0 0 0;
    0 1 1 1 0 0 0 0 0 0 1 0 1 1 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 1 1 0 1 1 1 1 0 0 0 0 0 0;
    0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 1 1 1 1 0;
    0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0;
    0 0 1 1 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 0;
    0 0 1 1 0 0 1 1 1 0 1 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 1 1 1 0 1 0 0 0 0 0 0 1 1 0;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 1 0;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
% 杨博实验栅格图
Grid1  = [
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 0 0 0;
    0 1 1 0 0 0 0 0 0 0 1 1 1 1 0 1 1 0 0 0;
    0 0 0 0 0 0 1 1 1 0 0 1 1 1 0 1 0 0 0 0;
    0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 1 0 0 0 0;
    0 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 1 1 1 0 0 1 1 1 0 1 0 1 1 0 0 0 0 0 0;
    0 0 0 0 0 0 1 1 1 0 1 0 1 1 0 0 0 0 0 0;
    0 1 1 1 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 1 0 1 1 1 1 0 0 0 0 0 0;
    0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 1 1 1 0 0 0 0 1 1 1 1 0;
    0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0;
    0 0 1 1 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0;
    0 0 1 1 0 0 1 1 0 0 1 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 1 1 1 1 0;
    0 0 1 0 1 0 0 0 0 0 0 1 0 0 1 0 0 1 1 0;
    0 0 1 1 1 0 1 1 0 0 0 0 0 0 1 0 0 1 1 0;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    ];
% 迷宫地图
Grid1 = [
    0 0 0 0 1 1 1 1 1 1 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 1;
    1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
    1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
    1 1 0 1 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 0 0 1 0 1 1;
    1 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 1;
    1 0 0 1 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 0 0 1 0 0 1;
    1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1;
    1 1 0 1 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 0 0 1 0 1 1;
    1 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 1;
    1 0 0 1 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 0 0 1 0 0 1;
    1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1;
    1 1 0 1 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 0 0 1 0 1 1;
    1 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 1;
    1 0 0 1 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 0 0 1 0 0 1;
    1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1;
    1 1 0 1 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 0 0 1 0 1 1;
    1 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 1;
    1 0 0 1 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 0 0 1 0 0 1;
    1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1;
    1 1 0 1 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 0 0 1 0 1 1;
    1 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 1;
    1 0 0 1 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 0 0 1 0 0 1;
    1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
    1 0 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0 0 1;
    1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
    1 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 1 1 1 1 0 1;
    1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 0 0;
    1 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 1 1 1 1 0 0;
    1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0;
    ];

% 张铮论文图;需要注释向下走
Grid1 = [
    0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0;
    0 0 1 1 0 0 0 0 0 0 1 1 0 0 1 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0;
    0 0 0 0 0 0 1 1 0 1 1 1 0 0 0 0 0 1 1 0;
    1 1 1 1 0 0 1 1 0 0 0 1 0 0 0 0 0 0 0 0;
    1 1 1 1 0 0 0 0 0 0 0 0 1 1 0 1 1 1 1 0;
    0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 1 1 1 1 0;
    0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 1 1 1 1 0;
    0 0 0 0 0 0 0 1 1 0 1 1 1 1 0 0 0 0 0 0;
    0 0 0 0 0 0 0 1 1 0 1 1 1 1 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 1 1 1 1 0 0 0 0 0 0;
    0 1 1 1 0 0 0 0 0 0 1 1 1 1 0 0 0 0 0 0;
    0 1 1 1 0 0 1 1 1 0 1 1 1 1 0 0 0 0 0 0;
    0 1 1 1 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0;
    0 1 1 1 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0;
    ];

% 自创
Grid = [
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0;
    0 0 1 1 0 0 1 1 0 0 0 0 0 0 0 0 1 0 0 0;
    0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 1 1 1 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0;
    0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0;
    0 0 1 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 0 0;
    0 0 1 1 0 0 1 0 0 0 1 0 1 1 0 0 0 0 0 0;
    0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 1 1 1 1 0 0 1 1 1 1 0 0 0 0 0 0;
    0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 1 1 1 1 0;
    0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0;
    0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 0 0;
    0 1 1 0 0 1 1 1 0 0 0 0 0 0 0 0 1 1 0 0;
    0 0 1 1 0 0 1 0 0 0 0 0 1 0 0 0 0 1 1 0;
    0 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 1 0;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    ];

% 迷宫地图30*30倒置
Grid1 = [
    0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 1 1 1 1 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 0 0;
    1 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 1 1 1 1 0 0;
    1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
    1 0 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0 0 1;
    1 0 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0 0 1;
    1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
    1 0 0 1 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 0 0 1 0 0 1;
    1 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 1;
    1 1 0 1 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 0 0 1 0 1 1;
    1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1;
    1 0 0 1 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 0 0 1 0 0 1;
    1 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 1;
    1 1 0 1 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 0 0 1 0 1 1;
    1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1;
    1 0 0 1 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 0 0 1 0 0 1;
    1 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 1;
    1 1 0 1 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 0 0 1 0 1 1;
    1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1;
    1 0 0 1 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 0 0 1 0 0 1;
    1 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 1;
    1 1 0 1 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 0 0 1 0 1 1;
    1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
    1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 0 1;
    1 0 0 1 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 0 1 1 1 1 1 0 1;
    1 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 0 1;
    1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 1 1 1 1 1 1 0 0 0 0 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0;
    ];

start_num = 0;  % 起点编号
end_num = 399;  % 终点编号
n_pop = 50;    % 种群数量
max_gen = 200;   % 最大迭代次数
PCint = 0.8;     % 交叉概率
PMint = 0.02;    % 变异概率
a = 8;          % 路径长度比重
b = 2;          % 路径顺滑度比重
z = 1;
new_pop1 = {};   % 元胞数组，存放路径
[y, x] = size(Grid);
% 起点所在行(从左到右编号1，2，3……)
start_column = mod(start_num, x) + 1;
% 起点所在行(从上到下1，2，3……)
start_row = fix(start_num / x) + 1;
% 终点所在列、行
end_column = mod(end_num, x) + 1;
end_row = fix(end_num / x) + 1;

%% step1 随机选取必经节点(从起点所在行开始往上，在每行挑选一个自由栅格，为必经节点)。将选取的必经节点联结成无间断的路径
pop_num = 1;
while pop_num <= n_pop
    pass_num = end_row - start_row + 1;  % 每条路径的节点个数
    pop = zeros(n_pop, pass_num);        % 生成种群数量*节点个数的矩阵，用于存放每个个体的路径
    for i = 1 : n_pop                    % 每个个体(每行)循环操作
        pop(i, 1) = start_num;           % 每行第一列都为起点(存入起点的编号)
        j = 1;
        % 此for循环用于寻找去除起点和终点所在行以外每行中的自由栅格
        for row_i = start_row + 1 : end_row - 1
            j = j + 1;
            % 存放栅格里当前行中的自由栅格序号
            free = [];
            for column_i = 1 : x         % 从第一列到第二十列
                % 栅格对应的序号
                num = (column_i - 1) + (row_i - 1) * x;
                % 如果该栅格为非障碍物
                if Grid(row_i, column_i) == 0
                    % 把此栅格的编号加入free矩阵
                    free = [free num];
                end
            end                          % 栅格一行里的自由栅格查询结束，自由栅格的编号存在了向量中

            free_num = length(free);
            % 产生小于等于本行自由栅格数量的一个随机整数
            index = randi(free_num);
            % 将栅格中当前行的自由栅格矩阵free中第index个栅格编号做为当前种群的第j个节点
            pop(i, j) = free(index);
        end                              % 该个体的每一行的路径节点产生完成,存入了pop的第i行中
        pop(i, end) = end_num;           % pop的每行最后一列都为终点

        % 种群初始化，将上述必经节点联结成无间断路径
        single_new_pop = generate_continuous_path(pop(i, :), Grid, x);
        if ~isempty(single_new_pop)      % 如果这一行种群的路径不是空，将这行路径存在入元胞数组中
            new_pop1(z, 1) = {single_new_pop};
            z = z + 1;
            pop_num = max(size(new_pop1));
        end
    end
end
pop_num1 = max(size(new_pop1));
if pop_num1 > n_pop
    new_pop1 = new_pop1(1:n_pop,1);
end
%% step2 路径长度和路径平滑度加权构成种群的适应度
% 计算路径长度
path_value = cal_path_value(new_pop1, x);
% 计算路径平滑度
path_smooth = cal_path_smooth(new_pop1, x);
fit_value = a .* path_value .^ -1 + b .* path_smooth .^ -1;

mean_path_value = zeros(1, max_gen);
min_path_value = zeros(1, max_gen);
%% step3 循环迭代
% sum_min_path_value = 0;
% C = 100;
% for circulation = 1 : C
for i = 1 : max_gen
    % 选择
    [elite, new_pop2]= elite_selection(new_pop1, fit_value, x, a, b);
    % new_pop2 = fix_selection(new_pop1, fit_value, x, a, b);
    % new_pop2 = selection(new_pop1, fit_value);
    best_path_value = cal_path_value(elite, x);
    best_path_smooth = cal_path_smooth(elite, x);
    best_elite_fit = a .* best_path_value .^ -1 + b .* best_path_smooth .^ -1;

    % 交叉
    %     new_pop2 = crossover(new_pop2, PC);
    new_pop2 = fix_crossover(new_pop2, PCint, x, a, b, i, max_gen);

    % 变异
    new_pop2 = mutation(new_pop2, PMint, Grid, x, i, max_gen);

    % 更新种群
    new_pop1 = new_pop2;

    % 计算适应度值
    path_value = cal_path_value(new_pop1, x);
    path_smooth = cal_path_smooth(new_pop1, x);
    fit_value = a .* path_value .^ -1 + b .* path_smooth .^ -1;
    mean_path_value(1, i) = mean(path_value);
    [~, m] = max(fit_value);
    if best_elite_fit > max(fit_value)
        new_pop1{m, 1} = elite;
        min_path_value(1, i) = best_path_value;
    else
        min_path_value(1, i) = path_value(1, m);
    end
end
%% 3.1 迭代结束，优化最优路径
%   % 根据适应度值获取最优路径
[~, m] = max(fit_value);
best_path = new_pop1{m,1};
best_path_new_pop1 = best_path;
[~, best_path_num] = size(best_path);
delete_point = {};
delete_point_num = 1;
start_num = 2;
end_num = best_path_num - 1;
% 遍历路径
%   for i_delete_num = start_num : 1 : end_num
while start_num < end_num
    % 获取当前节点以及它的左、右节点
    column_now = mod(best_path(1, start_num), x) + 1;
    row_now = fix(best_path(1, start_num) / x) + 1;
    % 左节点
    column_left = column_now - 1;
    row_left = row_now;
    % 右节点
    column_right = column_now + 1;
    row_right = row_now;
    % 上节点
    column_up = column_now;
    row_up = row_now + 1;
    % 下节点
    column_down = column_now;
    row_down = row_now - 1;
    % 判断左右节点是为障碍物：若为无障碍物,则删除节点
    if column_left <= 0 || row_up > 20 || row_down <= 0
        start_num = start_num + 1;
        continue;
    elseif Grid(row_left, column_left) == 0 && Grid(row_right, column_right) == 0 && Grid(row_up, column_up) == 0 && Grid(row_down, column_down) == 0
        delete_point{1, delete_point_num} = best_path(start_num);
        delete_point_num = delete_point_num + 1;
        best_path(start_num) = [];
        new_best_path = best_path;
        [~, best_path_num] = size(best_path);
        end_num = best_path_num - 1;
        start_num = start_num + 1;
        continue;
    end
    start_num = start_num + 1;
end
  % 计算新生成的路径的路径长度
  new_best_path_value = cal_path_value(new_best_path, x);


%     sum_min_path_value = sum_min_path_value + min_path_value(1, end);
% end
% fprintf('%d 次平均最小路径长度 = %d', C, sum_min_path_value / 100)
% fprintf('\n')
% fprintf('%d 次平均最小路径长度 = ', C)
% disp(num2str(sum_min_path_value / C))
%% step4 画出迭代平均路径长度和最优路径长度
figure(1)
shoulian1 = plot(1:max_gen, mean_path_value, 'r');
shoulian1.LineWidth = 2;
hold on;
title(['收敛趋势']);
xlabel('迭代次数');
ylabel('路径长度');
shoulian2 = plot(1:max_gen, min_path_value, 'b');
shoulian2.LineWidth = 2;
legend('平均路径长度', '最优路径长度');
fprintf('最小路径长度 %d', min_path_value(1, end))
min_path_value(1, end)
fprintf('优化后的最小路径长度 %d', new_best_path_value)
new_best_path_value
fprintf('最优个体适应度值 %d', max(fit_value))
max(fit_value)
% 在地图上画路径
[~, min_index] = max(fit_value);
min_path = new_pop1{min_index, 1};
figure(2)
hold on;
% title(['a = ', num2str(a)', '，b = ',num2str(b)','遗传算法机器人运动轨迹']);
% title(['改进遗传算法机器人运动轨迹']);
xlabel('x');
ylabel('y');
DrawMap(Grid);
[~, min_path_num] = size(min_path);
for i = 1:min_path_num
    x_min_path(1, i) = mod(min_path(1, i), x) + 1;   % 路径点所在列（从左到右编号1.2.3...）
    y_min_path(1, i) = fix(min_path(1, i) / x) + 1;  % 路径点所在行（从上到下编号1.2.3...）
end
hold on;
p_old = plot(x_min_path, y_min_path,'r');
% p_old.LineStyle = '--';
p_old.LineWidth = 2;

[~, new_min_path_num] = size(new_best_path);
for i_new = 1:new_min_path_num
    x_new_min_path(1, i_new) = mod(new_best_path(1, i_new), x) + 1;   % 路径点所在列（从左到右编号1.2.3...）
    y_new_min_path(1, i_new) = fix(new_best_path(1, i_new) / x) + 1;  % 路径点所在行（从上到下编号1.2.3...）
end
save("paper_main_v1.mat", "y_new_min_path", "x_new_min_path");
hold on;
p_new = plot(x_new_min_path, y_new_min_path, 'b');
p_new.LineStyle = '-.';
p_new.LineWidth = 2;