%% Load data
% % Need: loads at reaches 26,18,30,33 for each of cont, stop, never scenarios
% % Open a channel_day file just to establish the simuilation length and create Phos_Data array
% Ch_file = strcat('C:\Users\kevin\Documents\INFEWS\100 Param Sets_Stop\TxtInOut_001\channel_day.txt' );
% Swat_output = readmatrix([Ch_file]);
% WheresReach26 = find(Swat_output(:,6)==26);
% Reach26 = Swat_output(WheresReach26,:);
% simlength = length(Reach26);
% startfuture = 6576;
% futurelength = simlength-startfuture;
% Phos_Data = cell(100,3); % 100 parameter sets, 3 point source scenarios [1=stop,2=never,3=cont] - each cell is a simulation
% Phos_Data(:,:)= {zeros(simlength,4)}; % simlength number of days, 4 reaches [26,33,30,28]
% for ii=1:3 % point source scenario %1:3
%     if ii==1, scen_id = 'Stop';
%     elseif ii==2, scen_id = 'Never';
%     else, scen_id = 'Cont';
%     end
%     parpool("Processes",10);
%     parfor jj=1:100 % parameterization id %1:100
%         Iter_Data = zeros(simlength,4);
%         param_id = num2str(jj,'%03d');
%         Ch_file = strcat('C:\Users\kevin\Documents\INFEWS\100 Param Sets_',scen_id,'\TxtInOut_',param_id, '\channel_day.txt' );
%         Swat_output = readmatrix([Ch_file]);
%         WheresReach26 = find(Swat_output(:,6)==26);
%         Reach26 = Swat_output(WheresReach26,:);
%         WheresReach28 = find(Swat_output(:,6)==28);
%         Reach28 = Swat_output(WheresReach28,:);
%         WheresReach30 = find(Swat_output(:,6)==30);
%         Reach30 = Swat_output(WheresReach30,:);
%         WheresReach33 = find(Swat_output(:,6)==33);
%         Reach33 = Swat_output(WheresReach33,:);
%         % Alternative calc = (Reach26(:,38))+(Reach26(:,39))-(Reach26(:,37));
%         Iter_Data(:,1) = (Reach26(:,18))+(Reach26(:,20))+(Reach26(:,22))+ (Reach26(:,30));
%         Iter_Data(:,2) = (Reach33(:,18))+(Reach33(:,20))+(Reach33(:,22))+ (Reach33(:,30));
%         Iter_Data(:,3) = (Reach30(:,18))+(Reach30(:,20))+(Reach30(:,22))+ (Reach30(:,30));
%         Iter_Data(:,4) = (Reach28(:,18))+(Reach28(:,20))+(Reach28(:,22))+ (Reach28(:,30));
%         Phos_Data(jj,ii) = {Iter_Data};
%     end
%     delete(gcp('nocreate'))
% end

% Ch_file = strcat('C:\Users\kevin\Documents\INFEWS\100 Param Sets_stop\TxtInOut_045\channel_day.txt' ); % swap out "stop" for other scenarios as desired
% Swat_output = readmatrix([Ch_file]);
% Flow_045= zeros(simlength,4); % simlength number of days, 4 reaches [26,28,30,33]
% WheresReach26 = find(Swat_output(:,6)==26);
% Reach26 = Swat_output(WheresReach26,:);
% WheresReach28 = find(Swat_output(:,6)==28);
% Reach28 = Swat_output(WheresReach28,:);
% WheresReach30 = find(Swat_output(:,6)==30);
% Reach30 = Swat_output(WheresReach30,:);
% WheresReach33 = find(Swat_output(:,6)==33);
% Reach33 = Swat_output(WheresReach33,:);
% Flow_045 (:,1) = Reach26(:,9);
% Flow_045 (:,2) = Reach33(:,9);
% Flow_045 (:,3) = Reach30(:,9);
% Flow_045 (:,4) = Reach28(:,9);
% 
% Diff_Total_Stop = Reach26(:,39) + Reach33(:,39) + Reach30(:,39) + Reach28(:,39);
% NetEro_Total_Stop = Reach26(:,38) + Reach33(:,38) + Reach30(:,38) + Reach28(:,38) - ...
%   Reach26(:,37) - Reach33(:,37) - Reach30(:,37) - Reach28(:,37);


