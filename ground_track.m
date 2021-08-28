%==========================================================================
%
% ground_track  Plots the ground track of an orbit.
%
%   ground_track(lat,lon)
%   ground_track(lat,lon,opts)
%   ground_track(__,planet)
%
% See also planet3D.
%
% Copyright © 2021 Tamas Kis
% Last Update: 2021-08-28
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% IMAGE SOURCES:
% https://tamaskis.github.io/documentation/Ground_Track_Image_Sources.pdf
%
% REFERENCES:
%   [1] https://www.jpl.nasa.gov/images/pluto-color-map
%   [2] https://www.solarsystemscope.com/textures/
%   [3] https://visibleearth.nasa.gov/images/57730/the-blue-marble-land-surface-ocean-color-and-sea-ice/57731l
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   lat  	- (n×1 or 1×n double) planetodetic latitude [deg]
%   lon   	- (n×1 or 1×n double) planetodetic longitude [deg]
%   opts	- (OPTIONAL) (struct) plot options structure
%       • color         - (char or 1×3 double) line color
%                           --> can be specified as a color code (e.g. 'k')
%                           --> can be specified as an RGB triplet
%       • line_width    - (1×1 double) line width
%       • line_style	- (char) line style
%   planet 	- (OPTIONAL) (char) 'Blank', 'Sun', 'Moon', 'Mercury', 'Venus',
%             'Earth', 'Earth Cloudy', 'Earth Coastlines', 'Earth Night', 
%             'Earth Night Cloudy', 'Mars', 'Jupiter', 'Saturn', 'Uranus',
%             'Neptune', or 'Pluto'
%
%==========================================================================
function ground_track(lat,lon,opts,planet)
    
    % ------------------------------------
    % Sets (or defaults) plotting options.
    % ------------------------------------
    
    % sets line color (defaults to default MATLAB color)
    if (nargin < 3) || isempty(opts) || ~isfield(opts,'color')
        color = [0,0.4470,0.7410];
    else
        color = opts.color;
    end
    
    % sets line style (defaults to solid line)
    if (nargin < 3) || isempty(opts) || ~isfield(opts,'line_style')
        line_style = '-';
    else
        line_style = opts.line_style;
    end
    
    % sets line width (defaults to 1.5)
    if (nargin < 3) || isempty(opts) || ~isfield(opts,'line_width')
        line_width = 1.5;
    else
        line_width = opts.line_width;
    end
    
    % sets background (defaults to Earth coastlines)
    if (nargin < 4) || isempty(planet)
        planet = 'Earth Coastlines';
    end
    
    % --------------------------------------
    % Draws background of ground track plot.
    % --------------------------------------
    
    % sets background of ground track plot
    if strcmpi(planet,'Earth Coastlines')
        
        % loads Earth topographic data
        load('topo.mat','topo');

        % rearranges Earth topopgrahic data so it goes from -180 to 180 
        % deg longitude
        topoplot = [topo(:,181:360),topo(:,1:180)];

        % plots Earth map by making a contour plot of topographic data at
        % elevation of 0
        contour(-180:179,-90:89,topoplot,[0,0],'black');
        
    elseif ~strcmpi(planet,'Blank')
        
        % reads in image
        if strcmpi(planet,'Earth Cloudy')
            cdata = imread('images/earth.png')+imread('images/clouds.png');
        elseif strcmpi(planet,'Earth Night')
            cdata = imread('images/earthnight.png');
        elseif strcmpi(planet,'Earth Night Cloudy')
            cdata = imread('images/earthnight.png')+0.1*...
                imread('images/clouds.png');
        else
            cdata = imread(strcat('images/',lower(planet),'.png'));
        end
        
        % plots background
        image('CData',flipud(cdata),'XData',[-180,180],'YData',[-90,90]);
        
        % determines grid style based on background
        if strcmpi(planet,'Sun')
            grid_line_width = 1;
            grid_color = 'k';
        elseif strcmpi(planet,'Moon')
            grid_line_width = 0.75;
            grid_color = 'y';
        elseif strcmpi(planet,'Mercury')
            grid_line_width = 0.75;
            grid_color = 'y';
        elseif strcmpi(planet,'Venus')
            grid_line_width = 0.5;
            grid_color = 'k';
        elseif strcmpi(planet,'Earth')
            grid_line_width = 0.5;
            grid_color = 'y';
        elseif strcmpi(planet,'Earth Cloudy')
            grid_line_width = 1.5;
            grid_color = 'y';
        elseif strcmpi(planet,'Earth Night')
            grid_line_width = 0.5;
            grid_color = [0.5,0.5,0.5];
        elseif strcmpi(planet,'Earth Night Cloudy')
            grid_line_width = 0.5;
            grid_color = [0.5,0.5,0.5];
        elseif strcmpi(planet,'Mars')
            grid_line_width = 0.75;
            grid_color = 'y';
        elseif strcmpi(planet,'Jupiter')
            grid_line_width = 1;
            grid_color = 'k';
        elseif strcmpi(planet,'Saturn')
            grid_line_width = 0.65;
            grid_color = 'k';
        elseif strcmpi(planet,'Uranus')
            grid_line_width = 0.5;
            grid_color = 'k';
        elseif strcmpi(planet,'Neptune')
            grid_line_width = 0.5;
            grid_color = 'w';
        elseif strcmpi(planet,'Pluto')
            grid_line_width = 0.65;
            grid_color = 'g';
        end
        
        % manually adds grid
        hold on;
        for i = 1:11
            plot([-180+i*30,-180+i*30],[-90,90],'color',grid_color,...
                'linewidth',grid_line_width,'linestyle',':');
        end
        for i = 1:5
            plot([-180,180],[-90+i*30,-90+i*30],'color',grid_color,...
                'linewidth',grid_line_width,'linestyle',':');
        end
    
    end
    
    % ----------------------------------------
    % Plotting ground track / axis formatting.
    % ----------------------------------------
    
    % determines indices where ground track crosses figure border (i.e.
    % from 180 to -180 or -180 to 180) to avoid "jumps" in the plot
    j = [];
    for i = 2:length(lon)
        if ((lon(i) > 170) && (lon(i-1) < -170)) || ((lon(i) < -170) &&...
                (lon(i-1) > 170))
            j = [j,i];
        end
    end
    
    % adds last index to "j" in order to plot ground track between last
    % figure border crossing and the last input longitude
    j = [j,length(lon)];
    
    % plots groundtrack (starts new plot every time ground track crosses
    % left border or right border)
    hold on;
    plot(lon(1:(j(1)-1)),lat(1:(j(1)-1)),'color',color,'linestyle',...
        line_style,'linewidth',line_width);
    for i = 1:(length(j)-1)
        plot(lon(j(i):(j(i+1)-1)),lat(j(i):(j(i+1)-1)),'color',color,...
           'linestyle',line_style,'linewidth',line_width,...
           'handlevisibility','off');
    end

    % axis formatting
    axis equal
    grid on
    if strcmpi(planet,'Earth Coastlines') || strcmpi(planet,...
            'Blank')
        ax = gca;
        ax.GridColor = [0.35,0.35,0.35];
        ax.GridAlpha = 1;
        ax.GridLineStyle = ':';
    end
    xlim([-180,180]);
    xticks(-180:30:180);
    ylim([-90,90]);
    yticks(-90:30:90);
    xlabel('Longitude, $\lambda\;[^{\circ}]$','interpreter','latex',...
        'fontsize',18);
    ylabel('Latitude, $\phi\;[^{\circ}]$','interpreter','latex',...
        'fontsize',18);
    
end