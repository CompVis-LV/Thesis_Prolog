# Thesis - Prolog
Meta-Interpretive Learning from 3D (RGBD) data - Prolog aspects of current Honours thesis

The aim of this project is to use RGBD images of regular 3D shapes as examples in a meta-interpretive learning process to generate 3D object descriptions.

Pre-Processing in Python generates logical representations of the 3D shapes. This description includes:

- A list of the shapes faces
- What faces share an edge (joining faces)
- The angle between joining faces
- How many sides each face has

The current code "cube.pl" uses 6 examples shapes, 2 positive and 4 negative to learn a definition of a cube.

The 6 shapes are shown in the drawings below, there are represented in the code in the same format (2x3).

![6 3D shapes used as background knowledge for Cube3.pl](https://github.com/CompVis-LV/Thesis_Prolog/tree/master/shapes.png)