%% Initialization
clc;
close all;

N = 1e5;        % Total number of symbols to transmit
Nt = 2;         % Number of transmit antennas
Nr = 2;         % Number of receive antennas
M = 2;          % Modulation order (BPSK => M=2)

%% Bitstream Generation and Mapping
N_ant = log2(Nt);   % Number of bits for antenna selection
N_mod = log2(M);    % Number of bits for modulation

xs = randi([0,1], N_mod+N_ant, N);  % Random bit generation for all symbols

ant_select = xs(1:N_ant, :);                    % Extract bits for antenna selection
sym_select = xs(N_ant+1:end, :);                % Extract bits for symbol modulation

ant_index = bi2de(ant_select', 'left-msb') + 1; % Convert antenna bits to indices (1-based for MATLAB)
sym_index = bi2de(sym_select', 'left-msb');     % Convert modulation bits to symbol indices

x1 = pskmod(sym_index', M, 0, 'gray');          % PSK modulation (BPSK here)

x3 = zeros(Nt, N);                               % Initialize transmission matrix

% Insert modulated symbol at the selected antenna for each time slot
for i1 = 1:N
    x3(ant_index(i1), i1) = x1(i1);
end

%% Reference Signal Construction (all possible transmit combinations)
BER1 = [];

x41 = 0:M*Nt-1;                                        % All possible combinations of bits
x21 = de2bi(x41, N_mod+N_ant, 'left-msb');             % Convert to bit representation

x61 = x21(:, N_ant+1:end);                             % Bits for modulation
x62 = bi2de(x61, 'left-msb');                          % Symbol indices
x71 = pskmod(x62, M, 0, 'gray');                       % Modulated symbols

x31 = x21(:, 1:log2(Nt));                              % Bits for antenna
x42 = bi2de(x31, 'left-msb');                          % Antenna indices
x81 = x42 + 1;                                         % Convert to 1-based indexing

x_ref = zeros(Nt*M, Nt);                               % Initialize reference transmit signals

% Construct each reference signal by placing the symbol on the selected antenna
for i = 1:Nt*M
    x_ref(i, x81(i)) = x71(i);
end

%% Simulation over different SNR values
SNR = 0:2:30;                             % SNR values in dB
snr_val = zeros(1, length(SNR));         % Linear SNR values

% Initialize BER computation
for ii = 1:length(SNR)
    snr_val(ii) = 10^(SNR(ii)/10);       % Convert SNR from dB to linear scale

    for ji = 1:N
        % Generate random Rayleigh fading channel
        H = 1/sqrt(2)*(randn(Nr,Nt) + 1i*randn(Nr,Nt));

        % Generate AWGN noise
        n = 1/sqrt(2)*(randn(Nr,1) + 1i*randn(Nr,1));

        % Transmit signal through the channel
        xtx(:, ji) = H * x3(:, ji);
        ysd1(:,:,ji) = sqrt(snr_val(ii)) * xtx(:, ji) + n;  % Received signal with noise


        % ML Detection: Compare against all possible reference transmit vectors
        for k1 = 1:M*Nt
            % Reconstruct expected received signal for hypothesis k1
            x_ref2(:, ji) = sum(H .* x_ref(k1,:) .* sqrt(snr_val(ii)), 2);

            % Compute Euclidean distance between received and expected signal
            y(k1, ji) = norm(ysd1(:,:,ji) - x_ref2(:, ji));

            % Find index of minimum distance (i.e., best match)
            [~, rx_sym] = min(y(:, ji));
            Rx_symbols(ji) = rx_sym - 1;  % Store detected symbol index (0-based)
        end
    end

    % Convert detected and transmitted symbols to bits for BER calculation
    Rx_symbols_bin = reshape(de2bi(Rx_symbols, log2(Nt*M), 'left-msb')', 1, []);
    xs_bin = reshape(xs, 1, []);  % Original bits

    % Count bit errors
    num_error(ii) = sum(Rx_symbols_bin ~= xs_bin);

    % Compute BER
    ber(ii) = num_error(ii) / length(Rx_symbols_bin);
end

%% Plot BER vs SNR
figure;
semilogy(SNR, ber, 'bo-');         % Plot BER on logarithmic scale
xlabel('SNR (dB)');
ylabel('Bit Error Rate (BER)');
title('Bit Error Rate vs SNR');
grid on;
