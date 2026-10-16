%MARGUIN_GAUSS Gaussian transition between lithological properties.
%
%   Ga = MARGUIN_GAUSS(x0, differenceX, y0, differenceY, ...
%                      value_max, value_min, x, y)
%
%   returns a one- or two-dimensional Gaussian distribution used to
%   prescribe gradual variations in lithology-dependent properties. The
%   function is centred at (x0,y0), where Ga equals value_min, and tends
%   asymptotically towards value_max away from the centre.
%
%   The distribution is defined as
%
%       Ga = value_max - (value_max - value_min) *
%            exp[-((x-x0)^2/(2*sigmaX^2) +
%                  (y-y0)^2/(2*sigmaY^2))].
%
%
%   INPUTS
%     x0, y0              Coordinates of the centre.

%     differenceX         Horizontal length-scale parameter.
%                         Set to zero to suppress horizontal variation.

%     differenceY         Vertical length-scale parameter.
%                         Set to zero to suppress vertical variation.

%     value_max           Property value away from the centre.

%     value_min           Property value at the centre.

%     x, y                Coordinates 
%
%   OUTPUT
%     Ga                   Interpolated property value(s)
%
%   The names value_min and value_max denote the centre and background
%   values used in the original model.
%
%   For permeability, apply this function to log10(permeability) so that
%   the transition occurs in logarithmic space.
%
%   Author: Valentin Marguin
%   Last updated: 28 August 2026

function Ga = marguin_gauss(x0, differenceX, y0, differenceY, ...
    value_max, value_min, x, y)

    if differenceX == 0
        gaussianX = zeros(size(x));
    else
        sigmaX = (2*differenceX/3) / sqrt(2*log(2));
        gaussianX = (x-x0).^2 ./ (2*sigmaX.^2);
    end
    
    if differenceY == 0
        gaussianY = zeros(size(y));
    else
        sigmaY = (2*differenceY/3) / sqrt(2*log(2));
        gaussianY = (y-y0).^2 ./ (2*sigmaY.^2);
    end

amplitude = value_background - value_center;
Ga = value_background - amplitude .* exp(-(gaussianX + gaussianY));

end