%% Load simulation with full 20 yr history printed to calculate P legacy buildup
% Ch_file = strcat('C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\TxtInOut_fullhist_stop\channel_day.txt' );
% Swat_output = readmatrix([Ch_file]);
% WheresReach26 = find(Swat_output(:,6)==26);
% Reach26 = Swat_output(WheresReach26,:);
% WheresReach28 = find(Swat_output(:,6)==28);
% Reach28 = Swat_output(WheresReach28,:);
% WheresReach30 = find(Swat_output(:,6)==30);
% Reach30 = Swat_output(WheresReach30,:);
% WheresReach33 = find(Swat_output(:,6)==33);
% Reach33 = Swat_output(WheresReach33,:);
% simlength = length(Reach26);
% startfuture = 7306;
% HistStop_Data = zeros(simlength,4); % simlength number of days, 4 reaches [26,28,30,33]
% CumP_stop = zeros(simlength,4);
% StopAcc_Data = zeros(simlength,4);
% HistStop_Data(:,1) = (Reach26(:,18))+(Reach26(:,20))+(Reach26(:,22))+ (Reach26(:,30));
% HistStop_Data(:,2) = (Reach33(:,18))+(Reach33(:,20))+(Reach33(:,22))+ (Reach33(:,30));
% HistStop_Data(:,3) = (Reach30(:,18))+(Reach30(:,20))+(Reach30(:,22))+ (Reach30(:,30));
% HistStop_Data(:,4) = (Reach28(:,18))+(Reach28(:,20))+(Reach28(:,22))+ (Reach28(:,30));
% HistStop_Conc(:,1) = (Reach26(:,44))+(Reach26(:,45))+(Reach26(:,46))+ (Reach26(:,47))*(0.3/1.5) + ...
%     0.01*((Reach26(:,40))+(Reach26(:,41))+(Reach26(:,42))+ (Reach26(:,43))*(0.3/1.5)); % *(.3/1.5)to adjust dissolved P by porosity and bulk density
% HistStop_Conc(:,2) = (Reach33(:,44))+(Reach33(:,45))+(Reach33(:,46))+ (Reach33(:,47))*(0.3/1.5) + ...
%     0.01*((Reach33(:,40))+(Reach33(:,41))+(Reach33(:,42))+ (Reach33(:,43))*(0.3/1.5));
% HistStop_Conc(:,3) = (Reach30(:,44))+(Reach30(:,45))+(Reach30(:,46))+ (Reach30(:,47))*(0.3/1.5) + ...
%     0.01*((Reach30(:,40))+(Reach30(:,41))+(Reach30(:,42))+ (Reach30(:,43))*(0.3/1.5));
% HistStop_Conc(:,4) = (Reach28(:,44))+(Reach28(:,45))+(Reach28(:,46))+ (Reach28(:,47))*(0.3/1.5) + ...
%     0.01*((Reach28(:,40))+(Reach28(:,41))+(Reach28(:,42))+ (Reach28(:,43))*(0.3/1.5));
% %Check raw accumulation
% StopAcc_Data(:,1) = (Reach26(:,17))+(Reach26(:,19))+(Reach26(:,21))+ (Reach26(:,29))-...
%     ((Reach26(:,18))+(Reach26(:,20))+(Reach26(:,22))+ (Reach26(:,30)));
% StopAcc_Data(:,2) = (Reach33(:,17))+(Reach33(:,19))+(Reach33(:,21))+ (Reach33(:,29))-...
%     ((Reach33(:,18))+(Reach33(:,20))+(Reach33(:,22))+ (Reach33(:,30)));
% StopAcc_Data(:,3) = (Reach30(:,17))+(Reach30(:,19))+(Reach30(:,21))+ (Reach30(:,29))-...
%     ((Reach30(:,18))+(Reach30(:,20))+(Reach30(:,22))+ (Reach30(:,30)));
% StopAcc_Data(:,3) = (Reach28(:,17))+(Reach28(:,19))+(Reach28(:,21))+ (Reach28(:,29))-...
%     ((Reach28(:,18))+(Reach28(:,20))+(Reach28(:,22))+ (Reach28(:,30)));
% StopAcc_Cum = cumsum(StopAcc_Data);
% StopAcc_Cum(:,1) = StopAcc_Cum(:,1)./ 4.62; StopAcc_Cum(:,2) = StopAcc_Cum(:,2)./ 12.47;
% StopAcc_Cum(:,3) = StopAcc_Cum(:,3)./ 17.07; StopAcc_Cum(:,4) = StopAcc_Cum(:,4)./ 36.54;
% PS_output =readmatrix('C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\pt052_stop.txt');
% Stop_PS = PS_output(:,10);
% 
% Ch_file = strcat('C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\TxtInOut_fullhist_never\channel_day.txt' );
% Swat_output = readmatrix([Ch_file]);
% startfuture = 7306;
% HistNever_Data = zeros(simlength,4); % simlength number of days, 4 reaches [26,28,30,33]
% CumP_never = zeros(simlength,4);
% NeverAcc_Data = zeros(simlength,4);
% WheresReach26 = find(Swat_output(:,6)==26);
% Reach26 = Swat_output(WheresReach26,:);
% WheresReach28 = find(Swat_output(:,6)==28);
% Reach28 = Swat_output(WheresReach28,:);
% WheresReach30 = find(Swat_output(:,6)==30);
% Reach30 = Swat_output(WheresReach30,:);
% WheresReach33 = find(Swat_output(:,6)==33);
% Reach33 = Swat_output(WheresReach33,:);
% HistNever_Data(:,1) = (Reach26(:,18))+(Reach26(:,20))+(Reach26(:,22))+ (Reach26(:,30));
% HistNever_Data(:,2) = (Reach33(:,18))+(Reach33(:,20))+(Reach33(:,22))+ (Reach33(:,30));
% HistNever_Data(:,3) = (Reach30(:,18))+(Reach30(:,20))+(Reach30(:,22))+ (Reach30(:,30));
% HistNever_Data(:,4) = (Reach28(:,18))+(Reach28(:,20))+(Reach28(:,22))+ (Reach28(:,30));
% HistNever_Conc(:,1) = (Reach26(:,44))+(Reach26(:,45))+(Reach26(:,46))+ (Reach26(:,47))*(0.3/1.5) + ...
%     0.01*((Reach26(:,40))+(Reach26(:,41))+(Reach26(:,42))+ (Reach26(:,43))*(0.3/1.5)); % adjust dissolved P by porosity and bulk density
% HistNever_Conc(:,2) = (Reach33(:,44))+(Reach33(:,45))+(Reach33(:,46))+ (Reach33(:,47)*(0.3/1.5)) + ...
%     0.01*((Reach33(:,40))+(Reach33(:,41))+(Reach33(:,42))+ (Reach33(:,43))*(0.3/1.5));
% HistNever_Conc(:,3) = (Reach30(:,44))+(Reach30(:,45))+(Reach30(:,46))+ (Reach30(:,47))*(0.3/1.5) + ...
%     0.01*((Reach30(:,40))+(Reach30(:,41))+(Reach30(:,42))+ (Reach30(:,43))*(0.3/1.5));
% HistNever_Conc(:,4) = (Reach28(:,44))+(Reach28(:,45))+(Reach28(:,46))+ (Reach28(:,47))*(0.3/1.5) + ...
%     0.01*((Reach28(:,40))+(Reach28(:,41))+(Reach28(:,42))+ (Reach28(:,43))*(0.3/1.5));
% %Check raw accumulation
% NeverAcc_Data(:,1) = (Reach26(:,17))+(Reach26(:,19))+(Reach26(:,21))+ (Reach26(:,29))-...
%     ((Reach26(:,18))+(Reach26(:,20))+(Reach26(:,22))+ (Reach26(:,30)));
% NeverAcc_Data(:,2) = (Reach33(:,17))+(Reach33(:,19))+(Reach33(:,21))+ (Reach33(:,29))-...
%     ((Reach33(:,18))+(Reach33(:,20))+(Reach33(:,22))+ (Reach33(:,30)));
% NeverAcc_Data(:,3) = (Reach30(:,17))+(Reach30(:,19))+(Reach30(:,21))+ (Reach30(:,29))-...
%     ((Reach30(:,18))+(Reach30(:,20))+(Reach30(:,22))+ (Reach30(:,30)));
% NeverAcc_Data(:,4) = (Reach28(:,17))+(Reach28(:,19))+(Reach28(:,21))+ (Reach28(:,29))-...
%     ((Reach28(:,18))+(Reach28(:,20))+(Reach28(:,22))+ (Reach28(:,30)));
% NeverAcc_Cum = cumsum(NeverAcc_Data);
% NeverAcc_Cum(:,1) = NeverAcc_Cum(:,1)./ 4.62; NeverAcc_Cum(:,2) = NeverAcc_Cum(:,2)./ 12.47;
% NeverAcc_Cum(:,3) = NeverAcc_Cum(:,3)./ 17.07; NeverAcc_Cum(:,4) = NeverAcc_Cum(:,4)./ 36.54;
% PS_output =readmatrix('C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\pt052_never.txt');
% Never_PS = PS_output(:,10);
% 
% %Convert concentration to kg/km
% HistStop_Conc_kgkm = HistStop_Conc .* (0.202 * 145.98 * 1.5); % below, replace 145.98 with reach specific width
% HistStop_Conc_kgkm(:,2) = HistStop_Conc_kgkm(:,2)*(147.63/145.98); HistStop_Conc_kgkm(:,2) = HistStop_Conc_kgkm(:,2)*(155.52/145.98); HistStop_Conc_kgkm(:,2) = HistStop_Conc_kgkm(:,2)*(177.89/145.98);
% HistNever_Conc_kgkm = HistNever_Conc .* (0.202 * 145.98 * 1.5);
% HistNever_Conc_kgkm(:,2) = HistNever_Conc_kgkm(:,2)*(147.63/145.98); HistNever_Conc_kgkm(:,2) = HistNever_Conc_kgkm(:,2)*(155.52/145.98); HistNever_Conc_kgkm(:,2) = HistNever_Conc_kgkm(:,2)*(177.89/145.98);
% 
% Legacy_daily = zeros(simlength,4);
% Legacy_daily(:,1) = (Stop_PS(:)-Never_PS(:)) - (HistStop_Data(:,1) - HistNever_Data(:,1));
% Legacy_daily(:,2) = (HistStop_Data(:,1) - HistNever_Data(:,1))- (HistStop_Data(:,2) - HistNever_Data(:,2));
% Legacy_daily(:,3) = (HistStop_Data(:,2) - HistNever_Data(:,2))- (HistStop_Data(:,3) - HistNever_Data(:,3));
% Legacy_daily(:,4) = (HistStop_Data(:,3) - HistNever_Data(:,3))- (HistStop_Data(:,4) - HistNever_Data(:,4));
% Legacy_traj = cumsum(Legacy_daily);
% Legacy_traj(:,1) = Legacy_traj(:,1) ./ 4.62; % devide by length of reach for kg/km
% Legacy_traj(:,2) = Legacy_traj(:,2) ./ 12.47;
% Legacy_traj(:,3) = Legacy_traj(:,3) ./ 17.07;
% Legacy_traj(:,4) = Legacy_traj(:,4) ./ 36.54;

