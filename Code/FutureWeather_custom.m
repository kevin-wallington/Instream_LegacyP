%% Identify wet, normal, dry years; create 20 year sequences
% WB_output =readmatrix('C:\Users\kevin\Documents\INFEWS\TxtInOut_NewWQ_finalparam\basin_wb_yr.txt');
% Ann_precip = WB_output(:,[4,8]);
% Ann_precip_sorted = sortrows(Ann_precip,2);
% rng(8,'twister');
% norm_seq = randi([1 20], 1,20); 
% wet_seq = randi([18 20], 1,20);
% dry_seq = randi([1 3], 1,20);
% dry2_wet_seq = [dry_seq(1:2),wet_seq(3:20)];
% dry4_wet_seq = [dry_seq(1:4),wet_seq(5:20)];
% dry6_wet_seq = [dry_seq(1:6),wet_seq(7:20)];
% dry8_wet_seq = [dry_seq(1:8),wet_seq(9:20)];
% dry10_wet_seq = [dry_seq(1:10),wet_seq(11:20)];
% for i=1:20
%     norm_seq(i) = Ann_precip_sorted(norm_seq(i),1);
%     wet_seq(i) = Ann_precip_sorted(wet_seq(i),1);
%     dry_seq(i) = Ann_precip_sorted(dry_seq(i),1);
%     dry2_wet_seq(i) = Ann_precip_sorted(dry2_wet_seq(i),1);
%     dry4_wet_seq(i) = Ann_precip_sorted(dry4_wet_seq(i),1);
%     dry6_wet_seq(i) = Ann_precip_sorted(dry6_wet_seq(i),1);
%     dry8_wet_seq(i) = Ann_precip_sorted(dry8_wet_seq(i),1);
%     dry10_wet_seq(i) = Ann_precip_sorted(dry10_wet_seq(i),1);
% end
%% Create individual year weather files
% fid1 = fopen('C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\Weather_backup\filenames.txt','r');
% while feof(fid1) == 0
%     filestr = fgets(fid1); % Read file name
%     filestr = strtrim(filestr); % trim so no line break
%     len_str = length(filestr);
%     if len_str > 24
%         filestr(1) = []; % for some reason, code adds invisible/emply first character
%     end
%     fid2 = fopen(['C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\Weather_backup\' filestr],'r'); % Open file
%     for i=1:20
%         yr = 2000 + i;
%         yrstr = num2str(yr,'%04d');
%         fid3 = fopen(['C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\Weather_custom\' yrstr '\' filestr],'w+'); % Open new write-able file
%         if i==4 || i==8 || i==12 || i==16 || i==20,days = 366;
%         else, days = 365;
%         end
%         if i==1
%             temp = fgets(fid2);temp = fgets(fid2);temp = fgets(fid2);
%             L=3;
%         end
%         M = L+days;
%         while L<M
%             temp = fgets(fid2);
%             fprintf(fid3,'%s',temp); % Writes desired years
%             L=L+1;
%         end
%         fclose(fid3);
%     end
%     fclose(fid2);
% end
% fclose(fid1);

%% Create all weather files for future scenario
scen = ["norm" "wet" "dry" "dry2_wet" "dry4_wet" "dry6_wet" "dry8_wet" "dry10_wet"];
for j=1:8
    scen_str = convertStringsToChars(scen(j));
    seq_str = append(scen(j), '_seq');
    seq = eval(seq_str);
    fid1 = fopen('C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\Weather_backup\filenames.txt','r');
    while feof(fid1) == 0
        filestr = fgets(fid1); % Read file name
        filestr = strtrim(filestr); % trim so no line break
        len_str = length(filestr);
        if len_str > 24
            filestr(1) = []; % for some reason, code adds invisible/emply first character
        end
        fid2 = fopen(['C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\Weather_backup\' filestr],'r'); % Open file
        fid4 = fopen(['C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\Weather_custom\' scen_str '\' filestr],'w+'); % Open new write-able file
        % Locate, read, and save rows for desired years (see line 25)
        L=0;
        while L<3
            L=L+1;
            temp = fgets(fid2);
            if L == 3
                temp = strrep(temp,' 20 ', ' 40 '); % Change number of years
            end
            fprintf(fid4,'%s',temp); % Copies original to new scenario
        end
        while feof(fid2) == 0
            temp = fgets(fid2);
            fprintf(fid4,'%s',temp); % Copies original to new scenario
        end
        % Write new year rows at end of scenario weather file, required number of times
        for i=1:20 %number of future years
            yrstr = num2str(seq(i),'%04d'); 
            fid3 = fopen(['C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\Weather_custom\' yrstr '\' filestr],'r'); % Open new write-able file
            dd = 0;
            numdays=365;
            while dd < numdays
                temp = fgets(fid3);
                newyear = 2020 + i;
                newyear = string(newyear);
                newtemp = strrep(temp,yrstr,newyear); % Change year
                fprintf(fid4,'%s',newtemp); % Copies original to new scenario
                dd = dd + 1;
            end
            if i==4 || i==8 || i==12 || i==16 || i==20
                if seq(i)==2004 || seq(i)==2008 || seq(i)==2012 || seq(i)==2016 || seq(i)==2020 % add day 366
                    temp = fgets(fid3);
                    newyear = 2020 + i;
                    newyear = string(newyear);
                    newtemp = strrep(temp,yrstr,newyear); % Change year
                    fprintf(fid4,'%s',newtemp); % Copies original to new scenario
                    dd = dd + 1;
                else % repeat day 355
                    newtemp = strrep(newtemp,'365','366'); % Change day
                    fprintf(fid4,'%s',newtemp); % Copies original to new scenario
                    dd = dd + 1;
                end
            end
            frewind(fid3)
            fclose(fid3);
        end
        fclose(fid2);
        fclose(fid4);
    end
    fclose(fid1);
end