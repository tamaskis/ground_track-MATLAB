%% Copyright (c) 2021 Tamas Kis

% Examples for using the ground_track function.



%% SCRIPT SETUP

% clears variables and command window, closes all figures
clear;
clc;
close all;

% plot parameters
line_width = 1.5; % line width [#]
cardinal_red = [140,21,21]/255; % color for plot [rgb]

% load sample orbit data
data = table2array(readtable('SAMPLE_ORBIT_DATA.xlsx'));
lat = data(:,1);
lon = data(:,2);



%% DEFAULT GROUND TRACK

% plots ground track using default options
figure('position',[300,300,1000,500]);
ground_track(lat,lon);



%% GROUND TRACKS USING OPTIONAL INPUTS

% initializes figure
figure('position',[300,300,1000,500]);

% plot of ground track (uncomment one at a time)
ground_track(lat,lon,'k',[],'Sun');
%ground_track(lat,lon,[140,21,21]/255,2.5,'Moon');
%ground_track(lat,lon,[140,21,21]/255,2,'Mercury');
%ground_track(lat,lon,[],[],'Venus');
%ground_track(lat,lon,[140,21,21]/255,2.5,'Earth');
%ground_track(lat,lon,'r',3,'Earth Cloudy');
%ground_track(lat,lon,[],[],'Earth Night');
%ground_track(lat,lon,[],[],'Earth Night Cloudy');
%ground_track(lat,lon,[],3,'Mars');
%ground_track(lat,lon,[],[],'Jupiter');
%ground_track(lat,lon,[],[],'Saturn');
%ground_track(lat,lon,[140,21,21]/255,[],'Uranus');
%ground_track(lat,lon,'c',[],'Neptune');
%ground_track(lat,lon,[],2.5,'Pluto');