% figure
% hold on
% for ii=1:4
%     plot(Legacy_traj(1:simlength,ii),'LineWidth',4)
% end
% xline(7306)
% for ii = 1:4
%     figure
%     hold on
%     plot(HistStop_Conc(:,ii),'LineWidth',4, 'color', [0.0784313753247261 0.168627455830574 0.549019634723663])
%     plot(HistNever_Conc(:,ii),'LineWidth',4, 'color', [0.803921580314636 0.878431379795074 0.968627452850342])
%     xline(7306, '--k','HandleVisibility','off')
%     xlim([0 14610])
%     fig=gcf;
%     fig.Position(3:4)=[1920,400];
%     set(gca,'box','off');
%     ax = gca; % axes handle
%     ax.YAxis.Exponent = 0;
%     ytickformat('%,3.0f');
%     ax.FontSize = 22; 
%     ylabel('Streambed P [mg/kg]', 'fontsize', 26)
%     xticklabels({'','','',''})
%     annotation('textbox',[0.6400625 0.884563758389262 0.2974375 0.0503355704697988],...
%     'String','Reach 1: PS to CP1','FontSize',22,'FitBoxToText','off','EdgeColor','none'); %edit text for appropriate reach!
% end
% xticks([0 1461 2922 4383 5844 7305 8766 10227 11688 13149 14610])
% xticklabels({'0','4','8','12','16','20','24','28','32','36','40'})
% xlabel('Year of simulation', 'fontsize', 26)
% legend('Legacy', 'Baseline', 'Location', 'Northeast')
% legend boxoff

