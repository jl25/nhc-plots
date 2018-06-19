% Import Data
addpath('scripts')
err1 = importdata('txt/intensity_errors.txt');
err2 = importdata('txt/intensity_errors2.txt');

% Create the error matrix
err_h0 = vertcat(err1(:, 2), err2(:, 2));
err_h12 = vertcat(err1(:, 4), err2(:, 4));
err_h24 = vertcat(err1(:, 6), err2(:, 6));
err_h36 = vertcat(err1(:, 8), err2(:, 8));
err_h48 = vertcat(err1(:, 10), err2(:, 10));
err_h72 = vertcat(err1(:, 12), err2(:, 12));
err_h96 = vertcat(NaN(size(err1, 1), 1), err2(:, 14));
err_h120 = vertcat(NaN(size(err1, 1), 1), err2(:, 16));
years = 1990:2017;

errs = horzcat(err_h12, err_h24, err_h36, err_h48, err_h72, err_h96, err_h120);
errs = errs * 1.15078; % kts to mph
l_colors = hsv(size(errs, 2));
hs = zeros(size(errs, 2), 1);

% Plot the errors
figure('units','normalized','outerposition',[0 0 0.7 0.7]);
for i = 1:size(errs, 2)
    xx = years(~isnan(errs(:, i)));
    yy = errs(~isnan(errs(:, i)), i);
    
    p = polyfit(xx', yy,1); 
    f = polyval(p,xx); 
    plot(xx', yy, '-x', 'Color', l_colors(i, :), 'Linewidth', 2); hold on;
    hs(i) = plot(xx',f,'--', 'Color', l_colors(i, :), 'Linewidth', 1);
    legend('data','linear fit') 
end
legend(hs, strcat(arr_to_cell_str([12 24 36 48 72 96 120]), 'h'), ...
       'Orientation', 'Horizontal')
set(gca, 'Fontsize', 20, 'Fontweight', 'Bold'); grid on;
ylabel('Forecast Error (mph)'); xlabel('Year'); 
xlim([min(years) max(years)]); ylim([0 40]);