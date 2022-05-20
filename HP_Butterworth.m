function Hd = HP_Butterworth

% All frequency values are in Hz.
Fs = 8192;  % Sampling Frequency

N  = 100;   % Order
Fc = 3080;  % Cutoff Frequency

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.highpass('N,F3dB', N, Fc, Fs);
Hd = design(h, 'butter');

% [EOF]