% figure
% hold on
% plot(Legacy_traj(1:simlength,2),'LineWidth',4)
% xline(7306,'--k','HandleVisibility','off');
% figure
% hold on
% plot(StopAcc_Cum(:,2),'LineWidth',4)
% plot(NeverAcc_Cum(:,2),'LineWidth',4)
% xline(7306)

%% Create figure showing build-up of legacy P in each reach (concentration or Mg/km) - or, create data to import to QGIS map

%% Create figure showing baseline ("recovered"?), legacy, and status quo as shaded bands for 6 months-ish, using best parameterization (TxtInOut_045)
day = linspace(0,200,201);
figure
hold on

x2 = [day, fliplr(day)];
inBetween3 = [Phos_Data{45,1}(6575:6775,4)', fliplr(Phos_Data{45,3}(6575:6775,4)')]; % Stop , Cont
fill(x2, inBetween3, [0.470588235294118 0.529411764705882 0.831372549019608],...
    'Edgecolor', [0.470588235294118 0.529411764705882 0.831372549019608]); % RGB [194 222 199]

inBetween = [Phos_Data{45,2}(6575:6775,4)', fliplr(Phos_Data{45,1}(6575:6775,4)')]; % Never , Stop
fill(x2, inBetween, [0 0.0509803921568627 0.270588235294118],...
    'Edgecolor', [0 0.0509803921568627 0.270588235294118]); % RGB [20 43 140]

