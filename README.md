# BasicSIM: the basic and easy-to-understand implementation of 3D-SIM algorithms: GWF, MB, MBPC

This repository is for new personals coming to CIRL and would like to learn about classical restoration methods in SIM. The following steps need to be taken to make use of this repository:
1. If one (affiliated with the University of Memphis) has not got MATLAB installed on his/her computer/laptop, one can download/install it for free from here:<br>
https://www.mathworks.com/academia/tah-portal/university-of-memphis-40714972.html
2. If one is not familiar with GitHub, one can download/install SourceTree and learn about SourceTree/GitHub from this site:<br>
https://www.bogotobogo.com/cplusplus/Git/Git_GitHub_Source_Tree_1_Commit_Push.php <br>
<b>Exercise</b>: cloning the BasicSIM repo using SourceTree, create your own branch and push a simple file into your branch.
3. BasicSIM has a configuration file "CIRLSetup.m", which one needs to configure the "source" (CIRLSrcPath) and "data" (CIRLDataPath) paths before one can use/run the codes:<br>
For example, if one clones the BasicSIM repo into the folder "C:\Users\cvan\OneDrive - The University of Memphis\BasicSIM" then the CIRLSrcPath in the CIRLSetup.m should be:<br>
CIRLSrcPath  = "C:\Users\cvan\OneDrive - The University of Memphis\BasicSIM";
4. To organize the codes, the repo has many separate folders:
    - "Analysis": contains the codes to analyze the results, for example, to compare the results of different methods.
    - "Doc": contains the documentation (like discussion slides, notes, etc.)
    - "Experiment": contains the restoration scripts for experimental data (like FairSIM data)
    - "Forward": contains the codes of the forward model
    - "GeneratedReport": some reconstruction codes automatically generate an analysis report, which will be stored in this folder.
    - "HPC": example of how to write HPC script to run MATLAB on HPC.
    - "ModulatingPattern": contains the code for generating the modulating patterns (for three-wave SIM or Tunable SIM microscopes).
    - "Objects": contains the codes to generate simulated objects for simulation purposes.
    - "PSF": contains the codes to generate the point-spread function (PSF) used in the simulation process.
    - "Reconstruction": contains the codes of classical restoration methods like GWF and MB/MBPC.
    - "Simulation": contains the restoration scripts for simulated data.
    - "Tutorials": contains the live-script tutorials to learn about how to simulate a SIM microscope, how to add noises to simulated data, and how to run the classical restoration methods.
    - "Util": contains the useful functions.
5. BasicSIM has a "Tutorials" folder, which contains MATLAB live scripts, to help one learn about how to simulate a SIM microscope, how to add noises to simulated data, and how to run the classical restoration methods: Generalized Wiener Filter (GWF), and Model-Based (with Positivity Constraint) methods (MB, MBPC).<br>
One can open MATLAB, go to the "Tutorials" folder, and open the first tutorial script "1.ForwardModelTut.mlx" to get started.
