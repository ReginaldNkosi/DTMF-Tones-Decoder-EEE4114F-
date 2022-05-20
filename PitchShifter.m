% Pitch Shifter Code
%instantiate constants
clc;
Fs = 8000;  % Sampling frequency
Ft = 440;   % Tone A for bandpass filter
nSec = 10;    % Duration of tone
periodRatio = 2;

% Create test tone
Nout = 40000; 
Nin = nSec*Fs;
x = sin(linspace(0,nSec*Ft*2*pi,Nin));
for n = 1:1:Nout
   y(n) = 0;
   z(n) = 0;
end
%sound(x,Fs);  % Play sound at sampling rate Fs
%wavwrite(x,Fs,8,'tone_50Hz.wav');  % Save as an 8-bit, 1 kHz signal

[x,Fs,nbits]=wavread('1234.wav');
sound(x,Fs);
% plot and display test tone
figure(1);
stem(x);

% Design bandpass filter
d = fdesign.bandpass('N,Fst1,Fp1,Fp2,Fst2', 512, 340, 390, 490, 540, Fs); 
Hd = design(d);
p = filter (Hd, x); % pass x through the filter to obtain p

figure (2);
stem(p);

% instantiate contants
inptr=1;
outptr=1;
num_of_crossings=0;
old_zero_crossings=1;
num_periods=0;
% find the zero crossings from p and sample down to get higher frequency
% tone
for inptr = 1:1:Nin
    
    if (inptr+1<=Fs*nSec)
        if ((p(inptr+1)>0) && (p(inptr)<0)) || ((p(inptr+1)<0) && (p(inptr)>0)) 
        num_of_crossings = num_of_crossings + 1;
        end
    end
    if (num_of_crossings == 2)
        first_period_length = inptr - outptr;
    end
    if (num_of_crossings == 4)
        num_of_crossings = 0;
        period_length = (inptr - old_zero_crossings)/2;
        old_zero_crossings = inptr;
        for n = outptr:1:(outptr+period_length)
            if (n + (period_length*num_periods)<= Fs*nSec)
                z(round(n)) = p(round(n + (period_length*num_periods)));        
            end
        end
        outptr = outptr + periodlength;
        num_periods = num_periods + 1;
    end
end
% plot figure
figure (3);
stem(z);
sound(z,Fs);

%reset variables
inptr=1;
outptr=1;
num_of_crossings=0;
old_zero_crossings=1;
num_periods=0;
n=0;
period_length=0;

for inptr = 1:1:Nin-1
    if ((z(inptr+1)>0) && (z(inptr)<0)) || ((z(inptr+1)<0) && (z(inptr)>0)) 
        num_of_crossings = num_of_crossings + 1
    end
    if (num_of_crossings == 2)
       
        num_of_crossings = 0;
        periodlength = inptr - oldzerocrossing;
        newperiod = periodlength*periodratio;
        oldzerocrossing = inptr;
       
        for n = outptr:1:(outptr + newperiod)
            if (n>(periodlength*num_of_periods)&& n < (inptr + (periodlength*num_of_periods)))          
                y(n) = z(n-(periodlength*num_of_periods));              
            else
                y(n) = 0;                
            end            
        end
        outptr = outptr + newperiod;
        num_of_periods = num_of_periods + 1
    end    
end
figure (4);
stem(y);
sound(y,Fs);

