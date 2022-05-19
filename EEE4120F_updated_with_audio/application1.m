load ImperialMarch.mat
changed = dec2hex(round(10000*y));
f = 44100;  % sampling frequency
delta_t = 1/f; %time interval related to the frequency
p

sec = 10;
%num_samples = f*sec;
%g = wgn(1,num_samples,0); %generating gaussian noise
%whitenoise = (randi([-230 230],1,441000))./100; %white noise
%wn_g = whitenoise.*g; % randomising the white noise 

tic %start the timer for finding the min and max
wn_min = min(p) %find the minimum of the sample set
wn_max = max(p) %find the maximum of the sample set
toc %stop the timer for the min and max finder
x = (0:delta_t:sec-delta_t); % Getting the x axis to be in seconds and not in samples
plot(x,y)
title("Plot of the audio input to the system")
xlabel("seconds")
ylabel("amplitude")