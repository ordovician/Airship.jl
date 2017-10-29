# Airship
This is a collection of scripts which will hopefully turn into a package at some time for working with buoyancy, ideal gas law, temperature. The idea is to be able to easily make calculations relevant for airships of different volume and shape in atmospheres with different pressures, densities and temperatures.

The background for this is my interest in exploring the practical considerations for airship based habitats above the Venus cloud tops.

## Overview
This "package" is divided into 3 main parts:
    - Temparatures. Dealing with kelvin, celsius and fahrentheit.
    - Ideal gas law. Given certain pressure and temperatures what would the volume of the gas be?
    - Volumes. What are the volumes of different shapes. E.g. an airship usually has an ellipsoid shape.

## Learning About Defining Custom Units In Julia
This is also useful code to learn about defining your own physics units in Julia. Specifically I am defining different temperature units, so you can write code like this:

       temperature = 3°C + 4°C
       
