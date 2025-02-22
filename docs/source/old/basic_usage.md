# Using PowerSAS.m: The Basics

### 1 Initialization before use
To initialize PowerSAS.m, add the main directory of PowerSAS to Matlab or GNU Octave path, and execute command `initpowersas`. This will ensure all the functions of PowerSAS be added to the path and thus callable.

### 2 Call high-level API -- `runPowerSAS`
Most grid analysis functionalities can be invoked through the high-level function `runPowerSAS`. `runPowerSAS` is defined as follows:
```Matlab
function res=runPowerSAS(simType,data,options,varargin)
``` 
##### Input arguments
* `simType` is a string specifying the type of analysis, which can be one of the following values:
    * `'pf'`: Conventional power flow or extended power flow (for finding steady state of dynamic model).
    * `'cpf'`: Continuation power flow.
    * `'ctg'`: Contingency analysis (line outages).
    * `'n-1'`: N-1 line outage screening.
    * `'tsa'`: Transient stability analysis.
    * `'dyn'`: General dynamic simulation.
* `data` is the system data to be analyzed. It can be either a string specifying the data file name, or a `SysData` struct. For more information about data format and `SysData` struct, please refer to the "Data format and models" chapter.
* `options` specifies the options for analysis. If you do not provide `options` argument, or if you simply set the field to empty with `[]`, the corresponding routines will provide default options that will fit most cases. See Advanced Use chapter for more details.
* `varargin` are the additional input variables depending on the type of analysis. Section 3 Basic analysis funtionalifies will explain more details.

##### Output
Output `res` is a struct containing simulation result, system states, system data, etc.
* `res.flag`: Flag information returned by the analysis task.
* `res.msg`: More information as supplemental to the flag information.
* `res.caseName`: The name of the analyzed case.
* `res.timestamp`: A string showing the timestamp the analysis started, can be viewed as an unique identifier of the analysis task.
* `res.stateCurve`: A matrix storing the evolution of system states, where the number of rows equals the number of state variables, and the number of columns equals the number of time points.
* `res.t`: A vector storing time points corresponding to states in `res.stateCurve`.
* `res.simSettings`: A struct specifying the simulation settings, including simulation parametersand defined events.
* `res.eventList`: A matrix showing as the list of events in the system in the analysis task.
* `res.SysDataBase`: A struct of system data at base state.
* `res.snapshot`: The snapshot of the system states at the end of anlaysis, which can be used to initilize other analysis tasks.

To access the system states, we need to further access each kind of state variable in `res.stateCurve`. For example, the commands to extract the voltage from `res.stateCurve` are shown below:
```Matlab
[~,idxs]=getIndexDyn(res.SysDataBase); % Get the indexes of each kind of state variables
vCurve=res.StateCurve(idxs.vIdx,:); % idxs.vIdx is the row indexes of voltage variables
```

### 3 Basic analysis functionalities
#### 3.1 Power flow analysis
When `simType='pf'`, the `runPowerSAS` function runs power flow analysis. In addition to the conventional power flow model, `runPowerSAS` also integrates an extended power flow to solve the steady state of dynamic models. For example, it will calculate the rotor angles of synchronous generators and slips of induction motors in addition to the network equations.

To perform power flow analysis, call the `runPowerSAS` function as follows:
```Matlab
res=runPowerSAS('pf',data,options)
```
where the argument `data` can either be a string of file name or a `SysData` struct.  

Below are some examples:

```Matlab
% Use file name string to specify data
res1=runPowerSAS('pf','d:/codes/d_003.m'); % Filename can use absolute path
res2=runPowerSAS('pf','d_003.m'); % If data file is already in the Matlab/Octave path,
                                  % then can directly use file name
res3=runPowerSAS('pf','d_003'); % Filename can be without '.m'
res4=runPowerSAS('pf','d_003',setOptions('dataPath','d:/codes'); % Another way to specify data path

% Use SysData struct to specify data
SysData=readDataFile('d_003.m','d:/codes'); % Generate SysData struct from data file
res5=runPowerSAS('pf',SysData); % Run power flow using SysData struct
```

#### 3.2 Continuation Power Flow
Continuation power flow (CPF) analysis in PowerSAS.m features enhanced efficiency and convergence. To perform continuation power flow analysis, call `runPowerSAS` function as follows:
```Matlab
res=runPowerSAS('cpf',data,options,varargin)
```
where `options` (optional) specifies the options of CPF analysis, and `varargin` are the input arguments:
* `varargin{1}` (optional) is the ramping direction of load, which is an $\text{N}\times \text{12}$ matrix, the first column is the index of the bus, and the columns 5-10 are the ZIP load increase directions.
* `varargin{2}` (optional) is the ramping direction of generation power, which is an $\text{N}\times \text{2}$ matrix, the first column is the index of the bus, and the 2nd column is the generation increase directions.
* `varargin{3}` (optional) is the snapshot of the starting state, with which the computation of starting steady state is skipped.

