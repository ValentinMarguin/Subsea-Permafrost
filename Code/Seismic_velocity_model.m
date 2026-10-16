%% Seismic velocity by Lee et al., 1996


% Sediment porosity after compaction
porosity_final = (phi0 - 5e-5*abs(g_coord(2,:)));

% Pore-ice saturation: fraction of the pore volume occupied by ice
pore_ice_saturation = ice_saturation(file,:);

% Corresponding volumetric fractions relative to bulk sediment volume
volumetric_ice_fraction   = porosity_final .* ice_saturation;
volumetric_water_fraction = porosity_final .* (1-ice_saturation);

density_mean = (1-porosity_final)*2700 ...
    + volumetric_ice_fraction*920 ...
    + volumetric_water_fraction*1000;

valeur1 = volumetric_water_fraction./(1000*1435^2) ...
    + volumetric_ice_fraction./(920*3800^2) ...
    + (1-porosity_final)./(2700*4000^2);

vitesse = sqrt(1./(density_mean.*valeur1));
