person_name = 'hoan';
consonant = 'i'; % [a, e, u, o, i]
file_name = strcat(strcat(person_name, '_'), strcat(consonant, '.wav'));
fs = 8000;
l_w = 256;
n_fft = 1024;
switch consonant
    case 'a'
        consonant_range(1, 1) = 0.45; % Chung
        consonant_range(1, 2) = 0.9;
        consonant_range(2, 1) = 0.75; % Hoan
        consonant_range(2, 2) = 1.2;
        consonant_range(3, 1) = 0.8; % Huy
        consonant_range(3, 2) = 1.25;   
    case 'e'
        consonant_range(1, 1) = 0.6;
        consonant_range(1, 2) = 1.1;
        consonant_range(2, 1) = 0.65;
        consonant_range(2, 2) = 1.05;
        consonant_range(3, 1) = 0.9;
        consonant_range(3, 2) = 1.3;
    case 'u'
        consonant_range(1, 1) = 1;
        consonant_range(1, 2) = 1.45;
        consonant_range(2, 1) = 0.8;
        consonant_range(2, 2) = 1.15;
        consonant_range(3, 1) = 0.95;
        consonant_range(3, 2) = 1.3;      
    case 'o'
        consonant_range(1, 1) = 0.5;
        consonant_range(1, 2) = 0.95;
        consonant_range(2, 1) = 0.9;
        consonant_range(2, 2) = 1.25;
        consonant_range(3, 1) = 1.05;
        consonant_range(3, 2) = 1.4;
    case 'i'
        consonant_range(1, 1) = 0.5;
        consonant_range(1, 2) = 0.95;
        consonant_range(2, 1) = 1;
        consonant_range(2, 2) = 1.25;
        consonant_range(3, 1) = 1;
        consonant_range(3, 2) = 1.4;        
    otherwise
end

total_t = 0;

file_name = strcat(strcat('chung', '_'), strcat(consonant, '.wav'));
t_start = consonant_range(1, 1);
t_end = consonant_range(1, 2);
formants1 = find_formants(file_name, t_start, t_end);
[result, f, t] = custom_spectrogram(file_name, l_w, n_fft);
result = mag2db(result);
dt = 1/fs;
I0 = floor(round(t_start/dt)/l_w);
Iend = ceil(round(t_end/dt)/l_w);
result_ranged1 = result(:, I0:Iend);
%result_ranged = [result_ranged result_ranged];
t1 = (I0*l_w:l_w:Iend*l_w)/fs;
total_t = total_t + length(t1);

file_name = strcat(strcat('hoan', '_'), strcat(consonant, '.wav'));
t_start = consonant_range(2, 1);
t_end = consonant_range(2, 2);
formants2 = find_formants(file_name, t_start, t_end);
[result, f, t] = custom_spectrogram(file_name, l_w, n_fft);
result = mag2db(result);
dt = 1/fs;
I0 = floor(round(t_start/dt)/l_w);
Iend = ceil(round(t_end/dt)/l_w);
result_ranged2 = result(:, I0:Iend);
%result_ranged = [result_ranged result_ranged];
t2 = (I0*l_w:l_w:Iend*l_w)/fs;
total_t = total_t + length(t2);

file_name = strcat(strcat('huy', '_'), strcat(consonant, '.wav'));
t_start = consonant_range(3, 1);
t_end = consonant_range(3, 2);
formants3 = find_formants(file_name, t_start, t_end);
[result, f, t] = custom_spectrogram(file_name, l_w, n_fft);
result = mag2db(result);
dt = 1/fs;
I0 = floor(round(t_start/dt)/l_w);
Iend = ceil(round(t_end/dt)/l_w);
result_ranged3 = result(:, I0:Iend);
%result_ranged = [result_ranged result_ranged];
t3 = (I0*l_w:l_w:Iend*l_w)/fs;
total_t = total_t + length(t3);

time1 = length(t1)*256/fs;
time2 = length(t2)*256/fs;
time3 = length(t3)*256/fs;

new_result = [result_ranged1 result_ranged2 result_ranged3];

t = (0:l_w:(total_t-1)*l_w)/fs;

figure(1)

surf(t, f, new_result)
shading interp
axis tight
view(0, 90)
xlabel('Thoi Gian, s')
ylabel('Tan So, Hz')
title(strcat('Spectrogram nguyen am .', consonant))
hcol = colorbar;
set(hcol, 'FontName', 'Times New Roman', 'FontSize', 14)
ylabel(hcol, 'Cuong Do, dB')

for i=1:length(formants1)
    a = [0,time1];
    b = [formants1(i),formants1(i)];
    p = line(a,b);
    p.LineWidth = 2;
    p.Color = 'red';
    q = text(0.1, formants1(i) + 120, strcat('f', num2str(i)));
    q.Color = 'red';
    q.FontSize = 15;
end

for i=1:length(formants2)
    a = [time1, time1 + time2];
    b = [formants2(i),formants2(i)];
    p = line(a,b);
    p.LineWidth = 2;
    p.Color = 'black';
    q = text(0.2 + time1, formants2(i) - 65, strcat('f', num2str(i)));
    q.Color = 'black';
    q.FontSize = 15;
end

for i=1:length(formants3)
    a = [time1 + time2, time1+ time2+ time3];
    b = [formants3(i),formants3(i)];
    p = line(a,b);
    p.LineWidth = 2;
    p.Color = 'white';
    q = text(0.3 + time1+ time2, formants3(i) + 120, strcat('f', num2str(i)));
    q.Color = 'white';
    q.FontSize = 15;
end

