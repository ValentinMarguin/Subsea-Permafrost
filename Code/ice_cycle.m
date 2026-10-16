function [surface_temperature, water_position] = ice_cycle(time)

%ICE_CYCLE Idealized, periodic long-period glacial forcing.

%   [SURFACE_TEMPERATURE, WATER_POSITION] = ICE_CYCLE(TIME)

%   INPUT
%       time            Simulation time (years)

%   OUTPUTS:
%     SURFACE_TEMPERATURE : prescribed temperature forcing (deg C).
%     WATER_POSITION      : sea level relative to the reference datum (m).
%
%   The original 125,000-year period and forcing curves are preserved.
%   Temperature and sea level share the same dimensionless cycle shape.
%   Marine temperature boundary conditions must be applied separately.
%   Compatible with MATLAB R2018b.

%   DATA SOURCE

%       Grant, K. M. et al. Sea-level variability over five glacial
%       cycles. Nature Communications 5, 5076 (2014).
%       https://doi.org/10.1038/ncomms6076

%       Petit, J. R. et al. Climate and atmospheric history of the past
%       420,000 years from the Vostok ice core, Antarctica.
%       Nature 399, 429–436 (1999).
%       https://doi.org/10.1038/20859

%   Author: Valentin Marguin
%   Last updated: 28 August 2026


% Cycle duration and dimensionless shape parameters.
cycle_period = 125000;          % years
growth_rate  = 1;
decay_rate   = 6;

% Offsets and scale factors (scale factors are not peak amplitudes).
temperature_offset = -20;      % deg C
temperature_scale  = 160;      % deg C
sea_level_offset   = -129;     % m
sea_level_scale    = 2295;     % m

% Phase in [0, 1); use the original wrapping expression.
cycles = time ./ cycle_period;
phase = cycles - floor(cycles);

% Stable evaluation of 1 - exp(-growth_rate * phase).
cycle_shape = -expm1(-growth_rate .* phase) ...
    .* exp(-decay_rate .* phase);

surface_temperature = temperature_offset + temperature_scale .* cycle_shape;
water_position = sea_level_offset + sea_level_scale .* cycle_shape;

% The maximum occurs at phase = log(1 + growth_rate/decay_rate)/growth_rate.
% This waveform has a small jump when phase resets from 1 to 0;
% it is intentionally retained to preserve the original forcing.
end