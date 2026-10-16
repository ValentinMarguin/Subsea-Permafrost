function water_position = water_cycle(time)
%WATER_CYCLE Reconstructs the cyclic sea-level forcing.
%
%   water_position = WATER_CYCLE(time) returns the relative sea-level
%   position calculated from a 15th-order polynomial approximation of the
%   0–125 ka interval of the Red Sea sea-level record.
%
%   INPUT
%       time            Simulation time (years)
%
%   OUTPUT
%       water_position  Relative sea-level position (m)
%
%   DATA SOURCE
%       The polynomial coefficients were derived from the 0–125 ka
%       interval of Supplementary Data 1 in:
%
%       Grant, K. M. et al. Sea-level variability over five glacial
%       cycles. Nature Communications 5, 5076 (2014).
%       https://doi.org/10.1038/ncomms6076
%
%   The original dataset is available from the article webpage and is not
%   redistributed with this code. Time was normalized by the 125-kyr
%   duration before fitting a 15th-order polynomial. The resulting forcing
%   is repeated periodically and shifted by 21 kyr to initialize each
%   simulation at the Last Glacial Maximum.
%
%   Author: Valentin Marguin
%   Last updated: 28 August 2026

load("coefficient_water.mat")
cycle_duration = 125; % Duration of the fitted record (kyr)

% Polynomial coefficients 
polynomial_coefficients = polynomial_coefficients_water;

% Convert simulation time from years to kyr.
time_kyr = time ./ 1000;

% Determine the normalized position within the repeated 125-kyr cycle.
cycle_phase = mod(21 - time_kyr, cycle_duration) ...
    ./ cycle_duration;

% Evaluate the polynomial sea-level approximation.
water_position = polyval(polynomial_coefficients, cycle_phase);

end
