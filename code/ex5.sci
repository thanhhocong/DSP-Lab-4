N = 200;
img = zeros(N, N);
for i = 1:N
    for j = 1:N
        if ((i-80)^2 + (j-80)^2) < 1600 then
            img(i,j) = 200;
        end
        if ((i-140)^2 + (j-140)^2) < 900 then
            img(i,j) = 120;
        end
        if i > 30 & i < 60 & j > 130 & j < 190 then
            img(i,j) = 255;
        end
    end
end
img = img + 20*grand(N, N, "nor", 0, 1);
img = min(max(round(img), 0), 255);

f = scf(0);
clf();
f.color_map = linspace(0, 1, 256)' * [1 1 1];

subplot(2,2,1);
Matplot(img($:-1:1,:) + 1);
title("Original Image");

h_vals = zeros(1, 256);
for i = 1:N
    for j = 1:N
        h_vals(img(i,j) + 1) = h_vals(img(i,j) + 1) + 1;
    end
end

subplot(2,2,2);
bar(0:255, h_vals);
title("Histogram");
xlabel("Intensity");
ylabel("Count");

padded = zeros(N+2, N+2);
padded(2:N+1, 2:N+1) = img;
blurred = (padded(1:N, 1:N) + padded(1:N, 2:N+1) + padded(1:N, 3:N+2) + ..
           padded(2:N+1, 1:N) + padded(2:N+1, 2:N+1) + padded(2:N+1, 3:N+2) + ..
           padded(3:N+2, 1:N) + padded(3:N+2, 2:N+1) + padded(3:N+2, 3:N+2)) / 9;

subplot(2,2,3);
Matplot(round(blurred($:-1:1,:)) + 1);
title("Blurred Image (3x3 Average)");

cdf = cumsum(h_vals);
cdf_min = min(cdf(cdf > 0));
total_pixels = N * N;
eq_img = zeros(N, N);
for i = 1:N
    for j = 1:N
        eq_img(i,j) = round((cdf(img(i,j) + 1) - cdf_min) / (total_pixels - cdf_min) * 255);
    end
end

subplot(2,2,4);
Matplot(eq_img($:-1:1,:) + 1);
title("Histogram Equalized");
