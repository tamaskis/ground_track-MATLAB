# `ground_track` [![View Ground Track (ground_track) on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/89822-ground-track-ground_track)

Plots the ground track of an orbit given its planetodetic coordinates (i.e. planetodetic latitude and longitude).


## Syntax

`ground_track(lat,lon)`\
`ground_track(lat,lon,opts)`\
`ground_track(__,planet)`


## Description

`ground_track(lat,lon)` plots the ground track of an orbit around the Earth, superimposed on a map of the Earth, where the map just shows the coastlines. `lat` and `lon` are vectors of geodetic latitude and longitude values (in degrees). By default, the ground track is drawn in blue with a line width of 1.5.
            
`ground_track(lat,lon,opts)` does the same as the syntax above, but allows for the specification of optional plotting parameters. `opts` is a struct that has the following fields:
   - `color` &rightarrow; specifies line color
   - `line_width` &rightarrow; specifies line width
   - `line_style` &rightarrow; specifies line style

`ground_track(__,planet)` draws the ground track of an orbit around the celestial body specified by `planet`. `planet` can be specified as `'Blank'` (plots ground track over blank background), `'Sun'`, `'Moon'`, `'Mercury'`, `'Venus'`, `'Earth'`, `Earth Cloudy`, `'Earth Coastlines'`, `'Earth Night'`, `'Earth Night Cloudy'`, `'Earth Continents Outline'`, `'Mars'`, `'Jupiter'`, `'Saturn'`, `'Uranus'`, `'Neptune'`, or `'Pluto'`. Note that if you are specifying `planet`, but choosing not to specify the optional parameters (`opts`), use the syntax `ground_track(lat,lon,[],planet)`.


## Examples and Image Sources

   -  See "EXAMPLES.mlx" or the "Examples" tab on the File Exchange page for examples.
   -  See ["Ground_Track_Image_Sources.pdf"](https://tamaskis.github.io/documentation/Ground_Track_Image_Sources.pdf) (also included with download) for the image sources.
