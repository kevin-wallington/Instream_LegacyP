%% Load data
Ch_file = strcat('C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\TxtInOut_never_norm_zeroPdis\channel_day.txt' );
Swat_output = readmatrix([Ch_file]);
WheresReach24 = find(Swat_output(:,6)==24);
Reach24 = Swat_output(WheresReach24,:);
WheresReach25 = find(Swat_output(:,6)==25);
Reach25 = Swat_output(WheresReach25,:);
WheresReach26 = find(Swat_output(:,6)==26);
Reach26 = Swat_output(WheresReach26,:);
WheresReach28 = find(Swat_output(:,6)==28);
Reach28 = Swat_output(WheresReach28,:);
WheresReach30 = find(Swat_output(:,6)==30);
Reach30 = Swat_output(WheresReach30,:);
WheresReach33 = find(Swat_output(:,6)==33);
Reach33 = Swat_output(WheresReach33,:);
simlength = length(Reach26);
hist_len = 7305;

Ch_never_data_out= zeros(simlength,6); % simlength number of days, 6 reaches [25,24,26,33,30,28]
Ch_never_data_out(:,1) = (Reach25(:,18))+(Reach25(:,20))+(Reach25(:,22))+ (Reach25(:,30));
Ch_never_data_out(:,2) = (Reach24(:,18))+(Reach24(:,20))+(Reach24(:,22))+ (Reach24(:,30));
Ch_never_data_out(:,3) = (Reach26(:,18))+(Reach26(:,20))+(Reach26(:,22))+ (Reach26(:,30));
Ch_never_data_out(:,4) = (Reach33(:,18))+(Reach33(:,20))+(Reach33(:,22))+ (Reach33(:,30));
Ch_never_data_out(:,5) = (Reach30(:,18))+(Reach30(:,20))+(Reach30(:,22))+ (Reach30(:,30));
Ch_never_data_out(:,6) = (Reach28(:,18))+(Reach28(:,20))+(Reach28(:,22))+ (Reach28(:,30));
Ch_never_data_in= zeros(simlength,6); % simlength number of days, 6 reaches [25,24,26,33,30,28]
Ch_never_data_in(:,1) = (Reach25(:,17))+(Reach25(:,19))+(Reach25(:,21))+ (Reach25(:,29));
Ch_never_data_in(:,2) = (Reach24(:,17))+(Reach24(:,19))+(Reach24(:,21))+ (Reach24(:,29));
Ch_never_data_in(:,3) = (Reach26(:,17))+(Reach26(:,19))+(Reach26(:,21))+ (Reach26(:,29));
Ch_never_data_in(:,4) = (Reach33(:,17))+(Reach33(:,19))+(Reach33(:,21))+ (Reach33(:,29));
Ch_never_data_in(:,5) = (Reach30(:,17))+(Reach30(:,19))+(Reach30(:,21))+ (Reach30(:,29));
Ch_never_data_in(:,6) = (Reach28(:,17))+(Reach28(:,19))+(Reach28(:,21))+ (Reach28(:,29));
R25_pass = sum(Ch_never_data_out(1:7305,1))/sum(Ch_never_data_in(1:7305,1));
R24_pass = sum(Ch_never_data_out(1:7305,2))/sum(Ch_never_data_in(1:7305,2));
R26_pass = sum(Ch_never_data_out(1:7305,3))/sum(Ch_never_data_in(1:7305,3));
R33_pass = sum(Ch_never_data_out(1:7305,4))/sum(Ch_never_data_in(1:7305,4));
R30_pass = sum(Ch_never_data_out(1:7305,5))/sum(Ch_never_data_in(1:7305,5));
R28_pass = sum(Ch_never_data_out(1:7305,6))/sum(Ch_never_data_in(1:7305,6));
Total_pass = R25_pass*R24_pass*R26_pass*R33_pass*R30_pass*R28_pass;

