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
% Last Update: 2022-07-06
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% IMAGE SOURCES:
% https://tamaskis.github.io/files/Ground_Track_Image_Sources.pdf
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   lat     - (1D double array) planetodetic latitude [deg]
%   lon     - (1D double array) planetodetic longitude [deg]
%   opts    - (OPTIONAL) (1×1 struct) plot options
%       • Color     - (char or 1×3 double) line color
%                       --> can be specified as a name, short name, or RGB 
%                           triplet [rgb]
%       • LineWidth - (1×1 double) line width
%       • LineStyle - (char) line style
%   planet  - (OPTIONAL) (char) 'Blank', 'Sun', 'Moon', 'Mercury', 'Venus',
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
    if (nargin < 3) || isempty(opts) || ~isfield(opts,'Color')
        Color = [0,0.4470,0.7410];
    else
        Color = opts.Color;
    end
    
    % sets line style (defaults to solid line)
    if (nargin < 3) || isempty(opts) || ~isfield(opts,'LineStyle')
        LineStyle = '-';
    else
        LineStyle = opts.LineStyle;
    end
    
    % sets line width (defaults to 1.5)
    if (nargin < 3) || isempty(opts) || ~isfield(opts,'LineWidth')
        LineWidth = 1.5;
    else
        LineWidth = opts.LineWidth;
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
            cdata = imread('earth.png')+imread('clouds.png');
        elseif strcmpi(planet,'Earth Night')
            cdata = imread('earthnight.png');
        elseif strcmpi(planet,'Earth Night Cloudy')
            cdata = imread('earthnight.png')+0.1*...
                imread('clouds.png');
        else
            cdata = imread(strcat(lower(planet),'.png'));
        end
        
        % plots background
        image('CData',flipud(cdata),'XData',[-180,180],'YData',[-90,90]);
        
        % determines grid style based on background
        if strcmpi(planet,'Sun')
            GridLineWidth = 1;
            GridColor = 'k';
        elseif strcmpi(planet,'Moon')
            GridLineWidth = 0.75;
            GridColor = 'y';
        elseif strcmpi(planet,'Mercury')
            GridLineWidth = 0.75;
            GridColor = 'y';
        elseif strcmpi(planet,'Venus')
            GridLineWidth = 0.5;
            GridColor = 'k';
        elseif strcmpi(planet,'Earth')
            GridLineWidth = 0.5;
            GridColor = 'y';
        elseif strcmpi(planet,'Earth Cloudy')
            GridLineWidth = 1.5;
            GridColor = 'y';
        elseif strcmpi(planet,'Earth Night')
            GridLineWidth = 0.5;
            GridColor = [0.5,0.5,0.5];
        elseif strcmpi(planet,'Earth Night Cloudy')
            GridLineWidth = 0.5;
            GridColor = [0.5,0.5,0.5];
        elseif strcmpi(planet,'Mars')
            GridLineWidth = 0.75;
            GridColor = 'y';
        elseif strcmpi(planet,'Jupiter')
            GridLineWidth = 1;
            GridColor = 'k';
        elseif strcmpi(planet,'Saturn')
            GridLineWidth = 0.65;
            GridColor = 'k';
        elseif strcmpi(planet,'Uranus')
            GridLineWidth = 0.5;
            GridColor = 'k';
        elseif strcmpi(planet,'Neptune')
            GridLineWidth = 0.5;
            GridColor = 'w';
        elseif strcmpi(planet,'Pluto')
            GridLineWidth = 0.65;
            GridColor = 'g';
        end
        
        % manually adds grid
        hold on;
        for i = 1:11
            plot([-180+i*30,-180+i*30],[-90,90],'Color',GridColor,...
                'LineWidth',GridLineWidth,'LineStyle',':');
        end
        for i = 1:5
            plot([-180,180],[-90+i*30,-90+i*30],'color',GridColor,...
                'LineWidth',GridLineWidth,'LineStyle',':');
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
    plot(lon(1:(j(1)-1)),lat(1:(j(1)-1)),'Color',Color,'LineStyle',...
        LineStyle,'LineWidth',LineWidth);
    for i = 1:(length(j)-1)
        plot(lon(j(i):(j(i+1)-1)),lat(j(i):(j(i+1)-1)),'Color',Color,...
           'LineStyle',LineStyle,'LineWidth',LineWidth,...
           'HandleVisibility','off');
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
    xlabel('Longitude, $\lambda\;[^{\circ}]$','Interpreter','latex',...
        'FontSize',18);
    ylabel('Latitude, $\phi\;[^{\circ}]$','Interpreter','latex',...
        'FontSize',18);
    
end