%% Run all point source and weather scenarios (Base TxtInOut files already created, customized in lines 10-17
Run45dir = 'C:\Users\kevin\Documents\INFEWS\100 Param Sets_never\TxtInOut_045'; %Run 45 has best parameterizaion, calibration.cal
scen_PS = ["never" "stop" "cont"];
for k=1:3
    scen_PSstr = convertStringsToChars(scen_PS(k));
    scen = ["norm" "wet" "dry" "dry2_wet" "dry4_wet" "dry6_wet" "dry8_wet" "dry10_wet"];
    parpool("Processes",8);
    parfor j=1:8
        scen_str = convertStringsToChars(scen(j));
        newdir = strcat('C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\TxtInOut_', scen_PSstr, '_', scen_str);
        weatherdir = strcat('C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\Weather_custom\', scen_str);
        PSdir = strcat('C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\PS_custom\', scen_PSstr, '\', scen_str);
        otherdir = ('C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\OtherInputs\20yrs');
        doxdir = strcat('C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\Dox_custom\', scen_str);
        copyfile(Run45dir, newdir);
        copyfile(weatherdir, newdir);
        copyfile(PSdir, newdir);
        copyfile(otherdir, newdir);
        copyfile(doxdir, newdir); % must come after "otherdir", in order to overwrite wyck.dox
        cd([newdir]);
        system('SWAT+P.exe > NUL');
    end
    delete(gcp('nocreate'))
end

%% Run all point source and weather scenarios, for all parameterizations
% for k=1:3
%     scen_PSstr = convertStringsToChars(scen_PS(k));
%     scen = ["norm" "wet" "dry" "dry_wet" "wet_dry"];
%     parfor j=1:5
%         scen_str = convertStringsToChars(scen(j));
%         scen_PS = ["never" "stop" "cont"];
%         cd(['C:\Users\kevin\Documents\INFEWS\Legacy_Analysis\TxtInOut_' scen_PSstr '_' scen_str]);
%         parpool("Processes",5);
%         for ii=1:100
%             %Write so that TxtInOut files are deleted after....? Somehow.
%             %Need to save space - channel.day files are too big to save
%             %1500 of them.
%             id = num2str(ii,'%03d');
%             newdir = strcat('TxtInOut_',id);
%             oldfile = strcat('calibration_',id,'.cal');
%             newfile = strcat(newdir,'/calibration.cal');
%             movefile(oldfile,newfile);
%             system('SWAT+P.exe > NUL');
%         end
%         delete(gcp('nocreate'))
%     end
% end