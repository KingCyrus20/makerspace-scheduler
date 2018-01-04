clear all;
rng(0,'twister');
studentworkers=3;
maxhours=7;
maxhours=maxhours*2;
[filename,path] = uigetfile({'*.xls';'*.xlsx'}, 'Pick your calendar spreadsheet');
filename=strcat(path,filename);
[~, names, ~] = xlsread(filename,1,'C2:C300');
[~, date, ~] = xlsread(filename,1,'E2:E300');
[time, ~, ~] = xlsread(filename,1,'F2:F300');
[duration, ~, ~] = xlsread(filename,1,'G2:G300');
duration = int64(48*duration(1:end-2,:));
time2=((rem(floor(time),7))-2);
for i=1:length(time2)
    if(time2(i)<0)
        time2(i)=time2(i)+7;
    end
end
time=time2+(time-floor(time));
time=int64(48*(time-floor(time(1))))-15;  %note that there HAS to be someone scheduled on Monday for the code to work
for i=1:length(time)
    try
    if(time(i)>288)
        time(i)=time(i)-142;
    elseif(time(i)>240)
        time(i)=time(i)-108;
    elseif(time(i)>192)
        time(i)=time(i)-80;
    elseif(time(i)>144)
        time(i)=time(i)-60;
    elseif(time(i)>96)
        time(i)=time(i)-40;
    elseif(time(i)>48)
        time(i)=time(i)-20;
    else
    end
    
    catch
    end
end

%time=time*24-1027204;

roster=unique(names);
buffer=zeros(length(roster),5);
availability=zeros(length(roster),168);
days=unique(date,'stable');

i=1;
while strcmp(date(i),days(1))==1
    i=i+1;
end
i=i-1;

for personcounter=1:length(roster)
    index = find(ismember(names, roster(personcounter)));
    for schedulecounter=1:length(index)
        for lengthcounter=1:duration(index(schedulecounter))
            availability(personcounter,time(index(schedulecounter))+lengthcounter-1)=1;
        end
        
    end
end
goodnessbest=10000;

for itteration=1:20

availabilitycalc=[buffer,availability,buffer];
schedule=zeros(size(availabilitycalc));
availabilitybyhour=recalculateavailability(availabilitycalc);
schedulebyhour=recalculateavailability(schedule);
availabilitybyperson=recalculateavailabilityperson(availabilitycalc);
availabilitybypersonoriginal=availabilitybyperson;
scheduledbyperson=recalculateavailabilityperson(schedule);
hourlystats=zeros(9);

