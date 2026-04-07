x = [1, 2, -3, 2, 1];
h = [1, 0, -1];
nx = 0:length(x)-1;
nh = 0:length(h)-1;

Lx = length(x);
Lh = length(h);
Ly = Lx + Lh - 1;

y_fold = convol(h, x);
ny = 0:(Ly-1);

H = zeros(Ly, Lx);
for i = 1:Ly
    for j = 1:Lx
        k = i - j;
        if k >= 0 & k < Lh then
            H(i, j) = h(k + 1);
        end
    end
end
y_matrix = H * x';

disp("Folding and Shifting result:");
disp(y_fold);
disp("Matrix method result:");
disp(y_matrix');
disp("Convolution matrix H:");
disp(H);

Ex = sum(x.^2);
Ey = sum(y_fold.^2);

scf(0);
clf();

subplot(2,2,1);
plot2d3(nx, x);
title("x(n)");
xlabel("n");
ylabel("Amplitude");

subplot(2,2,2);
plot2d3(nh, h);
title("h(n)");
xlabel("n");
ylabel("Amplitude");

subplot(2,2,3);
plot2d3(ny, y_fold);
title("y(n) - Linear Convolution");
xlabel("n");
ylabel("Amplitude");

subplot(2,2,4);
bar([1, 2], [Ex, Ey]);
title("Energy: Ex=" + string(Ex) + ", Ey=" + string(Ey));
xlabel("Signal");
ylabel("Energy");