Ch_file = strcat('C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\TxtInOut_stop_norm_nowarmup\channel_day.txt' );
Swat_output = readmatrix([Ch_file]);
WheresReach24 = find(Swat_output(:,6)==24);
Reach24 = Swat_output(WheresReach24,:);
WheresReach25 = find(Swat_output(:,6)==25);
Reach25 = Swat_output(WheresReach25,:);
WheresReach26 = find(Swat_output(:,6)==26);
Reach26 = Swat_output(WheresReach26,:);
WheresReach28 = find(Swat_output(:,6)==28);
Reach28 = Swat_output(WheresReach28,:);
WheresReach30 = find(Swat_output(:,6)==30);
Reach30 = Swat_output(WheresReach30,:);
WheresReach33 = find(Swat_output(:,6)==33);
Reach33 = Swat_output(WheresReach33,:);
Ch_stop_data_out= zeros(simlength,6); % simlength number of days, 6 reaches [25,24,26,33,30,28]
Ch_stop_data_out(:,1) = (Reach25(:,18))+(Reach25(:,20))+(Reach25(:,22))+ (Reach25(:,30));
Ch_stop_data_out(:,2) = (Reach24(:,18))+(Reach24(:,20))+(Reach24(:,22))+ (Reach24(:,30));
Ch_stop_data_out(:,3) = (Reach26(:,18))+(Reach26(:,20))+(Reach26(:,22))+ (Reach26(:,30));
Ch_stop_data_out(:,4) = (Reach33(:,18))+(Reach33(:,20))+(Reach33(:,22))+ (Reach33(:,30));
Ch_stop_data_out(:,5) = (Reach30(:,18))+(Reach30(:,20))+(Reach30(:,22))+ (Reach30(:,30));
Ch_stop_data_out(:,6) = (Reach28(:,18))+(Reach28(:,20))+(Reach28(:,22))+ (Reach28(:,30));

PS_file = strcat('C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\pt052_stop.txt' );
PS_output = readmatrix([PS_file]);

Res_file = strcat('C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\TxtInOut_never_norm_zeroPdis\reservoir_day.txt' );
Res_output = readmatrix([Res_file]);
Res_out = Res_output(:,57)+Res_output(:,58)+Res_output(:,59)+Res_output(:,61);

hru_file = strcat('C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\TxtInOut_never_norm_zeroPdis\hru_ls_yr.txt' );
hru_output = readmatrix([hru_file]);
area_file = strcat('C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\hru_con.txt' );
area_output = readmatrix([area_file]);
hru_P = zeros(1,1387);
for ii=1:1387
    WheresHRU = find(hru_output(:,6)==ii);
    hru_row = hru_output(WheresHRU,:);
    hru_P_perha = sum(hru_row(1:20,10)) + sum(hru_row(1:20,13))+ sum(hru_row(1:20,15)) + sum(hru_row(1:20,17)) + sum(hru_row(1:20,18));
    hru_P(ii) = hru_P_perha * area_output(ii,4);
end
% US basins: 1-23, 25-27, 34, 40, 42, 43, 47
% US hrus: [1-573, 594-728, 940-960, 1140-1174, 1219-1288, 1354-1381]
% DS basins: not US, last is 48
% DS hrus: not US, last is 1387
NPS_upstream = sum(hru_P(1,[1:573, 594:728, 940:960, 1140:1174, 1219:1288, 1354:1381]))/20; %Total
NPS_downstream = sum(hru_P(1,[574:593, 729:939, 961:1139, 1175:1218, 1289:1353, 1382:1387]))/20; %Total
NPS_total = sum(hru_P)/20;

Res_export = sum(Res_out(1:7305))/20;
PS_total = sum(PS_output(1:7305,10))/20; %Total
P_never_outlet = sum(Ch_never_data_out(1:7305,6))/20;
P_stop_outlet = sum(Ch_stop_data_out(1:7305,6))/20; %Export

PS_export = P_stop_outlet - P_never_outlet; %Export
NPS_up_export = Res_export*Total_pass; %Export
NPS_down_export = P_never_outlet - NPS_up_export; %Export
TotalP = NPS_total + PS_total; %Total

PS_trap = PS_total - PS_export;
NPS_up_trap = NPS_upstream - NPS_up_export;
NPS_down_trap = NPS_downstream - NPS_down_export;
Total_trap = TotalP - P_stop_outlet;

PS_trap_percent = PS_trap/PS_total;
NPS_up_trap_percent = NPS_up_trap/NPS_upstream ;
NPS_down_trap_percent = NPS_down_trap/NPS_downstream ;
Total_trap_percent = Total_trap/TotalP ;

cats = categorical({'Point source', 'Non-PS, upstream', 'Non-PS, downstream', 'Total'});
cats = reordercats(cats,{'Point source', 'Non-PS, upstream', 'Non-PS, downstream', 'Total'});
bars = [PS_trap, PS_export; NPS_up_trap, NPS_up_export; NPS_down_trap, NPS_down_export; Total_trap, P_stop_outlet]./1000;
figure
bar(cats,bars,'stacked','FaceColor','flat')
b.CData(:,1) = [0 0.8 0.8]; %edit
b.CData(:,2) = [0 0.8 0.8]; %edit
ax = gca; % axes handle
ax.YAxis.Exponent = 0;
ytickformat('%,4.0f');
ax.FontSize = 22; 
legend('Trapped before outlet', 'Exported at outlet','Box','off','Location','northwest', 'fontsize', 26);
xlabel('Phosphorus source', 'fontsize', 26)
ylabel('Average annual phosphorus contribution [Mg/yr]', 'fontsize', 26)
