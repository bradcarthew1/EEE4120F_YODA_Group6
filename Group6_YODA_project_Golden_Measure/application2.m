load ImperialMarch.mat

f = 44100; % sampling frequency 
delta_t = 1/f; %time interval related to the frequency
t = (0:delta_t:10); %time array 
g = wgn(1,441000,0); %generating gaussian noise
whitenoise = (randi([-230 230],1,441000))./100; %white noise
wn_g = whitenoise.*g; % randomising the white noise 
C = num2cell(reshape(wn_g, 44100,10),1); %section array into 1 second intervals
minarr = zeros(1,10); 
maxarr = zeros(1,10); 
sec = 10; %the full time 
tic %start timer for entire 10 seconds
%To run through 10 second interval
for i = 1:10
    disp(['Time interval ' , num2str(i-1), ' seconds to ', num2str(i),' seconds']); % just to display which second interval we are in
    pos = C{i}; % select array for that second
    %tic %start the timer for finding the min and max
    pos_min = min(pos);%find the minimum of the sample set
    disp(['The minimum value is ', num2str(pos_min)]);
    minarr(i) = pos_min;
    pos_max = max(pos); %find the maximum of the sample set 
    disp(['The maximum value is ', num2str(pos_max)]);
    maxarr(i) = pos_max;
    %toc %stop the timer for the min and max finder 
    disp('-------------------------------------------------------------------------------')
end
disp("Time taken for the entire to find the min and max for the 10 seconds")
%toc %stop the timer for running through the entire 10 seconds 
%Getting the standard deviation for the minimum and maximum values 
S_min = std(minarr);
S_max = std(maxarr);
%mean of the max and min data sets 
min_mean = mean(minarr);
max_mean = mean(maxarr);
%array to hold the filtered values 
filt_min = zeros(1,10);
filt_max = zeros(1,10);
for k = 1:10
    %identifying if an min value falls within 1 standard deviation
    if ((minarr(k)<=(min_mean+S_min)) && (minarr(k)>=(min_mean-S_min)))
        %min value found within 1 standard deviation
        filt_min(k) = minarr(k);
    else 
        %min value does not fall within 1 standard deviation filter by
        %replacing with 0 
        filt_min(k) = 0;
    end
     %identifying if an max value falls within 1 standard deviation
    if ((maxarr(k)<=(max_mean+S_max)) && (maxarr(k)>=(max_mean-S_max)))
        %max value found within 1 standard deviation
        filt_max(k) = maxarr(k);
    else 
        %min value does not fall within 1 standard deviation filter by
        %replacing with 0 
        filt_max(k) = 0;
    end
end
toc %time for whole process 
%displaying the unfiltered and filtered values for both the maximum and
%minimum values to show that the application did filter out the values that
%did not fall within 1 standard deviation
disp(minarr);
disp(['The min values range from ', num2str(min_mean-S_min), ' to ' ,num2str(min_mean+S_min)]);
disp(filt_min);

disp('-------------------------------------------------------------------------------')
disp(maxarr);
disp(['The max values range from ', num2str(max_mean-S_max), ' to ' ,num2str(max_mean+S_max)]);
disp(filt_max);


