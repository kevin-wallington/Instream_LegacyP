%% Create new TxtInOut folders with calibration.cal files for best 100
% parameter sets
% Load 100 best parameter sets as variable "paramsetsfinal"
% scen_PS = ["never" "stop" "cont"];
% for k=1:3
%     scen_PSstr = convertStringsToChars(scen_PS(k));
%     currentdir = strcat('C:/Users/kevin/Documents/INFEWS/100 Param Sets_', scen_PSstr);
%     cd(currentdir);
%     for ii=1:100
%         params = paramsetsfinal(ii,:)';
%         id = num2str(ii,'%03d');
%         newdir = strcat('TxtInOut_',id);
%         file1 = strcat(currentdir, '\' ,newdir, '\calibration.cal');
%         file2 = strcat(currentdir, '\calibration.cal');
%         fid1 = fopen(file1,'r');
%         fid2 = fopen(file2,'w+');
%         line = 1;
%         while line < 48
%             temp = fgets(fid1);
%             if line > 3
%                 if line==43 || line==44
%                     oldparam = extractBetween(temp,19,33);
%                 else
%                     oldparam = extractBetween(temp,18,32);
%                 end
%             paramid = line-3;
%             newparam = params(paramid);
%             newparam = num2str(newparam,'%15f');
%             len_str = strlength(newparam);
%             if len_str < 15
%                 extra_zeros = 15 - len_str;
%                 for i=1:extra_zeros
%                    newparam = strcat(newparam, '0'); 
%                 end
%             end
%             temp = strrep(temp,oldparam{1},newparam); % Change param value
%             end  
%             fprintf(fid2,'%s',temp); % Writes desired years
%             line = line +1;
%         end
%         fclose('all');
%         movefile(file2,file1);
%     end
% end

%% Copy desired weather point source, and other inputs for scenario to all TxtInOut folders
% scen_PS = ["never" "stop" "cont"];
% for k=1:3
%     scen_PSstr = convertStringsToChars(scen_PS(k));
%     PS_file = strcat('C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\PS_custom\', scen_PSstr, '\norm\pt052.rec');
%     cd(['C:/Users/kevin/Documents/INFEWS/100 Param Sets_' scen_PSstr]);
%     for ii=1:100
%         id = num2str(ii,'%03d');
%         newdir = strcat('TxtInOut_',id);
%         copyfile('C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\OtherInputs\20yrs', newdir);
%         copyfile('C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\Weather_custom\norm', newdir);
%         copyfile(PS_file, newdir);
% %         oldfile = strcat(newdir,'/pt052_2017to20contP.rec');
% %         newfile = strcat(newdir,'/pt052.rec');
% %         movefile(oldfile,newfile);
%     end
% end

%% Run simulation for all TxtInOut folders
% 
parpool("Processes",10);
cd(['C:/Users/kevin/Documents/INFEWS/100 Param Sets_Stop/TxtInOut_001']);
parfor ii=1:100
    id = num2str(ii,'%03d');
    newdir = strcat('../TxtInOut_',id);
    cd([newdir]);
    system('SWAT+P.exe > NUL');
end

cd(['C:/Users/kevin/Documents/INFEWS/100 Param Sets_Cont/TxtInOut_001']);
parfor ii=1:100
    id = num2str(ii,'%03d');
    newdir = strcat('../TxtInOut_',id);
    cd([newdir]);
    system('SWAT+P.exe > NUL');
end

cd(['C:/Users/kevin/Documents/INFEWS/100 Param Sets_Never/TxtInOut_001']);
parfor ii=1:100
    id = num2str(ii,'%03d');
    newdir = strcat('../TxtInOut_',id);
    cd([newdir]);
    system('SWAT+P.exe > NUL');
end

delete(gcp('nocreate'))
