%% Create all weather files for future scenario 
fid1 = fopen('C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\Weather_backup\filenames.txt','r');
while feof(fid1) == 0
    filestr = fgets(fid1); % Read file name
    filestr = strtrim(filestr); % trim so no line break
    len_str = length(filestr);
    if len_str > 24
        filestr(1) = []; % for some reason, code adds invisible/emply first character
    end
    fid2 = fopen(['C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\Weather_backup\' filestr],'r'); % Open file
    %fid2 = fopen('C:\Users\kevin\Documents\INFEWS\Legacy Analysis\Weather_backup\39.7579_-89.4458_HMD.hmd','r'); % Open file
    fid3 = fopen(['../Legacy_Analysis/Weather_2017to20/' filestr],'w+'); % Open new write-able file
    fid4 = fopen(['../Legacy_Analysis/Weather_scenario2017to20/' filestr],'w+'); % Open new write-able file
    %fid2 = fopen('C:\Users\kevin\Documents\INFEWS\Legacy Analysis\Weather_2017to20\Empty.txt', 'w+');

    % Locate, read, and save rows for desired years (see line 25)
    L=0;
    while feof(fid2) == 0
        L=L+1;
        temp = fgets(fid2);
        if L == 3
            temp = strrep(temp,' 20 ', ' 32 '); % Change number of years
        end
        fprintf(fid4,'%s',temp); % Copies original to new scenario
        if L > 5847 && L < 7309 % Begin and end of year: 2017-(5847-6211), 2018-(6212,6578), 2019-(6579-6941), 2020-(6942,7309)
            fprintf(fid3,'%s',temp); % Writes desired years
        end
    end
    
    % Write new year rows at end of scenario weather file, required number of times
    for i=1:12 %number of future years
        if i==1 || i==5 || i==9
            frewind(fid3)
        end
        if (i==1 || i==5 || i==9); oldyear = '2017'; end
        if (i==2 || i==6 || i==10); oldyear = '2018'; end
        if (i==3 || i==7 || i==11); oldyear = '2019'; end
        if (i==4 || i==8 || i==12); oldyear = '2020'; end
        dd = 0;
        numdays=365;
        if i==4 || i==8
           numdays = 366; 
        end
        while dd < numdays %feof(fid3) == 0
            temp = fgets(fid3);
%             if ischar(temp)==0 % for debuggging
%                numdays = numdays; 
%             end
            newyear = 2020 + i;
            newyear = string(newyear);
            newtemp = strrep(temp,oldyear,newyear); % Change year
            fprintf(fid4,'%s',newtemp); % Copies original to new scenario
            dd = dd + 1;
        end
%         if i~=4 && i~=8 % Non-Leap years, remove final day, only used for 2020 repeat (leap year)
%             newtemp = strrep(newtemp,'365','366'); % Change day to 366
%             if size(strfind(filestr,'pcp'),1)>0
%                 newtemp = append(newyear, '  366          0', newline); % Change precip to zero
%             end
%             fprintf(fid4,'%s',newtemp); % Copies original to new scenario
%         end
%         if i==4 || i==8 % Leap years, add final day again, only used for 2018 repeat (non-leap year)
%             newtemp = strrep(newtemp,'365','366'); % Change day to 366
%             if size(strfind(filestr,'pcp'),1)>0
%                 newtemp = append(newyear, '  366          0', newline); % Change precip to zero
%             end
%             fprintf(fid4,'%s',newtemp); % Copies original to new scenario
%         end
    end
    fclose(fid2);
    fclose(fid3);
    fclose(fid4);
end
fclose(fid1);