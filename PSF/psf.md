This folder contains the codes for generating the Point-Spread Function (PSF).
1. The two main files are PSFAgard.m and PSFLutz.m (developed by others, not at CIRL). 
2. scalarpsf.m, vectorialpsf.m and wfpsf.m have their own documentation inside the files.
3. PSFLutz.m requires the last input to be a parameter file, constructed using psfparameter.m
4. PSFConfig.m, PSFConfigNoAber.m, PSFFairSIM.m are parameter files into PSFLutz, with some parameters specific for each scenarios.