Some examples can be found in `example/ex_cpf.m`.

#### 3.3 Contingency Analysis
Contingency analysis computes the system states immediately after removing a line/lines. To perform contingency analysis, call `runPowerSAS` as follows:
```Matlab
res=runPowerSAS('ctg',data,options,varargin)
```
where `options` (optional) specifies the options of contingency analysis. When not using customized options, set `options=[]`. And `varargin` are the input arguments:
* `varargin{1}` (mandatory) is a vector specifying the indexes of lines to be removed simultaneously.
* `varargin{2}` (optional) is the snapshot of the starting state. With this option, computing the starting steady state is skipped.

Some examples can be found in `example/ex_ctg.m`.

#### 3.4 N-1 screening
N-1 screening is essentially performing a series of contingency analysis, each removing a line from the base state. To perform N-1 screening, call `runPowerSAS` as follows:
```Matlab
res=runPowerSAS('n-1',data,options)
```

The return value `res` is a cell containing each contingency analysis results.

Some examples can be found in `example/ex_n_minus_1.m`.

#### 3.5 Transient Stability Analysis
Transient stability anslysis (TSA) assesses the system dynamic behavior and stability after given disturbance(s). 3-phase balanced fault(s) are the most common disturbances in the TSA. In PowerSAS, the TSA supports the analysis of the combinations of multiple faults. To perform transient Stability Analysis, call `runPowerSAS` in the following way:
```Matlab
res=runPowerSAS('tsa',data,options,varargin)
```
where `options` (optional) specifies the options of TSA. When not using customized options, set `options=[]`. And `varargin` are the input arguments:
* `varargin{1}` (mandatory) is a $\text{N}\times \text{6}$ matrix specifying the faults:
    * The 1st column is the index of line where the fault happens. 
    * The 2nd column is the relative position of the fault, 0.0 stands for the starting terminal and 1.0 stands for the ending terminal. For example, 0.5 means the fault happens in the middle point of the line.
    * The 3rd and 4th columns are the resistance and reactance of the fault.
    * The 5th and 6th columns specify the fault occurrence and clearing times.
* `varargin{2}` (optional) is the snapshot of the starting state, with which the computation of starting steady state is skipped.

By default, the TSA is run for 10 seconds. To change the simulation length, specify in the `options` argument, e.g. `options=setOptions('simlen',30)`.

Example can be found in `example/ex_tsa.m`.

### 4. Plot dynamic analysis results
PowerSAS provides an integrated and formatted way of plotting the system behavior in the time domain. The function for plotting curves is `plotCurves`. The function is defined as follows:
```Matlab
function plotCurves(figId,t,stateCurve,SysDataBase,variable,...
                    subIdx,lw,dot,fontSize,width,height,sizeRatio)
```
The argument list is explained as follows:
* `figId`: A positive integer or `[]` specifying the index of figure.
* `t`: A vector of time instants. If got `res` from `runPowreSAS` function, then input this argument as `res.t`.
* `stateCurve`: A matrix of system states in time domain, the number of columns should equal to the length of `t`. If got `res` from `runPowreSAS` function, then input this argument as `res.stateCurve`.
* `SysDataBase`: A SysData struct specifying the base system. If got `res` from `runPowreSAS` function, then input this argument as `res.SysDataBase`.
* `variable`: A string of variable name to be plotted. Here is a nonexhaustive list:
    * `'v'`: voltage magnitude (pu);
    * `'a'`: voltage angle (rad);
    * `'delta'`: rotor angle of synchronous generators;
    * `'omega'`: deviation of synchronous generator rotor speed;
    * `'s'`: induction motor slips;
    * `'f'`: frequency;
* `subIdx`: Allows you to pick a portion of the variables to plot e.g., the voltage of some selected buses. Default value is `[]`, which means that all the selected type of variables are plotted.
* `lw`: Line width. Default value is 1.
* `dot`: Allows you to choose whether to show data points. 1 means curves mark data dots, and 0 means no data dots are shown on curves. The default value is 0.
* `fontSize`: Font size of labels. Default value is 12.
* `width`: Width of figure window in pixels.
* `height`: Height of figure window in pixels.
* `sizeRatio`: If `width` or `height` is not specified, the size of the figure is determined by the `sizeRatio` of the screen size. The default value of `sizeRatio` is 0.7.