while sum(sum(availabilitycalc))>0
    
    availabilitybyhour=recalculateavailability(availabilitycalc);
    
    schedulebyhour=recalculateavailability(schedule);
    availabilitybyperson=recalculateavailabilityperson(availabilitycalc);
    scheduledbyperson=recalculateavailabilityperson(schedule);
    
    
    numberofpeople=1;
    while isempty(find(availabilitybyhour==numberofpeople,1))==true
        numberofpeople=numberofpeople+1;
    end
    
    i=find(availabilitybyhour==numberofpeople,1);
    
    index = find(availabilitycalc(:,i));
    index=index(int64((numberofpeople)*rand+0.5));
    availabilitycalc(index,i)=0;
    
    try
        
        if( availabilitycalc(index,i+1)==1&availabilitycalc(index,i+2)==1&availabilitycalc(index,i+3)==1&scheduledbyperson(index)<=maxhours-4)
            hourlystats(1)=hourlystats(1)+1;
            schedule(index,i)=1;
            schedule(index,i+1)=1;
            schedule(index,i+2)=1;
            schedule(index,i+3)=1;
            availabilitycalc(index,i)=0;
            availabilitycalc(index,i+1)=0;
            availabilitycalc(index,i+2)=0;
            availabilitycalc(index,i+3)=0;
            availabilitycalc(index,i+4)=0;
            availabilitycalc(index,i-1)=0;
            availabilitycalc(index,i+5)=0;
            availabilitycalc(index,i-2)=0;
            
            if(scheduledbyperson(index)>=maxhours)
                availabilitycalc(index,:)=zeros(length(schedulebyhour),1);
            end
            schedulebyhour=recalculateavailability(schedule);
            if schedulebyhour(i)>=studentworkers
                availabilitycalc(:,i)=zeros(1,length(roster));
            end
            if schedulebyhour(i+1)>=studentworkers
                availabilitycalc(:,i+1)=zeros(1,length(roster));
            end
            if schedulebyhour(i+2)>=studentworkers
                availabilitycalc(:,i+2)=zeros(1,length(roster));
            end
            if schedulebyhour(i+3)>=studentworkers
                availabilitycalc(:,i+3)=zeros(1,length(roster));
            end
            
            
            
        elseif(availabilitycalc(index,i+1)==1&availabilitycalc(index,i+2)==1&availabilitycalc(index,i-1)==1&scheduledbyperson(index)<=maxhours-4)
            
            hourlystats(2)=hourlystats(2)+1;
            schedule(index,i)=1;
            schedule(index,i+1)=1;
            schedule(index,i+2)=1;
            schedule(index,i-1)=1;
            availabilitycalc(index,i)=0;
            availabilitycalc(index,i+1)=0;
            availabilitycalc(index,i+2)=0;
            availabilitycalc(index,i+3)=0;
            availabilitycalc(index,i+4)=0;
            availabilitycalc(index,i-1)=0;
            availabilitycalc(index,i-2)=0;
            availabilitycalc(index,i-3)=0;
            if(scheduledbyperson(index)>=maxhours)
                availabilitycalc(index,:)=zeros(length(schedulebyhour),1);
            end
            schedulebyhour=recalculateavailability(schedule);
            if schedulebyhour(i)>=studentworkers
                availabilitycalc(:,i)=zeros(1,length(roster));
            end
            if schedulebyhour(i+1)>=studentworkers
                availabilitycalc(:,i+1)=zeros(1,length(roster));
            end
            if schedulebyhour(i+2)>=studentworkers
                availabilitycalc(:,i+2)=zeros(1,length(roster));
            end
            if schedulebyhour(i-1)>=studentworkers
                availabilitycalc(:,i-1)=zeros(1,length(roster));
            end
            
        elseif(availabilitycalc(index,i+1)==1&availabilitycalc(index,i-2)==1&availabilitycalc(index,i-1)==1&scheduledbyperson(index)<=maxhours-4)
            hourlystats(3)=hourlystats(3)+1;
            schedule(index,i)=1;
            schedule(index,i+1)=1;
            schedule(index,i-2)=1;
            schedule(index,i-1)=1;
            availabilitycalc(index,i)=0;
            availabilitycalc(index,i+1)=0;
            availabilitycalc(index,i+2)=0;
            availabilitycalc(index,i-3)=0;
            availabilitycalc(index,i-1)=0;
            availabilitycalc(index,i-2)=0;
            availabilitycalc(index,i+3)=0;
            availabilitycalc(index,i-4)=0;
            if(scheduledbyperson(index)>=maxhours)
                availabilitycalc(index,:)=zeros(length(schedulebyhour),1);
            end
            schedulebyhour=recalculateavailability(schedule);
            if schedulebyhour(i)>=studentworkers
                availabilitycalc(:,i)=zeros(1,length(roster));
            end
            if schedulebyhour(i+1)>=studentworkers
                availabilitycalc(:,i+1)=zeros(1,length(roster));
            end
            if schedulebyhour(i-2)>=studentworkers
                availabilitycalc(:,i-2)=zeros(1,length(roster));
            end
            if schedulebyhour(i-1)>=studentworkers
                availabilitycalc(:,i-1)=zeros(1,length(roster));
            end
            
        elseif(availabilitycalc(index,i-3)==1&availabilitycalc(index,i-2)==1&availabilitycalc(index,i-1)==1&scheduledbyperson(index)<=maxhours-4)
            hourlystats(4)=hourlystats(4)+1;
            schedule(index,i)=1;
            schedule(index,i-3)=1;
            schedule(index,i-2)=1;
            schedule(index,i-1)=1;
            availabilitycalc(index,i)=0;
            availabilitycalc(index,i+1)=0;
            availabilitycalc(index,i-4)=0;
            availabilitycalc(index,i-3)=0;
            availabilitycalc(index,i-1)=0;
            availabilitycalc(index,i-2)=0;
            availabilitycalc(index,i+2)=0;
            availabilitycalc(index,i-5)=0;
            if(scheduledbyperson(index)>=maxhours)
                availabilitycalc(index,:)=zeros(length(schedulebyhour),1);
            end
            schedulebyhour=recalculateavailability(schedule);
            if schedulebyhour(i)>=studentworkers
                availabilitycalc(:,i)=zeros(1,length(roster));
            end
            if schedulebyhour(i-3)>=studentworkers
                availabilitycalc(:,i-3)=zeros(1,length(roster));
            end
            if schedulebyhour(i-2)>=studentworkers
                availabilitycalc(:,i-2)=zeros(1,length(roster));
            end
            if schedulebyhour(i-1)>=studentworkers
                availabilitycalc(:,i-1)=zeros(1,length(roster));
            end
        elseif(availabilitycalc(index,i+1)==1&availabilitycalc(index,i+2)==1&scheduledbyperson(index)<=maxhours-3)
            hourlystats(5)=hourlystats(5)+1;
            schedule(index,i)=1;
            schedule(index,i+1)=1;
            schedule(index,i+2)=1;
            availabilitycalc(index,i)=0;
            availabilitycalc(index,i+1)=0;
            availabilitycalc(index,i+2)=0;
            availabilitycalc(index,i+3)=0;
            availabilitycalc(index,i-1)=0;
            availabilitycalc(index,i+4)=0;
            availabilitycalc(index,i-2)=0;
            if(scheduledbyperson(index)>=maxhours)
                availabilitycalc(index,:)=zeros(length(schedulebyhour),1);
            end
            schedulebyhour=recalculateavailability(schedule);
            if schedulebyhour(i)>=studentworkers
                availabilitycalc(:,i)=zeros(1,length(roster));
            end
            if schedulebyhour(i+1)>=studentworkers
                availabilitycalc(:,i+1)=zeros(1,length(roster));
            end
            if schedulebyhour(i+2)>=studentworkers
                availabilitycalc(:,i+2)=zeros(1,length(roster));
            end
        elseif(availabilitycalc(index,i+1)==1&availabilitycalc(index,i-1)==1&scheduledbyperson(index)<=maxhours-3)
            hourlystats(6)=hourlystats(6)+1;
            schedule(index,i)=1;
            schedule(index,i+1)=1;
            schedule(index,i-1)=1;
            availabilitycalc(index,i)=0;
            availabilitycalc(index,i+1)=0;
            availabilitycalc(index,i+2)=0;
            availabilitycalc(index,i-2)=0;
            availabilitycalc(index,i-1)=0;
            availabilitycalc(index,i+3)=0;
            availabilitycalc(index,i-3)=0;
            if(scheduledbyperson(index)>=maxhours)
                availabilitycalc(index,:)=zeros(length(schedulebyhour),1);
            end
            schedulebyhour=recalculateavailability(schedule);
            if schedulebyhour(i)>=studentworkers
                availabilitycalc(:,i)=zeros(1,length(roster));
            end
            if schedulebyhour(i+1)>=studentworkers
                availabilitycalc(:,i+1)=zeros(1,length(roster));
            end
            if schedulebyhour(i-1)>=studentworkers
                availabilitycalc(:,i-1)=zeros(1,length(roster));
            end
            
        elseif(availabilitycalc(index,i-1)==1&availabilitycalc(index,i-2)==1&scheduledbyperson(index)<=maxhours-3)
            hourlystats(7)=hourlystats(7)+1;
            schedule(index,i)=1;
            schedule(index,i-1)=1;
            schedule(index,i-2)=1;
            availabilitycalc(index,i)=0;
            availabilitycalc(index,i+1)=0;
            availabilitycalc(index,i-3)=0;
            availabilitycalc(index,i-2)=0;
            availabilitycalc(index,i-1)=0;
            availabilitycalc(index,i+2)=0;
            availabilitycalc(index,i-4)=0;
            if(scheduledbyperson(index)>=maxhours)
                availabilitycalc(index,:)=zeros(length(schedulebyhour),1);
            end
            schedulebyhour=recalculateavailability(schedule);
            if schedulebyhour(i)>=studentworkers
                availabilitycalc(:,i)=zeros(1,length(roster));
            end
            if schedulebyhour(i-1)>=studentworkers
                availabilitycalc(:,i-1)=zeros(1,length(roster));
            end
            if schedulebyhour(i-2)>=studentworkers
                availabilitycalc(:,i-2)=zeros(1,length(roster));
            end
        elseif(availabilitycalc(index,i-1)==1&scheduledbyperson(index)<=maxhours-2)
            hourlystats(8)=hourlystats(8)+1;
            schedule(index,i)=1;
            schedule(index,i-1)=1;
            availabilitycalc(index,i)=0;
            availabilitycalc(index,i+1)=0;
            availabilitycalc(index,i-2)=0;
            availabilitycalc(index,i-1)=0;
            availabilitycalc(index,i+2)=0;
            availabilitycalc(index,i-3)=0;
            if(scheduledbyperson(index)>=maxhours)
                availabilitycalc(index,:)=zeros(length(schedulebyhour),1);
            end
            schedulebyhour=recalculateavailability(schedule);
            if schedulebyhour(i)>=studentworkers
                availabilitycalc(:,i)=zeros(1,length(roster));
            end
            if schedulebyhour(i-1)>=studentworkers
                availabilitycalc(:,i-1)=zeros(1,length(roster));
            end
            
        elseif(availabilitycalc(index,i+1)==1&scheduledbyperson(index)<=maxhours-2)
            hourlystats(9)=hourlystats(9)+1;
            schedule(index,i)=1;
            schedule(index,i+1)=1;
            availabilitycalc(index,i)=0;
            availabilitycalc(index,i+1)=0;
            availabilitycalc(index,i+2)=0;
            availabilitycalc(index,i-1)=0;
            availabilitycalc(index,i+3)=0;
            availabilitycalc(index,i-2)=0;
            if(scheduledbyperson(index)>=maxhours)
                availabilitycalc(index,:)=zeros(length(schedulebyhour),1);
            end
            schedulebyhour=recalculateavailability(schedule);
            if schedulebyhour(i)>=studentworkers
                availabilitycalc(:,i)=zeros(1,length(roster));
            end
            if schedulebyhour(i+1)>=studentworkers
                availabilitycalc(:,i+1)=zeros(1,length(roster));
            end
        end
        
        
        
    catch
    end
    
    
    
