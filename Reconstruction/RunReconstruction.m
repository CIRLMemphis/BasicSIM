function RunReconstruction(varargin)
% get timestamp and make folder to store the report and pictures
tNow = datestr(datetime(),'yyyymmddHHMM');
        
NArg = length(varargin);
if (mod(NArg, 2) ~= 0)
    disp("The number of arguments to RunSimulation should be even!");
else
    % set default parameters
    reportFolder = "";
    reportFile   = "";
    dataFile     = "";
    savemat      = 0;
    reconArg2    = [];
    obScale      = 1;
    offs         = [];
    
    % set the input parameters
    for i = 1:2:NArg
        switch varargin{i}
            case 'savemat'
                savemat = varargin{i+1};
            case 'obScale'
                obScale = varargin{i+1};
            case 'reportFolder'
                reportFolder = varargin{i+1};
            case 'reportFile'
                reportFile = varargin{i+1};
            case 'Ob'
                ob = varargin{i+1};
            case 'u'
                u = varargin{i+1};
            case 'uc'
                uc = varargin{i+1};
            case 'X'
                X  = varargin{i+1};
            case 'Y'
                Y  = varargin{i+1};
            case 'Z'
                Z  = varargin{i+1};
            case 'Nphi'
                Nphi = varargin{i+1};
            case 'Nthe'
                Nthe = varargin{i+1};
            case 'offsets'
                offs = varargin{i+1};
            case 'phi'
                phi = varargin{i+1};
            case 'theta'
                theta = varargin{i+1};
            case 'w'
                w = varargin{i+1};
            case 'dXY'
                dXY = varargin{i+1};
            case 'dZ'
                dZ = varargin{i+1};
            case 'psfParam'
                psfParam = varargin{i+1};
            case 'dataFile'
                dataFile = varargin{i+1};
            case 'forwardModel'
                forwardFct = varargin{i+1};
            case 'forwardArgs'
                forwardArg = varargin{i+1};
            case 'obModel'
                obFct = varargin{i+1};
            case 'obArgs'
                obArg = varargin{i+1};
            case 'psfFunction'
                psfFct = varargin{i+1};
            case 'psfArgs'
                psfArg = varargin{i+1};
            case 'patternFunction'
                patternFct = varargin{i+1};
            case 'patternArgs'
                patternArg = varargin{i+1};
            case 'reconFunction'
                reconFct = varargin{i+1};
            case 'reconArgs'
                reconArg = varargin{i+1};
            case 'reconFunction2'
                reconFct2 = varargin{i+1};
            case 'reconArgs2'
                reconArg2 = varargin{i+1};
            case 'reconVars'
                reconVars = varargin{i+1};
            case 'reconVals'
                reconVals = varargin{i+1};
            otherwise
        end
    end
    
    if (isempty(offs))
        offs = zeros(Nthe, 1);
        warning("using the default zero offsets of phi!");
    end
   
    for i = 1:length(reconVars)
        eval(reconVars{i} + " = " + reconVals{i} + ";");
    end
    
    psfArgCell = cell(length(psfArg),1);
    for i = 1:length(psfArg)
        psfArgCell{i} = eval(psfArg{i});
    end
    h = psfFct(psfArgCell{:}); clear psfArgCell;
    
    patternArgCell = cell(length(patternArg),1);
    for i = 1:length(patternArg)
        if (isstring(patternArg{i}))
            patternArgCell{i} = eval(patternArg{i});
        else
            patternArgCell{i} = patternArg{i};
        end
    end
    [im, jm, Nm] = patternFct(patternArgCell{:}); clear patternArgCell;
       
    if (dataFile ~= "") 
        load(dataFile, 'g');
    else
        obArgCell = cell(length(obArg),1);
        for i = 1:length(obArg)
            if (isstring(obArg{i}))
                obArgCell{i} = eval(obArg{i});
            else
                obArgCell{i} = obArg{i};
            end
        end
        ob = obScale*obFct(obArgCell{:});  clear obArgCell;

        forwardArgCell = cell(length(forwardArg),1);
        for i = 1:length(forwardArg)
            forwardArgCell{i} = eval(forwardArg{i});
        end
        g = forwardFct(forwardArgCell{:});  clear forwardArgCell;
    end
    [Yg, Xg, Zg, ~, ~] = size(g);
    
    reconArgCell = cell(length(reconArg),1);
    for i = 1:length(reconArg)
        if (isstring(reconArg{i}))
            reconArgCell{i} = eval(reconArg{i});
        else
            reconArgCell{i} = reconArg{i};
        end
    end
    [reconOb, retFigs, retVars] = reconFct(reconArgCell{:}); clear reconArgCell;
    [reX, reY, reZ] = size(reconOb);
    
    if (~isempty(reconArg2))
        reconArg2Cell = cell(length(reconArg2),1);
        for i = 1:length(reconArg2)
            if (isstring(reconArg2{i}))
                reconArg2Cell{i} = eval(reconArg2{i});
            else
                reconArg2Cell{i} = reconArg2{i};
            end
        end
        [reconOb2, retFigs2] = reconFct2(reconArg2Cell{:}); clear reconArg2Cell;
    end
    
    %% generate pictures
    if (dataFile == "") 
        % original object
        ObFigFile = "OrigObject";
        ObFig = figure('Position', get(0, 'Screensize'));
        subplot(1,2,1);imagesc(squeeze(real(ob(round(1+Y/2),:,:)))'); axis image; xlabel('x'); ylabel('z'); colorbar; set(gca,'FontSize',20)
        subplot(1,2,2);imagesc(squeeze(real(ob(:,:,floor(1+Z/2))))); axis image; xlabel('x'); ylabel('y'); colorbar; set(gca,'FontSize',20)
        %suptitle("xy, yz view of original object at z = " + num2str(floor(1+Z/2)) + ", x = " + num2str(1+X/2));
        
        % original vs reconstructed along x and z axis
        xObvsReconFigFile = "xObvsRecon";
        xObvsReconFig = figure('Position', get(0, 'Screensize')); 
                 plot(ob(1+Y/2, :, floor(1+Z/2)), 'DisplayName', 'orig'); 
        hold on; plot(real(reconOb(1+reY/2, :, floor(1+reY/2))), 'DisplayName', 'recon 1');
        if (~isempty(reconArg2))
            hold on; plot(real(reconOb2(1+reY/2, :, floor(1+reY/2))), 'DisplayName', 'recon 2');
        end
        xlabel('x'); ylabel('value'); set(gca,'FontSize',20); legend;
        
        zObvsReconFigFile = "zObvsRecon";
        zObvsReconFig = figure('Position', get(0, 'Screensize')); 
                 plot(squeeze(ob(1+Y/2, 1+Y/2, :)), 'DisplayName', 'orig'); 
        hold on; plot(squeeze(real(reconOb(1+reY/2, 1+reY/2, :))), 'DisplayName', 'recon 1');
        if (~isempty(reconArg2))
            hold on; plot(squeeze(real(reconOb2(1+reY/2, 1+reY/2, :))), 'DisplayName', 'recon 2');
        end
        xlabel('z'); ylabel('value'); set(gca,'FontSize',20); legend;
    else
        % plot the reconstruction along x and z axis
        xReconFigFile = "xRecon";
        xReconFig = figure('Position', get(0, 'Screensize')); 
        plot(real(reconOb(1+reY/2, :, floor(1+reZ/2))));
        xlabel('x'); ylabel('value'); set(gca,'FontSize',20)
        
        zReconFigFile = "zRecon";
        zReconFig = figure('Position', get(0, 'Screensize')); 
        plot(squeeze(real(reconOb(1+reY/2, 1+reY/2, :))));
        xlabel('z'); ylabel('value'); set(gca,'FontSize',20)
    end
    
    % simulated collected data
    DataFigFile = "SimulatedData";
    if (length(size(g)) == 5)
        DataFig = cell(Nphi,1);
        for k = 1 : Nphi
            DataFig{k} = figure('Position', get(0, 'Screensize'));
            ct = 0;
            for j = 1 : Nthe
                ct = ct + 1;
                subplot(Nthe,2,ct); imagesc(squeeze(g(round(1+Yg/2),:,:,j,k))'); xlabel('x'); ylabel('z'); axis image; colorbar; set(gca,'FontSize',20)
                ct = ct + 1;
                subplot(Nthe,2,ct); imagesc(squeeze(g(:,:,floor(1+Zg/2),j,k))); xlabel('x'); ylabel('y'); axis image; colorbar; set(gca,'FontSize',20)
            end
            %suptitle("Collected data at phi = " + num2str(phi(k)));
        end
    else
        DataFig = {};
    end
    
%     DataYFigFile = "DataYFig";
%     DataYFig     = figure('Position', get(0, 'Screensize'));
%              plot(squeeze(g(:, 1+Xg/2, floor(1+Zg/2),1,1)));
%     hold on; plot(squeeze(g(:, 1+Xg/2, floor(1+Zg/2),1,2)));
%     hold on; plot(squeeze(g(:, 1+Xg/2, floor(1+Zg/2),1,3)));
%     legend('phase 0', 'phase 1', 'phase 2'); xlabel('y'); ylabel('value'); set(gca,'FontSize',20)
%     
%     DataXFigFile = "DataXFig";
%     DataXFig     = figure('Position', get(0, 'Screensize'));
%              plot(squeeze(g(1+Yg/2, :, floor(1+Zg/2),1,1)));
%     hold on; plot(squeeze(g(1+Yg/2, :, floor(1+Zg/2),1,2)));
%     hold on; plot(squeeze(g(1+Yg/2, :, floor(1+Zg/2),1,3)));
%     legend('phase 0', 'phase 1', 'phase 2'); xlabel('x'); ylabel('value'); set(gca,'FontSize',20)
    
    % reconstructed object
    ReconFigFile = "ReconObject";
    ReconFig     = figure('Position', get(0, 'Screensize'));
    subplot(1,2,1);imagesc(squeeze(real(reconOb(round(1+reY/2),:,:)))'); axis image; xlabel('x'); ylabel('z'); colorbar; set(gca,'FontSize',20);
    subplot(1,2,2);imagesc(squeeze(real(reconOb(:,:,floor(1+reZ/2))))); axis image; xlabel('x'); ylabel('y'); colorbar; set(gca,'FontSize',20);
     
    % write the simulation results into a report file
    if (reportFolder ~= "" && reportFile ~= "")       
        % create folder to store report and pictures
        timeFolder = reportFolder + "/" + tNow;
        mkdir(timeFolder);
                
        if (dataFile == "") 
            saveas(ObFig,         timeFolder + "/" + ObFigFile         + ".jpg");
            saveas(xObvsReconFig, timeFolder + "/" + xObvsReconFigFile + ".jpg");
            saveas(zObvsReconFig, timeFolder + "/" + zObvsReconFigFile + ".jpg");
        end
        saveas(ReconFig, timeFolder + "/" + ReconFigFile + ".jpg");
        for k = 1 : length(DataFig)
            saveas(DataFig{k}, timeFolder + "/" + DataFigFile + int2str(k) + ".jpg");
        end
        for k = 1 : length(retFigs)
            saveas(retFigs(k), timeFolder + "/MidFig" + int2str(k) + ".jpg");
        end
        
        % report header
        outReport = fileread(reportFolder + "/ReportHeaderTemplate.tex");
        outReport = strrep(outReport, "\date{}", "\date{" + datestr(datetime(),'mm-dd-yyyy HH:MM') + "}");
        outReport = strrep(outReport, "\", "\\");
        outReport = strrep(outReport, "%", "%%");

        % content of the report goes here
        outReport = outReport + "\\frame[shrink=20]{ \\frametitle{Simulation setup}\n";
        outReport = outReport + "PSF type: " + strrep(func2str(psfFct), "_", "\\_") + "\n";
        outReport = outReport + "\\begin{multicols}{2}\n";
        outReport = outReport + "$distToCoverslip = "   + num2str(psfParam.d(3))   + "\\,\\mu m$\\\\ \n";
        outReport = outReport + "$ni = "                + num2str(psfParam.n(1))   + "$\\\\ \n";
        outReport = outReport + "$ng = "                + num2str(psfParam.n(2))   + "$\\\\ \n";
        outReport = outReport + "$tg = "                + num2str(psfParam.d(2))   + "\\,\\mu m$\\\\ \n";
        outReport = outReport + "$ns = "                + num2str(psfParam.n(3))   + "$\\\\ \n";
        outReport = outReport + "$NA = "                + num2str(psfParam.NA)     + "$\\\\ \n";
        outReport = outReport + "$tiD = "               + num2str(psfParam.dD(1))  + "$\\\\ \n";
        outReport = outReport + "$niD = "               + num2str(psfParam.nD(1))  + "$\\\\ \n";
        outReport = outReport + "$ngD = "               + num2str(psfParam.nD(2))  + "$\\\\ \n";
        outReport = outReport + "$tgD = "               + num2str(psfParam.dD(2))  + "\\,\\mu m$\\\\ \n";
        outReport = outReport + "$ts = "                + num2str(psfParam.d(3))   + "\\,\\mu m$\\\\ \n";
        outReport = outReport + "$lambda = "            + num2str(psfParam.v(1))   + "\\,\\mu m$\n";
        outReport = outReport + "\\end{multicols} \n";
        outReport = outReport + "\\begin{multicols}{2}\n";
        outReport = outReport + "$ X = "        + num2str(X)                         +...
                                ", Y = "        + num2str(Y)                         +...
                                ", Z = "        + num2str(Z)                         +  "$\\\\ \n";
        outReport = outReport + "$N_\\phi = "   + num2str(Nphi)                      +  "$\\\\ \n";
        outReport = outReport + "$N_\\theta = " + num2str(Nthe)                      +  "$\\\\ \n";
        phiFormat = "";
        for kPhi = 1:Nphi
            if (kPhi < Nphi)
                phiFormat = phiFormat + "%.1f,";
            else
                phiFormat = phiFormat + "%.1f";
            end
        end
        theFormat = "";
        for lThe = 1:Nthe
            if (lThe < Nthe)
                theFormat = theFormat + "%.1f,";
            else
                theFormat = theFormat + "%.1f";
            end
        end
        outReport = outReport + "$u_c =  "      + num2str(uc)                        +  "$ cycle/$\\mu m$\\\\ \n";
        outReport = outReport + "$u_m = ("      + num2str(u/uc,  theFormat)          +  ")u_c$\\\\ \n";
        outReport = outReport + "$w_m = ("      + num2str(w,     theFormat)          +  ")$\\\\ \n";
        outReport = outReport + "$\\varphi = (" + num2str(phi,   phiFormat) + ")^{\\circ}$\\\\ \n";
        outReport = outReport + "$\\theta = ("  + num2str(theta, theFormat) + ")^{\\circ}$\\\\ \n";
        outReport = outReport + "$dXY = "       + num2str(dXY)                       +  "\\,\\mu m$\\\\ \n";
        outReport = outReport + "$dZ = "        + num2str(dZ)                        +  "\\,\\mu m$\\\\ \n";
        outReport = outReport + "\\end{multicols} \n";
        outReport = outReport + "Reconstruction method: " + strrep(func2str(reconFct), "_", "\\_") + "\n";
        if (~isempty(reconVars))
            outReport = outReport + "\\begin{multicols}{2}\n";
            for i = 1:length(reconVars)
                outReport = outReport + "$" + reconVars{i} + " = " + num2str(reconVals{i}, "%f") +  "$\\\\ \n";
            end
            outReport = outReport + "\\end{multicols} \n";
        end
        outReport = outReport + "} \n";
        
        if (dataFile == "") 
            outReport = outReport + "\\frame{ \\frametitle{Original object}\n";
            outReport = outReport + "\\begin{figure}[h!]\n";
            outReport = outReport + "  \\includegraphics[width=\\linewidth]{" + ObFigFile + "}\n";
            outReport = outReport + "\\end{figure}\n";
            outReport = outReport + "}\n";
        end
        
        for k = 1 : Nphi
            outReport = outReport + "\\frame{ \\frametitle{Simulated collected data at $\\varphi = " + phi(k) + "$}\n";
            outReport = outReport + "\\begin{figure}[h!]\n";
            outReport = outReport + "  \\includegraphics[width=\\linewidth]{" + DataFigFile + int2str(k) + "}\n";
            outReport = outReport + "\\end{figure}\n";
            outReport = outReport + "}\n";
        end
        
        for k = 1 : length(retFigs)
            outReport = outReport + "\\frame{ \\frametitle{Middle data}\n";
            outReport = outReport + "\\begin{figure}[h!]\n";
            outReport = outReport + "  \\includegraphics[width=\\linewidth]{MidFig" + int2str(k) + "}\n";
            outReport = outReport + "\\end{figure}\n";
            outReport = outReport + "}\n";
        end
        
        outReport = outReport + "\\frame{ \\frametitle{Reconstructed object}\n";
        outReport = outReport + "\\begin{figure}[h!]\n";
        outReport = outReport + "  \\includegraphics[width=\\linewidth]{" + ReconFigFile + "}\n";
        outReport = outReport + "\\end{figure}\n";
        outReport = outReport + "}\n";
        
        if (dataFile == "") 
            outReport = outReport + "\\frame{ \\frametitle{Original vs Reconstructed object, x axis}\n";
            outReport = outReport + "\\begin{figure}[h!]\n";
            outReport = outReport + "  \\includegraphics[width=\\linewidth]{" + xObvsReconFigFile + "}\n";
            outReport = outReport + "\\end{figure}\n";
            outReport = outReport + "}\n";
            
            outReport = outReport + "\\frame{ \\frametitle{Original vs Reconstructed object, z axis}\n";
            outReport = outReport + "\\begin{figure}[h!]\n";
            outReport = outReport + "  \\includegraphics[width=\\linewidth]{" + zObvsReconFigFile + "}\n";
            outReport = outReport + "\\end{figure}\n";
            outReport = outReport + "}\n";
        end

        % report footer and write to file
        outReport = outReport + strrep(fileread(reportFolder + "/ReportFooterTemplate.tex"), "\", "\\");
        fid       = fopen(timeFolder + "/" + reportFile, 'wt');
        fprintf(fid, outReport);
        fclose(fid);
        
        % save variables, no figures
        if (savemat == 1)
            % clear unnecessary variables, pics
            clear DataFig;
            
            % Get a list of all variables
            allvars = whos;
            
            % Identify the variables that ARE NOT graphics handles. This uses a regular
            % expression on the class of each variable to check if it's a graphics object
            tosave = cellfun(@isempty, regexp({allvars.class}, '^matlab\.(ui|graphics)\.'));
            
            % Pass these variable names to save
            save(timeFolder + "/" + tNow + ".mat", allvars(tosave).name, '-v7.3')
        end
        
    end
end
end