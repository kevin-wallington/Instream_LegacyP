%% Load data
% Need: loads at reaches 26,33,30,28 for each of cont, stop, never scenarios
% Open a channel_day file just to establish the simuilation length and create Phos_Data array
Ch_file = strcat('C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\TxtInOut_cont_norm\channel_day.txt' );
Swat_output = readmatrix([Ch_file]);
WheresReach26 = find(Swat_output(:,6)==26);
Reach26 = Swat_output(WheresReach26,:);
simlength = length(Reach26);
startfuture = 6576;
futurelength = simlength-startfuture;
Phos_Data_weather = cell(8,3); % 8 weather scenarios, 3 point source scenarios [1=stop,2=never,3=cont] - each cell is a simulation 
Phos_Data_weather(:,:)= {zeros(simlength,4)}; % simlength number of days, 4 reaches [26,33,30,28]

scen_PS = ["stop" "never" "cont"];
for k=1:3
    scen_PSstr = convertStringsToChars(scen_PS(k));
    scen = ["norm" "dry" "dry2_wet" "dry4_wet" "dry6_wet" "dry8_wet" "dry10_wet" "wet"];
    for j=1:8
        scen_str = convertStringsToChars(scen(j));
        Iter_Data = zeros(simlength,4);
        Ch_file = strcat('C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\TxtInOut_', scen_PSstr, '_', scen_str, '\', 'channel_day.txt' );
        Swat_output = readmatrix([Ch_file]);
        WheresReach26 = find(Swat_output(:,6)==26);
        Reach26 = Swat_output(WheresReach26,:);
        WheresReach28 = find(Swat_output(:,6)==28);
        Reach28 = Swat_output(WheresReach28,:);
        WheresReach30 = find(Swat_output(:,6)==30);
        Reach30 = Swat_output(WheresReach30,:);
        WheresReach33 = find(Swat_output(:,6)==33);
        Reach33 = Swat_output(WheresReach33,:);
        Iter_Data(:,1) = (Reach26(:,18))+(Reach26(:,20))+(Reach26(:,22))+ (Reach26(:,30));
        Iter_Data(:,2) = (Reach33(:,18))+(Reach33(:,20))+(Reach33(:,22))+ (Reach33(:,30));
        Iter_Data(:,3) = (Reach30(:,18))+(Reach30(:,20))+(Reach30(:,22))+ (Reach30(:,30));
        Iter_Data(:,4) = (Reach28(:,18))+(Reach28(:,20))+(Reach28(:,22))+ (Reach28(:,30));
        Phos_Data_weather(j,k) = {Iter_Data};
    end
end

% Calculate cumulative P legacies
simlength = length(Phos_Data_weather{1,1}(:,1));
startfuture = 6576;
futurelength = simlength-startfuture;
CumP_Data_weather = cell(8,4); % 8 weather scenarios, 3 point source scenarios + 1 legacy column [1=stop,2=never,3=cont,4=legacy]
CumP_Data_weather(:,:)= {zeros(futurelength,4)}; % simlength number of days, 4 reaches [26,28,30,33]
for jj=1:8 % weather scenario
    for ii=1:3 % point source scenario
        % For each reach, set cumulative value on first day to load on first day
        CumP_Data_weather{jj,ii}(1,1) = Phos_Data_weather{jj,ii}(startfuture,1); CumP_Data_weather{jj,ii}(1,2) = Phos_Data_weather{jj,ii}(startfuture,2);
        CumP_Data_weather{jj,ii}(1,3) = Phos_Data_weather{jj,ii}(startfuture,3); CumP_Data_weather{jj,ii}(1,4) = Phos_Data_weather{jj,ii}(startfuture,4);
        for kk=2:futurelength
            kk2 = startfuture - 1 + kk;
            CumP_Data_weather{jj,ii}(kk,1) = CumP_Data_weather{jj,ii}(kk-1,1) + Phos_Data_weather{jj,ii}(kk2,1);
            CumP_Data_weather{jj,ii}(kk,2) = CumP_Data_weather{jj,ii}(kk-1,2) + Phos_Data_weather{jj,ii}(kk2,2);
            CumP_Data_weather{jj,ii}(kk,3) = CumP_Data_weather{jj,ii}(kk-1,3) + Phos_Data_weather{jj,ii}(kk2,3);
            CumP_Data_weather{jj,ii}(kk,4) = CumP_Data_weather{jj,ii}(kk-1,4) + Phos_Data_weather{jj,ii}(kk2,4);
        end
    end
    CumP_Data_weather{jj,4} = CumP_Data_weather{jj,1} - CumP_Data_weather{jj,2};
end

%% Create figure with cumulative legacy P at outlet
figure
hold on
for ii=1:8
    plot(CumP_Data_weather{ii,4}(1:futurelength,4),'LineWidth',4)
end

% alpha(0.1)
xlim([0 7305])
xticks([0 365 730 1095 1461 1826 2191 2556 2922 3287 3652 4017 4383 4758 5113 5478 5844 6209 6574 6939 7305])
xticklabels({'0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20'})
ax = gca; % axes handle
ax.YAxis.Exponent = 0;
ax.FontSize = 22;
ytickformat('%,6.0f');
xlabel('Years since 90% point source P reduction', 'fontsize', 26)
ylabel('Cumulative legacy P remobilized [kg]', 'fontsize', 26)
legend('normal','dry','2 yrs dry, remaining wet','4 yrs dry, remaining wet',...
    '6 yrs dry, remaining wet','8 yrs dry, remaining wet','10 yrs dry, remaining wet','wet', 'Location', 'Southeast' ); % , 
legend boxoff
% annotation('textbox',[0.679645833333333 0.798657718120805 0.0974375 0.0503355704697986],...
%     'String','Checkpoint 2','FontSize',22,'FitBoxToText','off','EdgeColor','none');
% annotation('textbox',[0.599958333333333 0.549217002237135 0.0974375 0.0503355704697988],...
%     'String','Checkpoint 4','FontSize',22,'FitBoxToText','off','EdgeColor','none');
% annotation('textbox',[0.531729166666667 0.252796420581655 0.0974374999999998 0.0503355704697986],...
%     'String',{'Checkpoint 1'},'FontSize',22,'FitBoxToText','off','EdgeColor','none');
% annotation('textbox',[0.6400625 0.684563758389262 0.0974375 0.0503355704697988],...
%     'String','Checkpoint 3','FontSize',22,'FitBoxToText','off','EdgeColor','none');