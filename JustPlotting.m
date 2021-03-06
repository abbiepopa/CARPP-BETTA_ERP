%% Plot GNG
ERP = pop_ploterps( ERP, [ 1 2 ],  35 , 'AutoYlim', 'on', 'Axsize', [ 0.05 0.08], 'BinNum', 'on', 'Blc', 'pre', 'Box', [ 1 1], 'ChLabel',...
 'on', 'FontSizeChan',  10, 'FontSizeLeg',  12, 'FontSizeTicks',  10, 'LegPos', 'bottom', 'Linespec', {'r-' , 'g-' , 'b-' }, 'LineWidth',  4,...
 'Maximize', 'on', 'Position', [ -167.125 12.2778 106.875 31.9444], 'Style', 'Classic', 'Tag', 'ERP_figure', 'Transparency',  0, 'xscale',...
 [ -200.0 798.0   -200:200:600 ], 'YDir', 'normal' );

ERP = pop_ploterps( ERP, [ 1 2 4],  35 , 'AutoYlim', 'on', 'Axsize', [ 0.05 0.08], 'BinNum', 'on', 'Blc', 'pre', 'Box', [ 1 1], 'ChLabel',...
 'on', 'FontSizeChan',  10, 'FontSizeLeg',  12, 'FontSizeTicks',  10, 'LegPos', 'bottom', 'Linespec', {'r-' , 'g-' , 'b-' }, 'LineWidth',  4,...
 'Maximize', 'on', 'Position', [ -167.125 12.2778 106.875 31.9444], 'Style', 'Classic', 'Tag', 'ERP_figure', 'Transparency',  0, 'xscale',...
 [ -200.0 798.0   -200:200:600 ], 'YDir', 'normal' );
%% plot cold DT

ERP = pop_ploterps( ERP,  1:3,  35 , 'AutoYlim', 'on', 'Axsize', [ 0.05 0.08], 'BinNum', 'on', 'Blc', 'pre', 'Box', [ 1 1], 'ChLabel', 'on',...
 'FontSizeChan',  10, 'FontSizeLeg',  12, 'FontSizeTicks',  10, 'LegPos', 'bottom', 'Linespec', {'k-' , 'r-' , 'b-' }, 'LineWidth',  3,...
 'Maximize', 'on', 'Position', [ 89.6667 20.3077 106.833 31.9231], 'Style', 'Classic', 'Tag', 'ERP_figure', 'Transparency',  0, 'xscale',...
 [ -200.0 798.0   -200:200:600 ], 'YDir', 'normal' );
%% plot eDT 

%plotting angry
ERP = pop_ploterps( ERP, [ 1 2 5],  35 , 'AutoYlim', 'on', 'Axsize', [ 0.05 0.08], 'BinNum', 'on', 'Blc', 'pre', 'Box', [ 6 6], 'ChLabel',...
 'on', 'FontSizeChan',  10, 'FontSizeLeg',  12, 'FontSizeTicks',  10, 'LegPos', 'bottom', 'Linespec', {'k-' , 'r-' , 'b-' }, 'LineWidth',  3,...
 'Maximize', 'on', 'Position', [ 100.476 29.6429 106.857 31.9286], 'Style', 'Classic', 'Tag', 'ERP_figure', 'Transparency',  0, 'xscale',...
 [ -200.0 798.0   -200:200:600 ], 'YDir', 'normal' );


% plot happy
ERP = pop_ploterps( ERP, [ 3 4 6],  35 , 'AutoYlim', 'on', 'Axsize', [ 0.05 0.08], 'BinNum', 'on', 'Blc', 'pre', 'Box', [ 6 6], 'ChLabel',...
 'on', 'FontSizeChan',  10, 'FontSizeLeg',  12, 'FontSizeTicks',  10, 'LegPos', 'bottom', 'Linespec', {'k-' , 'r-' , 'b-' }, 'LineWidth',  3,...
 'Maximize', 'on', 'Position', [ 100.476 29.6429 106.857 31.9286], 'Style', 'Classic', 'Tag', 'ERP_figure', 'Transparency',  0, 'xscale',...
 [ -200.0 798.0   -200:200:600 ], 'YDir', 'normal' );