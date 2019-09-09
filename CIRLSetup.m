clear;
clc;

% folder containing the experimental .mat data
CIRLDataPath = "C:\Users\saba\OneDrive - The University of Memphis\BasicSIMData";

% folder containing the source code
CIRLSrcPath  = "C:\Users\cvan\OneDrive - The University of Memphis\BasicSIM";

% folder containing the generated reports, default to
% "CIRLSrcPath\GeneratedReport"
CIRLReportPath = CIRLSrcPath + "\GeneratedReport";

% load all scripts in the src path
addpath(genpath(CIRLSrcPath));