zeroline = zeros(1,201);
inBetween2 = [zeroline, fliplr(Phos_Data{45,2}(6575:6775,4)')]; % Zero , Never
fill(x2, inBetween2, [0.8 0.83921568627451 1],...
    'Edgecolor', [0.8 0.83921568627451 1]); % RGB [204 224 247]


fig=gcf;
fig.Position(3:4)=[1920,500];
xlabel('Days since 90% point source P reduction', 'fontsize', 26)
ylabel('P load at watershed outlet [kg]', 'fontsize', 26)
ax = gca; % axes handle
ax.YAxis.Exponent = 0;
ytickformat('%,5.0f');
ax.FontSize = 22; 
yticklabels({'0','5,000','10,000','15,000','20,000',''}) % check tick labels for correct scale if change simulation!!!
legend('Status quo - historically high, future high P discharge','Legacy - historically high, future low P discharge', 'Baseline - historically low, future low P discharge',...
     'fontsize', 26, 'Location', 'Northwest');
legend boxoff
% 
% % FLOW
% figure
% plot(day,Flow_045(6575:6775,4),'Color','k');
% %xlabel('Days since 90% point source P reduction', 'fontsize', 26)
% ylabel('Flow [m^3/s]', 'fontsize', 26)
% xticklabels({'','','','','','','','','','',''})
% fig=gcf;
% fig.Position(3:4)=[1920,250];
% set(gca,'box','off');
% ax = gca; % axes handle
% ax.YAxis.Exponent = 0;
% ytickformat('%,5.0f');
% ax.FontSize = 22; 
% 
% % DIFFUSION
% figure('OuterPosition',[-7 158 1935 593])
% plot(day,Diff_Total_Cont(6575:6775),'Color',[0.470588235294118 0.529411764705882 0.831372549019608], 'linewidth', 4);
% hold on
% plot(day,Diff_Total_Stop(6575:6775),'Color',[0 0.0509803921568627 0.270588235294118], 'linewidth', 4);
% plot(day,Diff_Total_Never(6575:6775),'Color',[0.8 0.83921568627451 1], 'linewidth', 4);
% 
% %xlabel('Days since 90% point source P reduction', 'fontsize', 26)
% ylabel('P diffusion from bed [kg]', 'fontsize', 26)
% xticklabels({'','','','','','','','','','',''})
% fig=gcf;
% fig.Position(3:4)=[1920,500];
% set(gca,'box','off');
% ax = gca; % axes handle
% ax.YAxis.Exponent = 0;
% ytickformat('%,5.0f');
% ax.FontSize = 22; 
% yline(0,'--')
% legend('Status quo','Legacy', 'Baseline', 'fontsize', 26, 'Location', 'Northwest');
% legend boxoff
% yticklabels({'-3,000','-2,000','-1,000','0','1,000','2,000',''}) % check tick labels for correct scale if change simulation!!!

% EROSION
% figure('OuterPosition',[-7 158 1935 593])
% plot(day,NetEro_Total_Cont(6575:6775),'Color',[0.470588235294118 0.529411764705882 0.831372549019608], 'linewidth', 4);
% hold on
% plot(day,NetEro_Total_Stop(6575:6775),'Color',[0 0.0509803921568627 0.270588235294118], 'linewidth', 4);
% plot(day,NetEro_Total_Never(6575:6775),'Color',[0.8 0.83921568627451 1], 'linewidth', 4);
% %xlabel('Days since 90% point source P reduction', 'fontsize', 26)
% ylabel('P net erosion from bed [kg]', 'fontsize', 26)
% xticklabels({'','','','','','','','','','',''})
% fig=gcf;
% %fig.Position(3:4)=[1920,500];
% set(gca,'box','off');
% ax = gca; % axes handle
% ax.YAxis.Exponent = 0;
% ytickformat('%,5.0f');
% ax.FontSize = 22; 
% yline(0,'--')
% legend('Status quo','Legacy', 'Baseline', 'fontsize', 26, 'Location', 'Northwest');
% legend boxoff
% %yticklabels({'-3,000','-2,000','-1,000','0','1,000','2,000',''}) % check tick labels for correct scale if change simulation!!!


%% Calculate cumulative P legacies
% simlength = length(Phos_Data{37,1}(:,1));
% startfuture = 6576;
% futurelength = simlength-startfuture;
% CumP_Data = cell(100,4); % 100 parameter sets, 3 point source scenarios + 1 legacy column [1=stop,2=never,3=cont,4=legacy]
% CumP_Data(:,:)= {zeros(futurelength,4)}; % simlength number of days, 4 reaches [26,28,30,33]
% for jj=1:100 % parameterization id
%     for ii=1:3 % point source scenario
%         % For each reach, set cumulative value on first day to load on first day
%         CumP_Data{jj,ii}(1,1) = Phos_Data{jj,ii}(startfuture,1); CumP_Data{jj,ii}(1,2) = Phos_Data{jj,ii}(startfuture,2);
%         CumP_Data{jj,ii}(1,3) = Phos_Data{jj,ii}(startfuture,3); CumP_Data{jj,ii}(1,4) = Phos_Data{jj,ii}(startfuture,4);
%         for kk=2:futurelength
%             kk2 = startfuture - 1 + kk;
%             CumP_Data{jj,ii}(kk,1) = CumP_Data{jj,ii}(kk-1,1) + Phos_Data{jj,ii}(kk2,1);
%             CumP_Data{jj,ii}(kk,2) = CumP_Data{jj,ii}(kk-1,2) + Phos_Data{jj,ii}(kk2,2);
%             CumP_Data{jj,ii}(kk,3) = CumP_Data{jj,ii}(kk-1,3) + Phos_Data{jj,ii}(kk2,3);
%             CumP_Data{jj,ii}(kk,4) = CumP_Data{jj,ii}(kk-1,4) + Phos_Data{jj,ii}(kk2,4);
%         end
%     end
%     CumP_Data{jj,4} = CumP_Data{jj,1} - CumP_Data{jj,2};
% end

%% Calculate minimum and maximum cumulative legacies among parameter sets (for uncertainty bands)
% CumP_max = zeros(futurelength,4);
% CumP_min = zeros(futurelength,4);
% which_max = 1;
% which_min = 1;
% for jj = 1:futurelength
%     %Set max and min equal to that from first parameterization
%     CumP_max(jj,:) = CumP_Data{1,4}(jj,:);
%     CumP_min(jj,:) = CumP_Data{1,4}(jj,:);
%     %If any other parameterization lower or higher, replace
%     for ii=2:100
%         if CumP_max(jj,1) < CumP_Data{ii,4}(jj,1), CumP_max(jj,1) = CumP_Data{ii,4}(jj,1); end
%         if CumP_max(jj,2) < CumP_Data{ii,4}(jj,2), CumP_max(jj,2) = CumP_Data{ii,4}(jj,2); end
%         if CumP_max(jj,3) < CumP_Data{ii,4}(jj,3), CumP_max(jj,3) = CumP_Data{ii,4}(jj,3); end
%         if CumP_max(jj,4) < CumP_Data{ii,4}(jj,4), CumP_max(jj,4) = CumP_Data{ii,4}(jj,4); which_max = ii; end
%         
%         if CumP_min(jj,1) > CumP_Data{ii,4}(jj,1), CumP_min(jj,1) = CumP_Data{ii,4}(jj,1); end
%         if CumP_min(jj,2) > CumP_Data{ii,4}(jj,2), CumP_min(jj,2) = CumP_Data{ii,4}(jj,2); end
%         if CumP_min(jj,3) > CumP_Data{ii,4}(jj,3), CumP_min(jj,3) = CumP_Data{ii,4}(jj,3); end
%         if CumP_min(jj,4) > CumP_Data{ii,4}(jj,4), CumP_min(jj,4) = CumP_Data{ii,4}(jj,4); which_min = ii; end
%     end
% end
%% Create figure with cumulative legacy P at four checkpoints - showing best param set as line and range of 100 sets as shaded band
% figure
% hold on
% for ii=1:100
% %     plot(CumP_Data{ii,4}(1:futurelength,1),'Color',[0.980392156862745 0.509803921568627 0.749019607843137],'LineWidth',1) %pink
% %     plot(CumP_Data{ii,4}(1:futurelength,2),'Color',[0.909803921568627 0.72156862745098 0.23921568627451],'LineWidth',1) %yellow
% %     plot(CumP_Data{ii,4}(1:futurelength,3),'Color',[0.419607843137255 0.549019607843137 0.929411764705882],'LineWidth',1) %blue
%     plot(CumP_Data{ii,4}(1:futurelength,4),'Color',[0.450980392156863 0.870588235294118 0.529411764705882],'LineWidth',1) %green
% end
% alpha(0.1)
% plot(CumP_Data{45,4}(1:futurelength,1),'Color',[0.980392156862745 0.509803921568627 0.749019607843137],'LineWidth',4) %pink
% plot(CumP_Data{45,4}(1:futurelength,2),'Color',[0.909803921568627 0.72156862745098 0.23921568627451],'LineWidth',4) %yellow
% plot(CumP_Data{45,4}(1:futurelength,3),'Color',[0.419607843137255 0.549019607843137 0.929411764705882],'LineWidth',4) %blue
% plot(CumP_Data{45,4}(1:futurelength,4),'Color',[0.450980392156863 0.870588235294118 0.529411764705882],'LineWidth',4) %green
% % plot(CumP_Data{45,4}(1:futurelength,4),'Color',[0.01 0.57 0.09],'LineWidth',4) %black for emphasis in 100 sim version

% day = linspace(0,futurelength-1,futurelength);
% x2 = [day, fliplr(day)];
% inBetween1 = [CumP_min(:,1)', fliplr(CumP_max(:,1)')]; 
% fill(x2, inBetween1, [0.980392156862745 0.509803921568627 0.749019607843137],'edgecolor',[0.980392156862745 0.509803921568627 0.749019607843137]); % pink
% inBetween2 = [CumP_min(:,2)', fliplr(CumP_max(:,2)')];
% fill(x2, inBetween2, [0.909803921568627 0.72156862745098 0.23921568627451],'edgecolor',[0.909803921568627 0.72156862745098 0.23921568627451]); % yellow
% inBetween3 = [CumP_min(:,3)', fliplr(CumP_max(:,3)')]; 
% fill(x2, inBetween3, [0.419607843137255 0.549019607843137 0.929411764705882],'edgecolor',[0.419607843137255 0.549019607843137 0.929411764705882]); % blue
% inBetween4 = [CumP_min(:,4)', fliplr(CumP_max(:,4)')]; 
% fill(x2, inBetween4, [0.450980392156863 0.870588235294118 0.529411764705882],'edgecolor',[0.450980392156863 0.870588235294118 0.529411764705882]); % green
% 
% alpha(0.1)
% xlim([0 7305]);
% xticks([0 365 730 1095 1461 1826 2191 2556 2922 3287 3652 4017 4383 4748 5113 5478 5844 6209 6574 6939 7305])
% xticklabels({'0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20'})
% ax = gca; % axes handle
% ax.YAxis.Exponent = 0;
% ytickformat('%,6.0f');
% ax.FontSize = 22;
% xlabel('Years since 90% point source P reduction', 'fontsize', 26)
% ylabel('Cumulative legacy P remobilized [kg]', 'fontsize', 26) 
% annotation('textbox',[0.679645833333333 0.798657718120805 0.0974375 0.0503355704697986],...
%     'String','Checkpoint 2','FontSize',22,'FitBoxToText','off','EdgeColor','none');
% annotation('textbox',[0.599958333333333 0.549217002237135 0.0974375 0.0503355704697988],...
%     'String','Checkpoint 4','FontSize',22,'FitBoxToText','off','EdgeColor','none');
% annotation('textbox',[0.531729166666667 0.252796420581655 0.0974374999999998 0.0503355704697986],...
%     'String',{'Checkpoint 1'},'FontSize',22,'FitBoxToText','off','EdgeColor','none');
% annotation('textbox',[0.6400625 0.684563758389262 0.0974375 0.0503355704697988],...
%     'String','Checkpoint 3','FontSize',22,'FitBoxToText','off','EdgeColor','none');

