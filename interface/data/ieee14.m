function mpc = ieee14
%IEEE14
%   PSS(R)E 32 RAW created by rawd32  SUN, MAY 17 2020  20:38
%    IEEE 14 BUS TEST CASE
%    03/06/14 CONTO           100.0  1962 W
%
%   Converted by MATPOWER 7.1 using PSSE2MPC on 16-Mar-2023
%   from 'ieee14.raw' using PSS/E rev 32 format.
%
%   WARNINGS:
%       Skipped 2 lines of zone data.
%       Skipped 2 lines of owner data.
%       Using default voltage magnitude limits: VMIN = 0.9 p.u., VMAX = 1.1 p.u.
%
%   See CASEFORMAT for details on the MATPOWER case file format.

%% MATPOWER Case Format : Version 2
mpc.version = '2';

%%-----  Power Flow Data  -----%%
%% system MVA base
mpc.baseMVA = 100;

%% bus data
%	bus_i	type	Pd	Qd	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
mpc.bus = [
	1	3	0	0	0	0	1	1.03	0	69	1	1.1	0.9;
	2	2	21.7	12.7	0	0	1	1.0197	-1.6032	69	1	1.1	0.9;
	3	2	50	25	0	0	1	1.00042	-3.4433	69	1	1.1	0.9;
	4	1	47.8	10	0	0	1	0.99858	-4.2812	69	1	1.1	0.9;
	5	1	7.6	1.6	0	0	1	1.00443	-3.685	69	1	1.1	0.9;
	6	2	15	7.5	0	0	2	0.99871	-6.3024	138	2	1.1	0.9;
	7	1	0	0	0	0	2	1.00682	-4.8292	138	2	1.1	0.9;
	8	2	0	0	0	0	2	1.01895	-1.3945	69	2	1.1	0.9;
	9	1	29.5	16.6	0	19	2	1.00193	-7.3053	138	2	1.1	0.9;
	10	1	9	5.8	0	0	2	0.99351	-7.46	138	2	1.1	0.9;
	11	1	3.5	1.8	0	0	2	0.99245	-7.0444	138	2	1.1	0.9;
	12	1	6.1	1.6	0	0	2	0.98639	-7.3874	138	2	1.1	0.9;
	13	1	13.5	5.8	0	0	2	0.98403	-7.6654	138	2	1.1	0.9;
	14	1	20	7	0	15	2	0.99063	-9.5636	138	2	1.1	0.9;
];

%% generator data
%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
mpc.gen = [
	1	81.442	1.962	100	-50	1.03	100	1	200	50	0	0	0	0	0	0	0	0	0	0	0;
	2	40	15	15	-40	1.03	100	1	50	10	0	0	0	0	0	0	0	0	0	0	0;
	3	40	15	15	-10	1.01	100	1	50	10	0	0	0	0	0	0	0	0	0	0	0;
	6	30	10	10	-6	1.03	100	1	50	10	0	0	0	0	0	0	0	0	0	0	0;
	8	35	10	10	-6	1.03	100	1	50	10	0	0	0	0	0	0	0	0	0	0	0;
];

%% branch data
%	fbus	tbus	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
mpc.branch = [
	1	2	0.01938	0.05917	0.0528	100	100	0	0	0	1	-360	360;
	1	5	0.05403	0.22304	0.0492	100	100	0	0	0	1	-360	360;
	2	3	0.04699	0.19797	0.0438	100	100	0	0	0	1	-360	360;
	2	4	0.05811	0.17632	0.034	100	100	0	0	0	1	-360	360;
	2	5	0.05695	0.17388	0.0346	100	100	0	0	0	1	-360	360;
	3	4	0.06701	0.17103	0.0128	100	100	0	0	0	1	-360	360;
	4	5	0.01335	0.04211	0	100	100	0	0	0	1	-360	360;
	6	11	0.09498	0.1989	0	100	100	0	0	0	1	-360	360;
	6	12	0.12291	0.25581	0	100	100	0	0	0	1	-360	360;
	6	13	0.06615	0.13027	0	100	100	0	0	0	1	-360	360;
	7	9	-0	0.11001	0	100	100	0	0	0	1	-360	360;
	9	10	0.03181	0.0845	0	100	100	0	0	0	1	-360	360;
	9	14	0.12711	0.27038	0	100	100	0	0	0	1	-360	360;
	10	11	0.08205	0.19207	0	100	100	0	0	0	1	-360	360;
	12	13	0.22092	0.19988	0	100	100	0	0	0	1	-360	360;
	13	14	0.17093	0.34802	0	100	100	0	0	0	1	-360	360;
	4	7	0	0.20912	0	20	20	0	0.99677	0	1	-360	360;
	4	9	0	0.55618	0	20	20	0	0.99677	0	1	-360	360;
	6	5	0	0.25202	0	50	50	0	0.99677	0	1	-360	360;
	8	7	0	0.17615	0	50	50	0	0.99677	0	1	-360	360;
];

%% bus names
mpc.bus_name = {
	'BUS1        ';
	'BUS2        ';
	'BUS3        ';
	'BUS4        ';
	'BUS5        ';
	'BUS6        ';
	'BUS7        ';
	'BUS8        ';
	'BUS9        ';
	'BUS10       ';
	'BUS11       ';
	'BUS12       ';
	'BUS13       ';
	'BUS14       ';
};
