day = [1204 2013 2871 3411];
year = day./365;
length = [4.62 12.47 17.07 36.54];
length = cumsum(length);

logfit = fittype('b*log(x+1)',...
    'dependent',{'y'},'independent',{'x'},...
    'coefficients',{'b'});
[mylogfit,goflog] = fit(length',day',logfit)
[mylogfityear,goflogyear] = fit(length',year',logfit)
powerfit = fittype('a*x^b',...
    'dependent',{'y'},'independent',{'x'},...
    'coefficients',{'a','b'});
[mypowerfit, gofpower] = fit(length',day',powerfit)
[mypowerfityear, gofpoweryear] = fit(length',year',powerfit)

figure
scatter(length,year)
xticks([0,10, 20,30,40,50,60,70,80])
yticks([0,2,4,6,8,10])

hold on
plot(mylogfityear)
plot(mypowerfityear)

set(gcf, 'Position',  [100, 100, 500, 400])