%% Create figure showing total annual loads (at outlet?) as box/whisker plot, with baseline (box/whisker) and ILNRS target (dashed line) for comparison
% % Box/whisker plots should encompass all runs with different params and
% % weather (have to do separately until after group meeting, when I will have run combinations)

% % Aggregate annual loads
% nyears = floor(futurelength/365);
% AnnP_Data = cell(nyears,3);
% AnnP_Data(:,:)= {zeros(100,1)};
% for ii=1:3
%     for kk=1:100
%         iday = 1;
%         iyr = 1;
%         for jj=1:futurelength
%             if iday==1
%                 AnnP_Data{iyr,ii}(kk) = Phos_Data{kk,ii}(jj-1+startfuture,4); % at outlet
%                 iday = iday +1;
%             else
%                 AnnP_Data{iyr,ii}(kk) = AnnP_Data{iyr,ii}(kk)+ Phos_Data{kk,ii}(jj-1+startfuture,4);
%                 iday = iday +1;
%             end 
%             if iday==366
%                 if iyr==4 || iyr==8 ||iyr==12
%                 else
%                    iday=1;
%                    iyr=iyr+1;
%                 end
%             end
%             if iday==367
%                 iday=1;
%                 iyr=iyr+1;
%             end
%         end
%     end
% end
% 
% Ann_recovery = zeros(nyears,100);
% Ann_rel2base = zeros(nyears,100);
% for ii=1:100
%     for jj=1:nyears
%         Ann_recovery(jj,ii) = 100*(AnnP_Data{jj,1}(ii) / AnnP_Data{jj,3}(ii)); % 1=stop, 2=never, 3=continue
%         Ann_rel2base(jj,ii) = 100*((AnnP_Data{jj,1}(ii) / AnnP_Data{jj,2}(ii))-1); % 1=stop, 2=never, 3=continue
%     end
% end
% 
% figure
% boxplot(Ann_rel2base','Symbol','','colors','k');
% % figure
% % boxplot(Ann_recovery','Symbol','','colors','k');
% xlabel('Year', 'fontsize', 26)
% ylabel('Annual legacy P load as percent of baseline', 'fontsize', 26)
% xticklabels({'2021','','2023','','2025','','2027','','2029','','2031','','2033','','2035','','2037','','2039',''})
% ax = gca; % axes handle
% ax.FontSize = 22;
% ytickformat(ax,'percentage');
% ylim([0 60]);
% 
% % Plot as box and whisker
% % Ann_stop=([AnnP_Data{1,1},AnnP_Data{2,1},AnnP_Data{3,1},AnnP_Data{4,1},AnnP_Data{5,1},AnnP_Data{6,1},...
% %     AnnP_Data{7,1},AnnP_Data{8,1},AnnP_Data{9,1},AnnP_Data{10,1},AnnP_Data{11,1},AnnP_Data{12,1}]);
% % Ann_never=([AnnP_Data{1,2},AnnP_Data{2,2},AnnP_Data{3,2},AnnP_Data{4,2},AnnP_Data{5,2},AnnP_Data{6,2},...
% %     AnnP_Data{7,2},AnnP_Data{8,2},AnnP_Data{9,2},AnnP_Data{10,2},AnnP_Data{11,2},AnnP_Data{12,2}]);
% % Ann_cont=([AnnP_Data{1,3},AnnP_Data{2,3},AnnP_Data{3,3},AnnP_Data{4,3},AnnP_Data{5,3},AnnP_Data{6,3},...
% %     AnnP_Data{7,3},AnnP_Data{8,3},AnnP_Data{9,3},AnnP_Data{10,3},AnnP_Data{11,3},AnnP_Data{12,3}]);
% % position_S = 1.2:1:12.2;
% % position_N = 1.4:1:12.4;
% % position_C = 1:1:12;  
% % figure
% % box_S = boxplot(Ann_stop,'colors','b','positions',position_S,'width',0.18,'Symbol',''); 
% % hold on
% % box_N = boxplot(Ann_never,'colors','r','positions',position_N,'width',0.18,'Symbol','');   
% % box_C = boxplot(Ann_cont,'colors','k','positions',position_C,'width',0.18,'Symbol','');  
% % xlabel('Year', 'fontsize', 26)
% % ylabel('Annual phosphorus load [kg]', 'fontsize', 26)
% % ax = gca; % axes handle
% % ax.YAxis.Exponent = 0;
% % ylim([0 1400000])
% % ytickformat('%,7.0f');
% % xticklabels({'2021','2022','2023','2024','2025','2026','2027','2028','2029','2030','2031','2032'})
% % hold off 

%% Calculate annual P loads and average P load, for parameterization 45 (best)
% BaseAnnP45 = zeros(nyears,1);
% BaseAnnPave = zeros(nyears,1);
% for ii=1:nyears
%    BaseAnnP45(ii) = AnnP_Data{ii,2}(45);
%    for jj=1:100
%        BaseAnnPave(ii) = BaseAnnPave(ii)+ AnnP_Data{ii,2}(jj);
%    end
%    BaseAnnPave(ii) = BaseAnnPave(ii)/100;
% end

% StatQAnnP45 = zeros(nyears,1);
% StatQAnnPave = zeros(nyears,1);
% for ii=1:nyears
%    StatQAnnP45(ii) = AnnP_Data{ii,3}(45);
%    for jj=1:100
%        StatQAnnPave(ii) = StatQAnnPave(ii)+ AnnP_Data{ii,3}(jj);
%    end
%    StatQAnnPave(ii) = StatQAnnPave(ii)/100;
% end

%% Calculate minimum and maximum cumulative legacies among parameter sets (for uncertainty bands)
% rec95 = zeros(100,1);
% for ii=1:100
%     x = 0.95 * CumP_Data{ii,4}(futurelength,4);
%     y = find(CumP_Data{ii,4}(1:futurelength,4) > x);
%     rec95(ii) = min(y);
% end