end

goodness=sumsqr(studentworkers-schedulebyhour);
goodness=goodness-studentworkers*studentworkers*10;
if(goodness<goodnessbest)
    
    goodnessbest=goodness;
    schedulebest=schedule;
end
end
schedule=schedulebest;

availabilitybyhour=recalculateavailability(availability);
schedulebyhour=recalculateavailability(schedule);
availabilitybyperson=recalculateavailabilityperson(availability);
scheduledbyperson=recalculateavailabilityperson(schedule);









schedulebyhour=schedulebyhour(6:173);
schedule=schedule(:,6:173);




timelabels=cell(1,168);
days=cellstr(['Mon';'Tue';'Wed';'Thu';'Fri';'Sat';'Sun']);
for i=1:168
    if(i<29)
        day='Mon ';
        x=7.5+0.5*i;
    elseif(i<57)
        day='Tue ';
        x=7.5+0.5*(i-28);
    elseif(i<85)
        day='Wed ';
        x=7.5+0.5*(i-56);
    elseif(i<113)
        day='Thu ';
        x=7.5+0.5*(i-84);
    elseif(i<141)
        day='Fri ';
        x=7.5+0.5*(i-112);
    elseif(i<155)
        day='Sat ';
        x=11.5+0.5*(i-140);
    else
        day='Sun ';
        x=11.5+0.5*(i-154);
    end
    
    if(x-floor(x))<0.1
        x=strcat(day,num2str(floor(x)),':00');
    else
        x=strcat(day,num2str(floor(x)),':30');
    end
    timelabels(i)=cellstr(x);
end
time=num2cell(time);

availability = availability(:,1:168);
availability1=num2cell(availability+schedule);
availability1 = availability1(:,1:168);
emptybox=cellstr('schedule');

timelabels=transpose(timelabels);
emptycells=cell(2,3);
personlabels=[cellstr(' '),cellstr('Available Hours'),cellstr('Scheduled Hours')];
personlabels1=[cell(length(roster),1),num2cell(transpose([availabilitybyperson/2;scheduledbyperson/2]))];
personlabels1=[personlabels;personlabels1];
hourlabels=[cellstr(' ');cellstr('Students Working')];
hourlabels1=[cell(1,168);num2cell(schedulebyhour)];
hourlabels1=[hourlabels,hourlabels1];
biglist = [emptybox,transpose(timelabels);roster,availability1];
biglist = [biglist,personlabels1;hourlabels1,emptycells];

try
    delete 'X.xls'
catch
end
try
    
    xlswrite('X.xls',biglist)
    
    winopen('X.xls')
catch
    disp('Sorry, the excel document cannot be modified while it''s open :(');
end
