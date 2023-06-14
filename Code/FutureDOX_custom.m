%% Create individual year DO files
fid1 = fopen('C:\Users\kevin\Documents\INFEWS\TxtInOut_NewWQ_finalparam\wyck.dox','r');
for i=1:20
    yr = 2000 + i;
    yrstr = num2str(yr,'%04d');
    fid3 = fopen(['C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\Dox_custom\' yrstr '.txt'],'w+'); % Open new write-able file
    if i==4 || i==8 || i==12 || i==16 || i==20,days = 366;
    else, days = 365;
    end
    if i==1
        temp = fgets(fid2);temp = fgets(fid2);temp = fgets(fid2);
        L=3;
    end
    M = L+days;
    while L<M
        temp = fgets(fid2);
        fprintf(fid3,'%s',temp); % Writes desired years
        L=L+1;
    end
    fclose(fid3);
end
fclose(fid1);

%% Create all DO files for future scenario
scen = ["norm" "wet" "dry" "dry2_wet" "dry4_wet" "dry6_wet" "dry8_wet" "dry10_wet"];
for j=1:8
    scen_str = convertStringsToChars(scen(j));
    seq_str = append(scen(j), '_seq');
    seq = eval(seq_str);
    fid2 = fopen('C:\Users\kevin\Documents\INFEWS\TxtInOut_NewWQ_finalparam\wyck.dox','r'); % Open file
    fid4 = fopen(['C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\Dox_custom\' scen_str '\' 'wyck.dox'],'w+'); % Open new write-able file
    % Locate, read, and save rows for desired years (see line 25)
    L=0;
    while feof(fid2) == 0
        L=L+1;
        temp = fgets(fid2);
        if L == 3
            temp = strrep(temp,' 20 ', ' 40 '); % Change number of years
        end
        fprintf(fid4,'%s',temp); % Copies original to new scenario
    end
    fprintf(fid4,'\n');
    % Write new year rows at end of scenario weather file, required number of times
    for i=1:20 %number of future years
        yrstr = num2str(seq(i),'%04d'); 
        fid3 = fopen(['C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\Dox_custom\' yrstr '.txt'],'r'); % Open new write-able file
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