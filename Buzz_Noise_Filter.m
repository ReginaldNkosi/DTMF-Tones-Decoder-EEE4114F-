function Hd = Buzz_Noise_Filter

Fs = 8192;  % Sampling Frequency

Fpass1 = 38;          % First Passband Frequency
Fstop1 = 40;          % First Stopband Frequency
Fstop2 = 60;          % Second Stopband Frequency
Fpass2 = 62;          % Second Passband Frequency
Apass1 = 0.5;         % First Passband Ripple (dB)
Astop  = 60;          % Stopband Attenuation (dB)
Apass2 = 1;           % Second Passband Ripple (dB)
match  = 'stopband';  % Band to match exactly

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.bandstop(Fpass1, Fstop1, Fstop2, Fpass2, Apass1, Astop, ...
                      Apass2, Fs);
Hd = design(h, 'butter', 'MatchExactly', match);

% [EOF]
