function Hd = Gaussian_Noise_Filter
%GAUSSIAN_NOISE_FILTER Returns a discrete-time filter object.

Fs = 8192;  % Sampling Frequency

N  = 4;     % Order
Fc = 1200;  % Cutoff Frequency

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.lowpass('N,F3dB', N, Fc, Fs);
Hd = design(h, 'butter');

% [EOF]
