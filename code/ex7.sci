x = [1, 2, -3, 2, 1];
h = [1, 0, -1, -1, 1];
N = length(x);

y_circ = zeros(1, N);
for n = 0:N-1
    for k = 0:N-1
        idx = modulo(n - k + N, N);
        y_circ(n+1) = y_circ(n+1) + h(k+1) * x(idx+1);
    end
end

X_circ = zeros(N, N);
for i = 1:N
    for j = 1:N
        idx = modulo(i - j + N, N);
        X_circ(i, j) = x(idx + 1);
    end
end
y_matrix = (X_circ * h')';

disp("Folding and Shifting result:");
disp(y_circ);
disp("Matrix method result:");
disp(y_matrix);
disp("Circulant matrix:");
disp(X_circ);

Ex = sum(x.^2);
Ey = sum(y_circ.^2);

n_range = 0:N-1;

scf(0);
clf();

subplot(2,2,1);
plot2d3(n_range, x);
title("x(n)");
xlabel("n");
ylabel("Amplitude");

subplot(2,2,2);
plot2d3(n_range, h);
title("h(n)");
xlabel("n");
ylabel("Amplitude");

subplot(2,2,3);
plot2d3(n_range, y_circ);
title("y(n) - Circular Convolution");
xlabel("n");
ylabel("Amplitude");

subplot(2,2,4);
bar([1, 2], [Ex, Ey]);
title("Energy: Ex=" + string(Ex) + ", Ey=" + string(Ey));
xlabel("Signal");
ylabel("Energy");
