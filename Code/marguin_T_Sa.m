function [S_w, S_i] = marguin_T_Sa(S_n0, P)
%MARGUIN_T_SA Estimate maximum ice saturation just above the eutectic.
%
%   [S_w, S_i] = marguin_T_Sa(S_n0, P)
%
%   INPUTS (finite real scalars)
%       S_n0  Initial salinity [wt%, g per 100 g of solution].
%       P     Sea pressure [dbar], relative to atmospheric pressure.
%
%   OUTPUTS at -21.59 deg C
%       S_w   Residual liquid-water saturation [-].
%       S_i   Maximum ice saturation estimate, 1 - S_w [-].
%
%   ASSUMPTIONS
%       Salt-free ice and fixed pore volume.
%       Density depends only on salinity through an approximate
%       marine-brine relation; direct temperature and pressure effects
%       on density are neglected.

%   REFERENCES
%      
%       Cox, G. F. N., and Weeks, W. F. (1983).
%       Equations for Determining the Gas and Brine Volumes
%       in Sea-Ice Samples.
%       Journal of Glaciology, 29(102), 306-316.
%       https://doi.org/10.3189/S0022143000008364
%
%
%   EXAMPLE
%       [~, Si_max] = marguin_T_Sa(3.5, 0);

S_n0 = double(S_n0);
P = double(P);

%% Evaluation temperature

% Fixed temperature, 0.01 deg C above the prescribed eutectic.
T = -21.59;

%% Residual brine salinity

% Empirical salinity-temperature relation; output in wt%.
x = abs(T);

S_n = 1.76958*x - 0.0423842*x^2 + 0.00052778*x^3;

%% Salinity-dependent densities

% Approximate marine-brine relation used by Cox and Weeks (1983):
% rho = 1000 + 0.8*S, with S in g/kg and rho in kg/m^3.
% For salinity in wt%, the coefficient becomes 8.
% Direct temperature and pressure effects on density are neglected.
rho_0 = 1000 + 8*S_n0;
rho_n = 1000 + 8*S_n;

%% Liquid-water and ice saturations

% Salt conservation, assuming salt-free ice and fixed pore volume.
S_w = rho_0*S_n0/(rho_n*S_n);
S_i = 1 - S_w;

end