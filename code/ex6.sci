x = [1, 2, -3, 2, 1];
h = [1, 0, -1];
nx = 0:length(x)-1;
nh = 0:length(h)-1;

Lx = length(x);
Lh = length(h);
Ly = Lx + Lh - 1;

y_fold = zeros(1, Ly);
for n = 0:Ly-1
    for k = 0:Lh-1
        if (n - k) >= 0 & (n - k) < Lx then
            y_fold(n+1) = y_fold(n+1) + h(k+1) * x(n-k+1);
        end
    end
end
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
Eh = sum(h.^2);
Ey = sum(y_fold.^2);

scf(0);
clf();

subplot(2,2,1);
plot2d3(nx, x);
a = gca(); a.data_bounds = [-0.5, min(x)-0.5; max(nx)+0.5, max(x)+0.5];
a.y_location = "left"; a.x_location = "bottom";
title("x(n)");
xlabel("n");
ylabel("Amplitude");

subplot(2,2,2);
plot2d3(nh, h);
a = gca(); a.data_bounds = [-0.5, min(h)-0.5; max(nh)+0.5, max(h)+0.5];
a.y_location = "left"; a.x_location = "bottom";
title("h(n)");
xlabel("n");
ylabel("Amplitude");

subplot(2,2,3);
plot2d3(ny, y_fold);
a = gca(); a.data_bounds = [-0.5, min(y_fold)-0.5; max(ny)+0.5, max(y_fold)+0.5];
a.y_location = "left"; a.x_location = "bottom";
title("y(n) - Linear Convolution");
xlabel("n");
ylabel("Amplitude");

subplot(2,2,4);
bar([1, 2, 3], [Ex, Eh, Ey]);
title("Energy: Ex=" + string(Ex) + ", Eh=" + string(Eh) + ", Ey=" + string(Ey));
xlabel("Signal");
ylabel("Energy");
