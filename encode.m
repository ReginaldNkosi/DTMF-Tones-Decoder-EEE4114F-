function [y,noisy] = encode(number)

   switch(number) % switch function 
        case 49
            f1 = 697; f2 = 1209;
        case 50
            f1 = 697; f2 = 1336;
        case 51
            f1 = 697; f2 = 1477;
        case 52
            f1 = 770; f2 = 1209;
        case 53
            f1 = 770; f2 = 1336;
        case 54
            f1 = 770; f2 = 1477;
        case 55
            f1 = 852; f2 = 1209;
        case 56
            f1 = 852; f2 = 1336;
        case 57
            f1 = 852; f2 = 1477;
        case 42
            f1 = 941; f2 = 1209;
        case 48
            f1 = 941; f2 = 1336;
        case 35
            f1 = 941; f2 = 1477;
        otherwise
            disp("opps");
    end
    t =0:0.000125:0.025625;
    fs = 8000;
    y1 = .5*sin(2*pi*f1*t);
    y2 = .5*sin(2*pi*f2*t);
    y = y1+y2;
    noisy = awgn(y,1.5); % adding white noise
    soundsc(noisy,fs)
end
