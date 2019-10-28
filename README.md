# Alignment-Toolkit-Matlab
Toolkit for Matlab that enables analysis of rigid body alignment. Uses Multi-parametric toolbox 3.0.
Compatible with Matlab R2016b and later.
Provides tools to find the 'Area of Acceptance' (full space of error tolerance) for rigid passive alignment faces definable as polyhedra.

Matlab and MPT 3.0 are subject to their respective licenses.

Some files will be inconsistent - refactoring is ongoing.

To install:
First install Multi-Parametric Toolbox 3.0:
https://www.mpt3.org/

then run addSourcePath.m

Test/example scripts are:
/scripts/pyrNDTester.m - Generates a 3D Area of Acceptance (in x, pitch, and roll) for two 3D Pyramid connectors (one concave, one convex), and gives numerical values of the metrics, as well as a plot of the accepted area. 
/scripts/vfaceTester.m - Generates a 2D Area of Acceptance (in x and theta) for two 2D 'V-Face' connectors. Plots opaque, transparent, and 2D projection representations of the Area of Acceptance.

Please be patient - each script takes a few minutes to run at the given resolutions.
