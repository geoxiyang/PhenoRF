%% Calculate shortwave albedo using incoming and outgoing radiation data

clear all
clc

%%  1. Import column-based data
%   Before importing, remember change NA to -9999.

rawdata = importdata('/Volumes/XiYangResearch/Data/HFData/hf102-01-rad-midpt.csv');

% assign columns to variables
year    = rawdata.data(4397:end,1);   % For Harvard Forest, use 1992-2007
doy     = rawdata.data(4397:end,2);
Sup     = rawdata.data(4397:end,6);   % reflected radiation (W/m2)
Sdn     = rawdata.data(4397:end,7);   % incoming radiation


%%  2. Calculate hourly albedo and daily albedo

% Sup should be positive, Sdn should be negative.
% And we ignore values that are smaller than 10 W/m2.

starty  = 1992;
endy    = 2007;
ndays   = datenum([endy 12 31 0 0 0]) - datenum([starty 1 1 0 0 0])+1;
nyears  = endy - starty + 1;
dalbedo = nan(3,ndays);

% hourly albedo
Sup(Sup == -9999.0) = NaN;
Sdn(Sdn == -9999.0) = NaN;

index   = Sup > 10.0 & Sdn < -10.0;
albedo  = nan(length(doy),1);
albedo(index)  = Sup(index,1)./(-Sdn(index,1));

% for ii = 1:nyears
%     yearii	= starty + ii -1 ;
%     day_year= datenum([yearii 12 31 0 0 0]) - datenum([yearii 1 1 0 0 0])+1;
%     acc_day = datenum([yearii 12 31 0 0 0]) - datenum([starty 1 1 0 0 0]);
%     
%     for jj = 1:day_year
%        dalbedo(jj+acc_day,1) = yearii; 
%        dalbedo(jj+acc_day,2) = jj;
%        % Criteria: mid-day: ~10am to 2pm AND Sup > 10 and Sdn <-10.0;
%        sub_temp = (year == yearii) & (doy >= jj+0.4) & (doy < jj+0.6) & Sup > 10.0 & Sdn < -10.0;
%        if ~sum(sun_temp)
%           continue 
%        end
%        dalbedo(jj+acc_day,3) = nanmean(Sup(sub_temp,1)./(-Sdn(sub_temp,1)));
%     end
%        
% end





