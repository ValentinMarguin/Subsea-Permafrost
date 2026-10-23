clear;
clc;

%% List of variables to reconstruct
variables = {
    'salinity'
    'excess_fluid_pressure'
    'ice_saturation'
    'temperature'
    'x_velocity'
    'y_velocity'
    'Porosity_rock'
    'g_coord'
    'edge'
    'g_num0'
    'Time'
    };

results = struct();

%% Reconstruct all variables
for i = 1:length(variables)

    name = variables{i};

    % Find all parts of the variable
    files = dir([name '_part*.mat']);

    if isempty(files)
        error('Missing files for variable: %s', name);
    end

    % Sort files in the correct order
    [~, order] = sort({files.name});
    files = files(order);

    parts = cell(length(files), 1);

    for k = 1:length(files)

        % Load each part
        S = load(files(k).name);

        parts{k} = S.bloc(:);

    end

    % Reconstruct the original variable dimensions
    results.(name) = reshape( ...
        vertcat(parts{:}), S.taille_originale);

    fprintf('%s reconstructed (%d parts)\n', ...
        name, length(files));

end

%% Save all reconstructed variables in a single MAT file
save('resultats_PoreSize_longCycle_COMPLETE.mat', ...
    '-struct', 'results', '-v7.3');

disp('All variables have been successfully reconstructed!');

%% load

load('resultats_COMPLETE.mat');