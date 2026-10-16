function surface_temperature = temperature_cycle(time)
%TEMPERATURE_CYCLE Reconstructs the cyclic atmospheric-temperature forcing.
%
%   surface_temperature = TEMPERATURE_CYCLE(time) returns the mean annual
%   air temperature calculated from a 12th-order polynomial approximation
%   of the 0–125 ka palaeotemperature record.
%
%   INPUT
%       time                 Simulation time (years)
%
%   OUTPUT
%       surface_temperature  Mean annual air temperature (degrees C)
%
%   DATA SOURCE
%       The polynomial coefficients were derived from the 0–125 ka
%       interval of the Vostok palaeotemperature record reported by:
%
%       Petit, J. R. et al. Climate and atmospheric history of the past
%       420,000 years from the Vostok ice core, Antarctica.
%       Nature 399, 429–436 (1999).
%       https://doi.org/10.1038/20859
%
%   The original dataset is not redistributed with this code. Temperature
%   anomalies were converted to absolute mean annual air temperatures
%   using a reference temperature of -11.5 °C, representative of
%   the Beaufort coast. Time was normalized by the 125-kyr duration before
%   fitting a 12th-order polynomial. The resulting forcing is periodically
%   repeated and shifted by 21 kyr to initialize each simulation at the
%   Last Glacial Maximum.
%
%   Author: Valentin Marguin
%   Last updated: 28 August 2026


load("coefficient_temperature.mat")

cycle_duration = 125e3; % Duration of the fitted record (years)

% Polynomial coefficients
polynomial_coefficients = polynomial_coefficients_temperature;

% Determine the normalized position within the repeated 125-kyr cycle.
cycle_phase = mod(21e3 - time, cycle_duration) ...
    ./ cycle_duration;

% Evaluate the polynomial temperature approximation.
surface_temperature = polyval( ...
    polynomial_coefficients, cycle_phase);

end
