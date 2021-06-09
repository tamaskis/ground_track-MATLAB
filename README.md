# `ground_track` [![View Ground Track (ground_track) on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/89822-ground-track-ground_track)

Plots the ground track of an orbit given its planetodetic coordinates (i.e. planetodetic latitude and longitude).


## Syntax

`ground_track(lat,lon)`\
`ground_track(lat,lon,color)`\
`ground_track(lat,lon,[],line_width)`\
`ground_track(lat,lon,color,line_width)`\
`ground_track(lat,lon,__,planet)`


## Description

`ground_track(lat,lon)` plots the ground track of an orbit around the Earth, superimposed on a map of the Earth, where the map just shows the continental outlines. `lat` and `lon` are vectors of geodetic latitude and longitude values. By default, the ground track is drawn in blue with a line width of 1.5.
            
`ground_track(lat,lon,color)` does the same as the syntax above, but draws the ground track with the color specified by `color`. By default, a line width of 1.5 is used.

`ground_track(lat,lon,color,line_width)` does the same as the previous syntaxes, but draws the ground track with the line width specified by `line_width`. If you would only like to specify the line width, but not the color, use the syntax `ground_track(lat,lon,[],line_width)`.

`ground_track(__,planet)` draws the ground track of an orbit around the celestial body specified by `planet`. `planet` can be specified as `'Sun'`, `'Moon'`, `'Mercury'`, `'Venus'`, `'Earth'`, `'Earth Cloudy'`, `'Earth Night'`, `'Earth Night Cloudy'`, `'Earth Continents Outline'`, `'Mars'`, `'Jupiter'`, `'Saturn'`, `'Uranus'`, `'Neptune'`, or `'Pluto'`. Note that if you are specifying `planet`, but choosing not to specify some other parameters, you have to replace the variables you skipped over with "`[]`". For example, if you wanted to specify the color but not the line width, you would use `ground_track(lat,lon,color,[],planet)`.


## Examples and Additional Documentation

   -  See "EXAMPLES.mlx" or the "Examples" tab on the File Exchange page for examples.
   -  See "DOCUMENTATION.pdf" for additional documentation.
