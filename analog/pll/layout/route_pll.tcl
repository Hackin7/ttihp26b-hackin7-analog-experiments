# Geometry-aware LVS spine router
drc off
cd /repo/analog/pll/layout
if {[file exists pll_analog_bare.mag]} {
  file copy -force pll_analog_bare.mag pll_analog.mag
} elseif {[file exists pll_analog_routed_backup.mag]} {
  file copy -force pll_analog_routed_backup.mag pll_analog.mag
}
load pll_analog
select top cell
box -15um -60um 150um 55um
foreach L {metal1 metal2 metal3 metal4 metal5 via1 via2 via3 via4 error_s} { catch {erase $L} }
catch {erase labels}
box -1.750um 6.750um -1.250um 7.250um
paint metal1
label clk_ref_gate FreeSans 0.7um 0 0 0
port make
port connections n s e w
box -1.750um 1.750um -1.250um 2.250um
paint metal1
label vco_out_div FreeSans 0.7um 0 0 0
port make
port connections n s e w
box 20.250um 12.250um 20.750um 12.750um
paint metal1
label VPWR FreeSans 0.7um 0 0 0
port make
port connections n s e w
box 20.250um -19.250um 20.750um -18.750um
paint metal1
label VGND FreeSans 0.7um 0 0 0
port make
port connections n s e w
box 66.720um -12.170um 67.220um -11.670um
paint metal1
label out FreeSans 0.7um 0 0 0
port make
port connections n s e w
box 36.250um 22.750um 36.750um 23.250um
paint metal1
label vctrl FreeSans 0.7um 0 0 0
# net clk_ref_gate  trunk=14.000
box -1.620um 6.880um -1.380um 7.120um
paint metal1
box -1.700um 6.800um -1.300um 7.200um
paint metal1
box -1.600um 6.900um -1.400um 7.100um
paint via1
box -1.700um 6.800um -1.300um 7.200um
paint metal2
box -1.700um 6.800um -1.300um 7.200um
paint metal2
box -1.600um 6.900um -1.400um 7.100um
paint via2
box -1.700um 6.800um -1.300um 7.200um
paint metal3
box -1.700um 6.800um -1.300um 7.200um
paint metal3
box -1.600um 6.900um -1.400um 7.100um
paint via3
box -1.700um 6.800um -1.300um 7.200um
paint metal4
box -2.300um 6.900um -1.400um 7.100um
paint metal4
box -2.400um 6.800um -2.000um 7.200um
paint metal3
box -2.300um 6.900um -2.100um 7.100um
paint via3
box -2.400um 6.800um -2.000um 7.200um
paint metal4
box -2.300um 6.900um -2.100um 14.100um
paint metal3
box -2.400um 13.800um -2.000um 14.200um
paint metal3
box -2.300um 13.900um -2.100um 14.100um
paint via3
box -2.400um 13.800um -2.000um 14.200um
paint metal4
box 6.840um 6.640um 7.080um 6.880um
paint metal1
box 6.760um 6.560um 7.160um 6.960um
paint metal1
box 6.860um 6.660um 7.060um 6.860um
paint via1
box 6.760um 6.560um 7.160um 6.960um
paint metal2
box 6.760um 6.560um 7.160um 6.960um
paint metal2
box 6.860um 6.660um 7.060um 6.860um
paint via2
box 6.760um 6.560um 7.160um 6.960um
paint metal3
box 6.760um 6.560um 7.160um 6.960um
paint metal3
box 6.860um 6.660um 7.060um 6.860um
paint via3
box 6.760um 6.560um 7.160um 6.960um
paint metal4
box 6.160um 6.660um 7.060um 6.860um
paint metal4
box 6.060um 6.560um 6.460um 6.960um
paint metal3
box 6.160um 6.660um 6.360um 6.860um
paint via3
box 6.060um 6.560um 6.460um 6.960um
paint metal4
box 6.160um 6.660um 6.360um 14.100um
paint metal3
box 6.060um 13.800um 6.460um 14.200um
paint metal3
box 6.160um 13.900um 6.360um 14.100um
paint via3
box 6.060um 13.800um 6.460um 14.200um
paint metal4
box -2.300um 13.900um 6.360um 14.100um
paint metal4
# net net1  trunk=14.700
box 2.567um 6.697um 2.808um 6.938um
paint metal1
box 2.487um 6.618um 2.888um 7.017um
paint metal1
box 2.587um 6.718um 2.788um 6.917um
paint via1
box 2.487um 6.618um 2.888um 7.017um
paint metal2
box 2.487um 6.618um 2.888um 7.017um
paint metal2
box 2.587um 6.718um 2.788um 6.917um
paint via2
box 2.487um 6.618um 2.888um 7.017um
paint metal3
box 2.487um 6.618um 2.888um 7.017um
paint metal3
box 2.587um 6.718um 2.788um 6.917um
paint via3
box 2.487um 6.618um 2.888um 7.017um
paint metal4
box 2.587um 6.718um 2.788um 7.267um
paint metal4
box -0.063um 7.067um 2.788um 7.267um
paint metal4
box -0.163um 6.968um 0.237um 7.367um
paint metal3
box -0.063um 7.067um 0.137um 7.267um
paint via3
box -0.163um 6.968um 0.237um 7.367um
paint metal4
box -0.063um 7.067um 0.137um 14.800um
paint metal3
box -0.163um 14.500um 0.237um 14.900um
paint metal3
box -0.063um 14.600um 0.137um 14.800um
paint via3
box -0.163um 14.500um 0.237um 14.900um
paint metal4
box 14.295um 3.800um 14.535um 4.040um
paint metal1
box 14.215um 3.720um 14.615um 4.120um
paint metal1
box 14.315um 3.820um 14.515um 4.020um
paint via1
box 14.215um 3.720um 14.615um 4.120um
paint metal2
box 14.215um 3.720um 14.615um 4.120um
paint metal2
box 14.315um 3.820um 14.515um 4.020um
paint via2
box 14.215um 3.720um 14.615um 4.120um
paint metal3
box 14.215um 3.720um 14.615um 4.120um
paint metal3
box 14.315um 3.820um 14.515um 4.020um
paint via3
box 14.215um 3.720um 14.615um 4.120um
paint metal4
box 13.615um 3.820um 14.515um 4.020um
paint metal4
box 13.515um 3.720um 13.915um 4.120um
paint metal3
box 13.615um 3.820um 13.815um 4.020um
paint via3
box 13.515um 3.720um 13.915um 4.120um
paint metal4
box 13.615um 3.820um 13.815um 14.800um
paint metal3
box 13.515um 14.500um 13.915um 14.900um
paint metal3
box 13.615um 14.600um 13.815um 14.800um
paint via3
box 13.515um 14.500um 13.915um 14.900um
paint metal4
box -0.063um 14.600um 13.815um 14.800um
paint metal4
# net net15  trunk=15.400
box 55.610um -4.990um 55.850um -4.750um
paint metal1
box 55.530um -5.070um 55.930um -4.670um
paint metal1
box 55.630um -4.970um 55.830um -4.770um
paint via1
box 55.530um -5.070um 55.930um -4.670um
paint metal2
box 55.530um -5.070um 55.930um -4.670um
paint metal2
box 55.630um -4.970um 55.830um -4.770um
paint via2
box 55.530um -5.070um 55.930um -4.670um
paint metal3
box 55.530um -5.070um 55.930um -4.670um
paint metal3
box 55.630um -4.970um 55.830um -4.770um
paint via3
box 55.530um -5.070um 55.930um -4.670um
paint metal4
box 54.930um -4.970um 55.830um -4.770um
paint metal4
box 54.830um -5.070um 55.230um -4.670um
paint metal3
box 54.930um -4.970um 55.130um -4.770um
paint via3
box 54.830um -5.070um 55.230um -4.670um
paint metal4
box 54.930um -4.970um 55.130um 15.500um
paint metal3
box 54.830um 15.200um 55.230um 15.600um
paint metal3
box 54.930um 15.300um 55.130um 15.500um
paint via3
box 54.830um 15.200um 55.230um 15.600um
paint metal4
box 34.020um -6.410um 35.020um -5.410um
paint metal1
box 34.320um -6.110um 34.720um -5.710um
paint metal1
box 34.420um -6.010um 34.620um -5.810um
paint via1
box 34.320um -6.110um 34.720um -5.710um
paint metal2
box 34.320um -6.110um 34.720um -5.710um
paint metal2
box 34.420um -6.010um 34.620um -5.810um
paint via2
box 34.320um -6.110um 34.720um -5.710um
paint metal3
box 34.320um -6.110um 34.720um -5.710um
paint metal3
box 34.420um -6.010um 34.620um -5.810um
paint via3
box 34.320um -6.110um 34.720um -5.710um
paint metal4
box 33.720um -6.010um 34.620um -5.810um
paint metal4
box 33.620um -6.110um 34.020um -5.710um
paint metal3
box 33.720um -6.010um 33.920um -5.810um
paint via3
box 33.620um -6.110um 34.020um -5.710um
paint metal4
box 33.720um -6.010um 33.920um 15.500um
paint metal3
box 33.620um 15.200um 34.020um 15.600um
paint metal3
box 33.720um 15.300um 33.920um 15.500um
paint via3
box 33.620um 15.200um 34.020um 15.600um
paint metal4
box 33.720um 15.300um 55.130um 15.500um
paint metal4
# net net2  trunk=16.100
box 18.400um 4.463um 18.640um 4.703um
paint metal1
box 18.320um 4.383um 18.720um 4.782um
paint metal1
box 18.420um 4.483um 18.620um 4.683um
paint via1
box 18.320um 4.383um 18.720um 4.782um
paint metal2
box 18.320um 4.383um 18.720um 4.782um
paint metal2
box 18.420um 4.483um 18.620um 4.683um
paint via2
box 18.320um 4.383um 18.720um 4.782um
paint metal3
box 18.320um 4.383um 18.720um 4.782um
paint metal3
box 18.420um 4.483um 18.620um 4.683um
paint via3
box 18.320um 4.383um 18.720um 4.782um
paint metal4
box 13.170um 4.483um 18.620um 4.683um
paint metal4
box 13.070um 4.383um 13.470um 4.782um
paint metal3
box 13.170um 4.483um 13.370um 4.683um
paint via3
box 13.070um 4.383um 13.470um 4.782um
paint metal4
box 13.170um 4.483um 13.370um 16.200um
paint metal3
box 13.070um 15.900um 13.470um 16.300um
paint metal3
box 13.170um 16.000um 13.370um 16.200um
paint via3
box 13.070um 15.900um 13.470um 16.300um
paint metal4
box 21.165um 5.520um 21.405um 5.760um
paint metal1
box 21.085um 5.440um 21.485um 5.840um
paint metal1
box 21.185um 5.540um 21.385um 5.740um
paint via1
box 21.085um 5.440um 21.485um 5.840um
paint metal2
box 21.085um 5.440um 21.485um 5.840um
paint metal2
box 21.185um 5.540um 21.385um 5.740um
paint via2
box 21.085um 5.440um 21.485um 5.840um
paint metal3
box 21.085um 5.440um 21.485um 5.840um
paint metal3
box 21.185um 5.540um 21.385um 5.740um
paint via3
box 21.085um 5.440um 21.485um 5.840um
paint metal4
box 21.185um 5.540um 29.235um 5.740um
paint metal4
box 28.935um 5.440um 29.335um 5.840um
paint metal3
box 29.035um 5.540um 29.235um 5.740um
paint via3
box 28.935um 5.440um 29.335um 5.840um
paint metal4
box 29.035um 5.540um 29.235um 16.200um
paint metal3
box 28.935um 15.900um 29.335um 16.300um
paint metal3
box 29.035um 16.000um 29.235um 16.200um
paint via3
box 28.935um 15.900um 29.335um 16.300um
paint metal4
box 13.170um 16.000um 29.235um 16.200um
paint metal4
# net net3  trunk=16.800
box 21.110um 3.730um 21.350um 3.970um
paint metal1
box 21.030um 3.650um 21.430um 4.050um
paint metal1
box 21.130um 3.750um 21.330um 3.950um
paint via1
box 21.030um 3.650um 21.430um 4.050um
paint metal2
box 21.030um 3.650um 21.430um 4.050um
paint metal2
box 21.130um 3.750um 21.330um 3.950um
paint via2
box 21.030um 3.650um 21.430um 4.050um
paint metal3
box 21.030um 3.650um 21.430um 4.050um
paint metal3
box 21.130um 3.750um 21.330um 3.950um
paint via3
box 21.030um 3.650um 21.430um 4.050um
paint metal4
box 21.130um 3.750um 26.580um 3.950um
paint metal4
box 26.280um 3.650um 26.680um 4.050um
paint metal3
box 26.380um 3.750um 26.580um 3.950um
paint via3
box 26.280um 3.650um 26.680um 4.050um
paint metal4
box 26.380um 3.750um 26.580um 16.900um
paint metal3
box 26.280um 16.600um 26.680um 17.000um
paint metal3
box 26.380um 16.700um 26.580um 16.900um
paint via3
box 26.280um 16.600um 26.680um 17.000um
paint metal4
box 20.590um 2.270um 20.830um 2.510um
paint metal1
box 20.510um 2.190um 20.910um 2.590um
paint metal1
box 20.610um 2.290um 20.810um 2.490um
paint via1
box 20.510um 2.190um 20.910um 2.590um
paint metal2
box 20.510um 2.190um 20.910um 2.590um
paint metal2
box 20.610um 2.290um 20.810um 2.490um
paint via2
box 20.510um 2.190um 20.910um 2.590um
paint metal3
box 20.510um 2.190um 20.910um 2.590um
paint metal3
box 20.610um 2.290um 20.810um 2.490um
paint via3
box 20.510um 2.190um 20.910um 2.590um
paint metal4
box 20.610um 2.290um 20.810um 3.190um
paint metal4
box 20.610um 2.990um 29.960um 3.190um
paint metal4
box 29.660um 2.890um 30.060um 3.290um
paint metal3
box 29.760um 2.990um 29.960um 3.190um
paint via3
box 29.660um 2.890um 30.060um 3.290um
paint metal4
box 29.760um 2.990um 29.960um 16.900um
paint metal3
box 29.660um 16.600um 30.060um 17.000um
paint metal3
box 29.760um 16.700um 29.960um 16.900um
paint via3
box 29.660um 16.600um 30.060um 17.000um
paint metal4
box 26.380um 16.700um 29.960um 16.900um
paint metal4
# net net4  trunk=17.500
box 20.910um 7.110um 21.150um 7.350um
paint metal1
box 20.830um 7.030um 21.230um 7.430um
paint metal1
box 20.930um 7.130um 21.130um 7.330um
paint via1
box 20.830um 7.030um 21.230um 7.430um
paint metal2
box 20.830um 7.030um 21.230um 7.430um
paint metal2
box 20.930um 7.130um 21.130um 7.330um
paint via2
box 20.830um 7.030um 21.230um 7.430um
paint metal3
box 20.830um 7.030um 21.230um 7.430um
paint metal3
box 20.930um 7.130um 21.130um 7.330um
paint via3
box 20.830um 7.030um 21.230um 7.430um
paint metal4
box 20.930um 7.130um 21.130um 8.030um
paint metal4
box 20.930um 7.830um 30.930um 8.030um
paint metal4
box 30.630um 7.730um 31.030um 8.130um
paint metal3
box 30.730um 7.830um 30.930um 8.030um
paint via3
box 30.630um 7.730um 31.030um 8.130um
paint metal4
box 30.730um 7.830um 30.930um 17.600um
paint metal3
box 30.630um 17.300um 31.030um 17.700um
paint metal3
box 30.730um 17.400um 30.930um 17.600um
paint via3
box 30.630um 17.300um 31.030um 17.700um
paint metal4
box 30.730um 17.400um 30.930um 17.600um
paint metal4
# net pfd_down  trunk=18.200
box 12.623um 2.785um 12.862um 3.025um
paint metal1
box 12.543um 2.705um 12.942um 3.105um
paint metal1
box 12.643um 2.805um 12.842um 3.005um
paint via1
box 12.543um 2.705um 12.942um 3.105um
paint metal2
box 12.543um 2.705um 12.942um 3.105um
paint metal2
box 12.643um 2.805um 12.842um 3.005um
paint via2
box 12.543um 2.705um 12.942um 3.105um
paint metal3
box 12.543um 2.705um 12.942um 3.105um
paint metal3
box 12.643um 2.805um 12.842um 3.005um
paint via3
box 12.543um 2.705um 12.942um 3.105um
paint metal4
box 5.442um 2.805um 12.842um 3.005um
paint metal4
box 5.343um 2.705um 5.742um 3.105um
paint metal3
box 5.442um 2.805um 5.642um 3.005um
paint via3
box 5.343um 2.705um 5.742um 3.105um
paint metal4
box 5.442um 2.805um 5.642um 18.300um
paint metal3
box 5.343um 18.000um 5.742um 18.400um
paint metal3
box 5.442um 18.100um 5.642um 18.300um
paint via3
box 5.343um 18.000um 5.742um 18.400um
paint metal4
box 15.878um 5.768um 16.117um 6.008um
paint metal1
box 15.798um 5.688um 16.198um 6.087um
paint metal1
box 15.898um 5.788um 16.098um 5.987um
paint via1
box 15.798um 5.688um 16.198um 6.087um
paint metal2
box 15.798um 5.688um 16.198um 6.087um
paint metal2
box 15.898um 5.788um 16.098um 5.987um
paint via2
box 15.798um 5.688um 16.198um 6.087um
paint metal3
box 15.798um 5.688um 16.198um 6.087um
paint metal3
box 15.898um 5.788um 16.098um 5.987um
paint via3
box 15.798um 5.688um 16.198um 6.087um
paint metal4
box 4.798um 5.788um 16.098um 5.987um
paint metal4
box 4.698um 5.688um 5.098um 6.087um
paint metal3
box 4.798um 5.788um 4.998um 5.987um
paint via3
box 4.698um 5.688um 5.098um 6.087um
paint metal4
box 4.798um 5.788um 4.998um 18.300um
paint metal3
box 4.698um 18.000um 5.098um 18.400um
paint metal3
box 4.798um 18.100um 4.998um 18.300um
paint via3
box 4.698um 18.000um 5.098um 18.400um
paint metal4
box 4.798um 18.100um 5.642um 18.300um
paint metal4
# net pfd_up  trunk=18.900
box 12.623um 7.585um 12.862um 7.825um
paint metal1
box 12.543um 7.505um 12.942um 7.905um
paint metal1
box 12.643um 7.605um 12.842um 7.805um
paint via1
box 12.543um 7.505um 12.942um 7.905um
paint metal2
box 12.543um 7.505um 12.942um 7.905um
paint metal2
box 12.643um 7.605um 12.842um 7.805um
paint via2
box 12.543um 7.505um 12.942um 7.905um
paint metal3
box 12.543um 7.505um 12.942um 7.905um
paint metal3
box 12.643um 7.605um 12.842um 7.805um
paint via3
box 12.543um 7.505um 12.942um 7.905um
paint metal4
box -1.057um 7.605um 12.842um 7.805um
paint metal4
box -1.157um 7.505um -0.757um 7.905um
paint metal3
box -1.057um 7.605um -0.857um 7.805um
paint via3
box -1.157um 7.505um -0.757um 7.905um
paint metal4
box -1.057um 7.605um -0.857um 19.000um
paint metal3
box -1.157um 18.700um -0.757um 19.100um
paint metal3
box -1.057um 18.800um -0.857um 19.000um
paint via3
box -1.157um 18.700um -0.757um 19.100um
paint metal4
box 15.345um 4.798um 15.585um 5.038um
paint metal1
box 15.265um 4.718um 15.665um 5.117um
paint metal1
box 15.365um 4.818um 15.565um 5.018um
paint via1
box 15.265um 4.718um 15.665um 5.117um
paint metal2
box 15.365um 4.818um 15.565um 5.718um
paint metal2
box -2.885um 5.518um 15.565um 5.718um
paint metal2
box -2.985um 5.418um -2.585um 5.817um
paint metal2
box -2.885um 5.518um -2.685um 5.718um
paint via2
box -2.985um 5.418um -2.585um 5.817um
paint metal3
box -2.885um 5.518um -2.685um 19.000um
paint metal3
box -2.985um 18.700um -2.585um 19.100um
paint metal3
box -2.885um 18.800um -2.685um 19.000um
paint via3
box -2.985um 18.700um -2.585um 19.100um
paint metal4
box -2.885um 18.800um -0.857um 19.000um
paint metal4
# net vbn  trunk=19.600
box 21.280um 2.740um 21.520um 2.980um
paint metal1
box 21.200um 2.660um 21.600um 3.060um
paint metal1
box 21.300um 2.760um 21.500um 2.960um
paint via1
box 21.200um 2.660um 21.600um 3.060um
paint metal2
box 21.200um 2.660um 21.600um 3.060um
paint metal2
box 21.300um 2.760um 21.500um 2.960um
paint via2
box 21.200um 2.660um 21.600um 3.060um
paint metal3
box 21.300um 1.710um 21.500um 2.960um
paint metal3
box 21.300um 1.710um 31.950um 1.910um
paint metal3
box 31.750um 1.710um 31.950um 19.700um
paint metal3
box 31.650um 19.400um 32.050um 19.800um
paint metal3
box 31.750um 19.500um 31.950um 19.700um
paint via3
box 31.650um 19.400um 32.050um 19.800um
paint metal4
box 22.070um -2.520um 22.310um -2.280um
paint metal1
box 21.990um -2.600um 22.390um -2.200um
paint metal1
box 22.090um -2.500um 22.290um -2.300um
paint via1
box 21.990um -2.600um 22.390um -2.200um
paint metal2
box 21.990um -2.600um 22.390um -2.200um
paint metal2
box 22.090um -2.500um 22.290um -2.300um
paint via2
box 21.990um -2.600um 22.390um -2.200um
paint metal3
box 21.990um -2.600um 22.390um -2.200um
paint metal3
box 22.090um -2.500um 22.290um -2.300um
paint via3
box 21.990um -2.600um 22.390um -2.200um
paint metal4
box 22.090um -2.500um 22.290um -1.950um
paint metal4
box 22.090um -2.150um 32.740um -1.950um
paint metal4
box 32.440um -2.250um 32.840um -1.850um
paint metal3
box 32.540um -2.150um 32.740um -1.950um
paint via3
box 32.440um -2.250um 32.840um -1.850um
paint metal4
box 32.540um -2.150um 32.740um 19.700um
paint metal3
box 32.440um 19.400um 32.840um 19.800um
paint metal3
box 32.540um 19.500um 32.740um 19.700um
paint via3
box 32.440um 19.400um 32.840um 19.800um
paint metal4
box 21.390um -1.440um 21.630um -1.200um
paint metal1
box 21.310um -1.520um 21.710um -1.120um
paint metal1
box 21.410um -1.420um 21.610um -1.220um
paint via1
box 21.310um -1.520um 21.710um -1.120um
paint metal2
box 21.310um -1.520um 21.710um -1.120um
paint metal2
box 21.410um -1.420um 21.610um -1.220um
paint via2
box 21.310um -1.520um 21.710um -1.120um
paint metal3
box 21.310um -1.520um 21.710um -1.120um
paint metal3
box 21.410um -1.420um 21.610um -1.220um
paint via3
box 21.310um -1.520um 21.710um -1.120um
paint metal4
box 21.410um -1.420um 21.610um -0.520um
paint metal4
box 21.410um -0.720um 33.360um -0.520um
paint metal4
box 33.060um -0.820um 33.460um -0.420um
paint metal3
box 33.160um -0.720um 33.360um -0.520um
paint via3
box 33.060um -0.820um 33.460um -0.420um
paint metal4
box 33.160um -0.720um 33.360um 19.700um
paint metal3
box 33.060um 19.400um 33.460um 19.800um
paint metal3
box 33.160um 19.500um 33.360um 19.700um
paint via3
box 33.060um 19.400um 33.460um 19.800um
paint metal4
box 22.080um -0.970um 22.320um -0.730um
paint metal1
box 22.000um -1.050um 22.400um -0.650um
paint metal1
box 22.100um -0.950um 22.300um -0.750um
paint via1
box 22.000um -1.050um 22.400um -0.650um
paint metal2
box 22.100um -0.950um 22.300um -0.400um
paint metal2
box 22.100um -0.600um 35.350um -0.400um
paint metal2
box 35.050um -0.700um 35.450um -0.300um
paint metal2
box 35.150um -0.600um 35.350um -0.400um
paint via2
box 35.050um -0.700um 35.450um -0.300um
paint metal3
box 35.150um -0.600um 35.350um 19.700um
paint metal3
box 35.050um 19.400um 35.450um 19.800um
paint metal3
box 35.150um 19.500um 35.350um 19.700um
paint via3
box 35.050um 19.400um 35.450um 19.800um
paint metal4
box 19.810um -15.350um 20.050um -15.110um
paint metal1
box 19.730um -15.430um 20.130um -15.030um
paint metal1
box 19.830um -15.330um 20.030um -15.130um
paint via1
box 19.730um -15.430um 20.130um -15.030um
paint metal2
box 19.730um -15.430um 20.130um -15.030um
paint metal2
box 19.830um -15.330um 20.030um -15.130um
paint via2
box 19.730um -15.430um 20.130um -15.030um
paint metal3
box 19.730um -15.430um 20.130um -15.030um
paint metal3
box 19.830um -15.330um 20.030um -15.130um
paint via3
box 19.730um -15.430um 20.130um -15.030um
paint metal4
box 19.830um -15.330um 37.630um -15.130um
paint metal4
box 37.330um -15.430um 37.730um -15.030um
paint metal3
box 37.430um -15.330um 37.630um -15.130um
paint via3
box 37.330um -15.430um 37.730um -15.030um
paint metal4
box 37.430um -15.330um 37.630um 19.700um
paint metal3
box 37.330um 19.400um 37.730um 19.800um
paint metal3
box 37.430um 19.500um 37.630um 19.700um
paint via3
box 37.330um 19.400um 37.730um 19.800um
paint metal4
box 31.750um 19.500um 37.630um 19.700um
paint metal4
# net vbp  trunk=20.300
box 21.600um 7.830um 21.840um 8.070um
paint metal1
box 21.520um 7.750um 21.920um 8.150um
paint metal1
box 21.620um 7.850um 21.820um 8.050um
paint via1
box 21.520um 7.750um 21.920um 8.150um
paint metal2
box 21.620um 7.850um 38.120um 8.050um
paint metal2
box 37.820um 7.750um 38.220um 8.150um
paint metal2
box 37.920um 7.850um 38.120um 8.050um
paint via2
box 37.820um 7.750um 38.220um 8.150um
paint metal3
box 37.920um 7.850um 38.120um 20.400um
paint metal3
box 37.820um 20.100um 38.220um 20.500um
paint metal3
box 37.920um 20.200um 38.120um 20.400um
paint via3
box 37.820um 20.100um 38.220um 20.500um
paint metal4
box 21.380um -2.990um 21.620um -2.750um
paint metal1
box 21.300um -3.070um 21.700um -2.670um
paint metal1
box 21.400um -2.970um 21.600um -2.770um
paint via1
box 21.300um -3.070um 21.700um -2.670um
paint metal2
box 21.300um -3.070um 21.700um -2.670um
paint metal2
box 21.400um -2.970um 21.600um -2.770um
paint via2
box 21.300um -3.070um 21.700um -2.670um
paint metal3
box 21.300um -3.070um 21.700um -2.670um
paint metal3
box 21.400um -2.970um 21.600um -2.770um
paint via3
box 21.300um -3.070um 21.700um -2.670um
paint metal4
box 21.400um -3.670um 21.600um -2.770um
paint metal4
box 21.400um -3.670um 35.950um -3.470um
paint metal4
box 35.650um -3.770um 36.050um -3.370um
paint metal3
box 35.750um -3.670um 35.950um -3.470um
paint via3
box 35.650um -3.770um 36.050um -3.370um
paint metal4
box 35.750um -3.670um 35.950um 20.400um
paint metal3
box 35.650um 20.100um 36.050um 20.500um
paint metal3
box 35.750um 20.200um 35.950um 20.400um
paint via3
box 35.650um 20.100um 36.050um 20.500um
paint metal4
box 23.030um -4.700um 23.270um -4.460um
paint metal1
box 22.950um -4.780um 23.350um -4.380um
paint metal1
box 23.050um -4.680um 23.250um -4.480um
paint via1
box 22.950um -4.780um 23.350um -4.380um
paint metal2
box 22.950um -4.780um 23.350um -4.380um
paint metal2
box 23.050um -4.680um 23.250um -4.480um
paint via2
box 22.950um -4.780um 23.350um -4.380um
paint metal3
box 22.950um -4.780um 23.350um -4.380um
paint metal3
box 23.050um -4.680um 23.250um -4.480um
paint via3
box 22.950um -4.780um 23.350um -4.380um
paint metal4
box 23.050um -5.380um 23.250um -4.480um
paint metal4
box 23.050um -5.380um 38.900um -5.180um
paint metal4
box 38.600um -5.480um 39.000um -5.080um
paint metal3
box 38.700um -5.380um 38.900um -5.180um
paint via3
box 38.600um -5.480um 39.000um -5.080um
paint metal4
box 38.700um -5.380um 38.900um 20.400um
paint metal3
box 38.600um 20.100um 39.000um 20.500um
paint metal3
box 38.700um 20.200um 38.900um 20.400um
paint via3
box 38.600um 20.100um 39.000um 20.500um
paint metal4
box 22.340um -5.420um 22.580um -5.180um
paint metal1
box 22.260um -5.500um 22.660um -5.100um
paint metal1
box 22.360um -5.400um 22.560um -5.200um
paint via1
box 22.260um -5.500um 22.660um -5.100um
paint metal2
box 22.260um -5.500um 22.660um -5.100um
paint metal2
box 22.360um -5.400um 22.560um -5.200um
paint via2
box 22.260um -5.500um 22.660um -5.100um
paint metal3
box 22.260um -5.500um 22.660um -5.100um
paint metal3
box 22.360um -5.400um 22.560um -5.200um
paint via3
box 22.260um -5.500um 22.660um -5.100um
paint metal4
box 22.360um -6.800um 22.560um -5.200um
paint metal4
box 22.360um -6.800um 39.510um -6.600um
paint metal4
box 39.210um -6.900um 39.610um -6.500um
paint metal3
box 39.310um -6.800um 39.510um -6.600um
paint via3
box 39.210um -6.900um 39.610um -6.500um
paint metal4
box 39.310um -6.800um 39.510um 20.400um
paint metal3
box 39.210um 20.100um 39.610um 20.500um
paint metal3
box 39.310um 20.200um 39.510um 20.400um
paint via3
box 39.210um 20.100um 39.610um 20.500um
paint metal4
box 35.750um 20.200um 39.510um 20.400um
paint metal4
# net vco_out_div  trunk=21.000
box -1.620um 1.880um -1.380um 2.120um
paint metal1
box -1.700um 1.800um -1.300um 2.200um
paint metal1
box -1.600um 1.900um -1.400um 2.100um
paint via1
box -1.700um 1.800um -1.300um 2.200um
paint metal2
box -1.700um 1.800um -1.300um 2.200um
paint metal2
box -1.600um 1.900um -1.400um 2.100um
paint via2
box -1.700um 1.800um -1.300um 2.200um
paint metal3
box -1.700um 1.800um -1.300um 2.200um
paint metal3
box -1.600um 1.900um -1.400um 2.100um
paint via3
box -1.700um 1.800um -1.300um 2.200um
paint metal4
box -3.600um 1.900um -1.400um 2.100um
paint metal4
box -3.700um 1.800um -3.300um 2.200um
paint metal3
box -3.600um 1.900um -3.400um 2.100um
paint via3
box -3.700um 1.800um -3.300um 2.200um
paint metal4
box -3.600um 1.900um -3.400um 21.100um
paint metal3
box -3.700um 20.800um -3.300um 21.200um
paint metal3
box -3.600um 20.900um -3.400um 21.100um
paint via3
box -3.700um 20.800um -3.300um 21.200um
paint metal4
box 6.840um 1.840um 7.080um 2.080um
paint metal1
box 6.760um 1.760um 7.160um 2.160um
paint metal1
box 6.860um 1.860um 7.060um 2.060um
paint via1
box 6.760um 1.760um 7.160um 2.160um
paint metal2
box 6.760um 1.760um 7.160um 2.160um
paint metal2
box 6.860um 1.860um 7.060um 2.060um
paint via2
box 6.760um 1.760um 7.160um 2.160um
paint metal3
box 6.760um 1.760um 7.160um 2.160um
paint metal3
box 6.860um 1.860um 7.060um 2.060um
paint via3
box 6.760um 1.760um 7.160um 2.160um
paint metal4
box 6.860um 0.810um 7.060um 2.060um
paint metal4
box -4.240um 0.810um 7.060um 1.010um
paint metal4
box -4.340um 0.710um -3.940um 1.110um
paint metal3
box -4.240um 0.810um -4.040um 1.010um
paint via3
box -4.340um 0.710um -3.940um 1.110um
paint metal4
box -4.240um 0.810um -4.040um 21.100um
paint metal3
box -4.340um 20.800um -3.940um 21.200um
paint metal3
box -4.240um 20.900um -4.040um 21.100um
paint via3
box -4.340um 20.800um -3.940um 21.200um
paint metal4
box -4.240um 20.900um -3.400um 21.100um
paint metal4
# net vctrl  trunk=21.700
box 36.380um 22.880um 36.620um 23.120um
paint metal1
box 36.300um 22.800um 36.700um 23.200um
paint metal1
box 36.400um 22.900um 36.600um 23.100um
paint via1
box 36.300um 22.800um 36.700um 23.200um
paint metal2
box 36.300um 22.800um 36.700um 23.200um
paint metal2
box 36.400um 22.900um 36.600um 23.100um
paint via2
box 36.300um 22.800um 36.700um 23.200um
paint metal3
box 36.300um 22.800um 36.700um 23.200um
paint metal3
box 36.400um 22.900um 36.600um 23.100um
paint via3
box 36.300um 22.800um 36.700um 23.200um
paint metal4
box 36.400um 22.900um 37.300um 23.100um
paint metal4
box 37.000um 22.800um 37.400um 23.200um
paint metal3
box 37.100um 22.900um 37.300um 23.100um
paint via3
box 37.000um 22.800um 37.400um 23.200um
paint metal4
box 37.100um 21.600um 37.300um 23.100um
paint metal3
box 37.000um 21.500um 37.400um 21.900um
paint metal3
box 37.100um 21.600um 37.300um 21.800um
paint via3
box 37.000um 21.500um 37.400um 21.900um
paint metal4
box 20.600um 3.730um 20.840um 3.970um
paint metal1
box 20.520um 3.650um 20.920um 4.050um
paint metal1
box 20.620um 3.750um 20.820um 3.950um
paint via1
box 20.520um 3.650um 20.920um 4.050um
paint metal2
box 20.520um 3.650um 20.920um 4.050um
paint metal2
box 20.620um 3.750um 20.820um 3.950um
paint via2
box 20.520um 3.650um 20.920um 4.050um
paint metal3
box 20.520um 3.650um 20.920um 4.050um
paint metal3
box 20.620um 3.750um 20.820um 3.950um
paint via3
box 20.520um 3.650um 20.920um 4.050um
paint metal4
box 20.620um 3.750um 20.820um 4.650um
paint metal4
box 20.620um 4.450um 40.370um 4.650um
paint metal4
box 40.070um 4.350um 40.470um 4.750um
paint metal3
box 40.170um 4.450um 40.370um 4.650um
paint via3
box 40.070um 4.350um 40.470um 4.750um
paint metal4
box 40.170um 4.450um 40.370um 21.800um
paint metal3
box 40.070um 21.500um 40.470um 21.900um
paint metal3
box 40.170um 21.600um 40.370um 21.800um
paint via3
box 40.070um 21.500um 40.470um 21.900um
paint metal4
box 46.790um -4.990um 47.030um -4.750um
paint metal1
box 46.710um -5.070um 47.110um -4.670um
paint metal1
box 46.810um -4.970um 47.010um -4.770um
paint via1
box 46.710um -5.070um 47.110um -4.670um
paint metal2
box 46.710um -5.070um 47.110um -4.670um
paint metal2
box 46.810um -4.970um 47.010um -4.770um
paint via2
box 46.710um -5.070um 47.110um -4.670um
paint metal3
box 46.710um -5.070um 47.110um -4.670um
paint metal3
box 46.810um -4.970um 47.010um -4.770um
paint via3
box 46.710um -5.070um 47.110um -4.670um
paint metal4
box 46.110um -4.970um 47.010um -4.770um
paint metal4
box 46.010um -5.070um 46.410um -4.670um
paint metal3
box 46.110um -4.970um 46.310um -4.770um
paint via3
box 46.010um -5.070um 46.410um -4.670um
paint metal4
box 46.110um -4.970um 46.310um 21.800um
paint metal3
box 46.010um 21.500um 46.410um 21.900um
paint metal3
box 46.110um 21.600um 46.310um 21.800um
paint via3
box 46.010um 21.500um 46.410um 21.900um
paint metal4
box 49.850um -12.450um 50.850um -11.450um
paint metal1
box 50.150um -12.150um 50.550um -11.750um
paint metal1
box 50.250um -12.050um 50.450um -11.850um
paint via1
box 50.150um -12.150um 50.550um -11.750um
paint metal2
box 50.150um -12.150um 50.550um -11.750um
paint metal2
box 50.250um -12.050um 50.450um -11.850um
paint via2
box 50.150um -12.150um 50.550um -11.750um
paint metal3
box 50.150um -12.150um 50.550um -11.750um
paint metal3
box 50.250um -12.050um 50.450um -11.850um
paint via3
box 50.150um -12.150um 50.550um -11.750um
paint metal4
box 49.550um -12.050um 50.450um -11.850um
paint metal4
box 49.450um -12.150um 49.850um -11.750um
paint metal3
box 49.550um -12.050um 49.750um -11.850um
paint via3
box 49.450um -12.150um 49.850um -11.750um
paint metal4
box 49.550um -12.050um 49.750um 21.800um
paint metal3
box 49.450um 21.500um 49.850um 21.900um
paint metal3
box 49.550um 21.600um 49.750um 21.800um
paint via3
box 49.450um 21.500um 49.850um 21.900um
paint metal4
box 60.325um -15.030um 60.565um -14.790um
paint metal1
box 60.245um -15.110um 60.645um -14.710um
paint metal1
box 60.345um -15.010um 60.545um -14.810um
paint via1
box 60.245um -15.110um 60.645um -14.710um
paint metal2
box 60.245um -15.110um 60.645um -14.710um
paint metal2
box 60.345um -15.010um 60.545um -14.810um
paint via2
box 60.245um -15.110um 60.645um -14.710um
paint metal3
box 60.245um -15.110um 60.645um -14.710um
paint metal3
box 60.345um -15.010um 60.545um -14.810um
paint via3
box 60.245um -15.110um 60.645um -14.710um
paint metal4
box 53.795um -15.010um 60.545um -14.810um
paint metal4
box 53.695um -15.110um 54.095um -14.710um
paint metal3
box 53.795um -15.010um 53.995um -14.810um
paint via3
box 53.695um -15.110um 54.095um -14.710um
paint metal4
box 53.795um -15.010um 53.995um 21.800um
paint metal3
box 53.695um 21.500um 54.095um 21.900um
paint metal3
box 53.795um 21.600um 53.995um 21.800um
paint via3
box 53.695um 21.500um 54.095um 21.900um
paint metal4
box 62.625um -15.030um 62.865um -14.790um
paint metal1
box 62.545um -15.110um 62.945um -14.710um
paint metal1
box 62.645um -15.010um 62.845um -14.810um
paint via1
box 62.545um -15.110um 62.945um -14.710um
paint metal2
box 62.545um -15.110um 62.945um -14.710um
paint metal2
box 62.645um -15.010um 62.845um -14.810um
paint via2
box 62.545um -15.110um 62.945um -14.710um
paint metal3
box 62.545um -15.110um 62.945um -14.710um
paint metal3
box 62.645um -15.010um 62.845um -14.810um
paint via3
box 62.545um -15.110um 62.945um -14.710um
paint metal4
box 62.645um -15.010um 69.395um -14.810um
paint metal4
box 69.095um -15.110um 69.495um -14.710um
paint metal3
box 69.195um -15.010um 69.395um -14.810um
paint via3
box 69.095um -15.110um 69.495um -14.710um
paint metal4
box 69.195um -15.010um 69.395um 21.800um
paint metal3
box 69.095um 21.500um 69.495um 21.900um
paint metal3
box 69.195um 21.600um 69.395um 21.800um
paint via3
box 69.095um 21.500um 69.495um 21.900um
paint metal4
box 58.025um -15.030um 58.265um -14.790um
paint metal1
box 57.945um -15.110um 58.345um -14.710um
paint metal1
box 58.045um -15.010um 58.245um -14.810um
paint via1
box 57.945um -15.110um 58.345um -14.710um
paint metal2
box 57.945um -15.110um 58.345um -14.710um
paint metal2
box 58.045um -15.010um 58.245um -14.810um
paint via2
box 57.945um -15.110um 58.345um -14.710um
paint metal3
box 58.045um -15.710um 58.245um -14.810um
paint metal3
box 48.895um -15.710um 58.245um -15.510um
paint metal3
box 48.895um -15.710um 49.095um 21.800um
paint metal3
box 48.795um 21.500um 49.195um 21.900um
paint metal3
box 48.895um 21.600um 49.095um 21.800um
paint via3
box 48.795um 21.500um 49.195um 21.900um
paint metal4
box 55.725um -12.830um 55.965um -12.590um
paint metal1
box 55.645um -12.910um 56.045um -12.510um
paint metal1
box 55.745um -12.810um 55.945um -12.610um
paint via1
box 55.645um -12.910um 56.045um -12.510um
paint metal2
box 55.645um -12.910um 56.045um -12.510um
paint metal2
box 55.745um -12.810um 55.945um -12.610um
paint via2
box 55.645um -12.910um 56.045um -12.510um
paint metal3
box 55.645um -12.910um 56.045um -12.510um
paint metal3
box 55.745um -12.810um 55.945um -12.610um
paint via3
box 55.645um -12.910um 56.045um -12.510um
paint metal4
box 53.095um -12.810um 55.945um -12.610um
paint metal4
box 52.995um -12.910um 53.395um -12.510um
paint metal3
box 53.095um -12.810um 53.295um -12.610um
paint via3
box 52.995um -12.910um 53.395um -12.510um
paint metal4
box 53.095um -12.810um 53.295um 21.800um
paint metal3
box 52.995um 21.500um 53.395um 21.900um
paint metal3
box 53.095um 21.600um 53.295um 21.800um
paint via3
box 52.995um 21.500um 53.395um 21.900um
paint metal4
box 37.100um 21.600um 69.395um 21.800um
paint metal4
# net net10  trunk=-21.000
box 57.710um -15.620um 57.950um -15.380um
paint metal1
box 57.630um -15.700um 58.030um -15.300um
paint metal1
box 57.730um -15.600um 57.930um -15.400um
paint via1
box 57.630um -15.700um 58.030um -15.300um
paint metal2
box 57.630um -15.700um 58.030um -15.300um
paint metal2
box 57.730um -15.600um 57.930um -15.400um
paint via2
box 57.630um -15.700um 58.030um -15.300um
paint metal3
box 57.630um -15.700um 58.030um -15.300um
paint metal3
box 57.730um -15.600um 57.930um -15.400um
paint via3
box 57.630um -15.700um 58.030um -15.300um
paint metal4
box 47.930um -15.600um 57.930um -15.400um
paint metal4
box 47.830um -15.700um 48.230um -15.300um
paint metal3
box 47.930um -15.600um 48.130um -15.400um
paint via3
box 47.830um -15.700um 48.230um -15.300um
paint metal4
box 47.930um -21.100um 48.130um -15.400um
paint metal3
box 47.830um -21.200um 48.230um -20.800um
paint metal3
box 47.930um -21.100um 48.130um -20.900um
paint via3
box 47.830um -21.200um 48.230um -20.800um
paint metal4
box 47.930um -21.100um 48.130um -20.900um
paint metal4
# net net11  trunk=-21.700
box 63.250um -10.830um 63.490um -10.590um
paint metal1
box 63.170um -10.910um 63.570um -10.510um
paint metal1
box 63.270um -10.810um 63.470um -10.610um
paint via1
box 63.170um -10.910um 63.570um -10.510um
paint metal2
box 63.170um -10.910um 63.570um -10.510um
paint metal2
box 63.270um -10.810um 63.470um -10.610um
paint via2
box 63.170um -10.910um 63.570um -10.510um
paint metal3
box 63.170um -10.910um 63.570um -10.510um
paint metal3
box 63.270um -10.810um 63.470um -10.610um
paint via3
box 63.170um -10.910um 63.570um -10.510um
paint metal4
box 63.270um -10.810um 63.470um -9.910um
paint metal4
box 63.270um -10.110um 70.020um -9.910um
paint metal4
box 69.720um -10.210um 70.120um -9.810um
paint metal3
box 69.820um -10.110um 70.020um -9.910um
paint via3
box 69.720um -10.210um 70.120um -9.810um
paint metal4
box 69.820um -21.800um 70.020um -9.910um
paint metal3
box 69.720um -21.900um 70.120um -21.500um
paint metal3
box 69.820um -21.800um 70.020um -21.600um
paint via3
box 69.720um -21.900um 70.120um -21.500um
paint metal4
box 62.620um -8.230um 62.860um -7.990um
paint metal1
box 62.540um -8.310um 62.940um -7.910um
paint metal1
box 62.640um -8.210um 62.840um -8.010um
paint via1
box 62.540um -8.310um 62.940um -7.910um
paint metal2
box 62.540um -8.310um 62.940um -7.910um
paint metal2
box 62.640um -8.210um 62.840um -8.010um
paint via2
box 62.540um -8.310um 62.940um -7.910um
paint metal3
box 62.540um -8.310um 62.940um -7.910um
paint metal3
box 62.640um -8.210um 62.840um -8.010um
paint via3
box 62.540um -8.310um 62.940um -7.910um
paint metal4
box 62.640um -8.210um 62.840um -7.310um
paint metal4
box 62.640um -7.510um 70.690um -7.310um
paint metal4
box 70.390um -7.610um 70.790um -7.210um
paint metal3
box 70.490um -7.510um 70.690um -7.310um
paint via3
box 70.390um -7.610um 70.790um -7.210um
paint metal4
box 70.490um -21.800um 70.690um -7.310um
paint metal3
box 70.390um -21.900um 70.790um -21.500um
paint metal3
box 70.490um -21.800um 70.690um -21.600um
paint via3
box 70.390um -21.900um 70.790um -21.500um
paint metal4
box 69.820um -21.800um 70.690um -21.600um
paint metal4
# net net12  trunk=-22.400
box 62.935um -7.450um 63.175um -7.210um
paint metal1
box 62.855um -7.530um 63.255um -7.130um
paint metal1
box 62.955um -7.430um 63.155um -7.230um
paint via1
box 62.855um -7.530um 63.255um -7.130um
paint metal2
box 62.955um -7.430um 71.655um -7.230um
paint metal2
box 71.355um -7.530um 71.755um -7.130um
paint metal2
box 71.455um -7.430um 71.655um -7.230um
paint via2
box 71.355um -7.530um 71.755um -7.130um
paint metal3
box 71.455um -22.500um 71.655um -7.230um
paint metal3
box 71.355um -22.600um 71.755um -22.200um
paint metal3
box 71.455um -22.500um 71.655um -22.300um
paint via3
box 71.355um -22.600um 71.755um -22.200um
paint metal4
box 60.635um -7.450um 60.875um -7.210um
paint metal1
box 60.555um -7.530um 60.955um -7.130um
paint metal1
box 60.655um -7.430um 60.855um -7.230um
paint via1
box 60.555um -7.530um 60.955um -7.130um
paint metal2
box 60.555um -7.530um 60.955um -7.130um
paint metal2
box 60.655um -7.430um 60.855um -7.230um
paint via2
box 60.555um -7.530um 60.955um -7.130um
paint metal3
box 60.555um -7.530um 60.955um -7.130um
paint metal3
box 60.655um -7.430um 60.855um -7.230um
paint via3
box 60.555um -7.530um 60.955um -7.130um
paint metal4
box 60.655um -7.430um 60.855um -6.530um
paint metal4
box 60.655um -6.730um 72.605um -6.530um
paint metal4
box 72.305um -6.830um 72.705um -6.430um
paint metal3
box 72.405um -6.730um 72.605um -6.530um
paint via3
box 72.305um -6.830um 72.705um -6.430um
paint metal4
box 72.405um -22.500um 72.605um -6.530um
paint metal3
box 72.305um -22.600um 72.705um -22.200um
paint metal3
box 72.405um -22.500um 72.605um -22.300um
paint via3
box 72.305um -22.600um 72.705um -22.200um
paint metal4
box 58.335um -7.450um 58.575um -7.210um
paint metal1
box 58.255um -7.530um 58.655um -7.130um
paint metal1
box 58.355um -7.430um 58.555um -7.230um
paint via1
box 58.255um -7.530um 58.655um -7.130um
paint metal2
box 58.255um -7.530um 58.655um -7.130um
paint metal2
box 58.355um -7.430um 58.555um -7.230um
paint via2
box 58.255um -7.530um 58.655um -7.130um
paint metal3
box 58.255um -7.530um 58.655um -7.130um
paint metal3
box 58.355um -7.430um 58.555um -7.230um
paint via3
box 58.255um -7.530um 58.655um -7.130um
paint metal4
box 47.255um -7.430um 58.555um -7.230um
paint metal4
box 47.155um -7.530um 47.555um -7.130um
paint metal3
box 47.255um -7.430um 47.455um -7.230um
paint via3
box 47.155um -7.530um 47.555um -7.130um
paint metal4
box 47.255um -22.500um 47.455um -7.230um
paint metal3
box 47.155um -22.600um 47.555um -22.200um
paint metal3
box 47.255um -22.500um 47.455um -22.300um
paint via3
box 47.155um -22.600um 47.555um -22.200um
paint metal4
box 55.720um -8.230um 55.960um -7.990um
paint metal1
box 55.640um -8.310um 56.040um -7.910um
paint metal1
box 55.740um -8.210um 55.940um -8.010um
paint via1
box 55.640um -8.310um 56.040um -7.910um
paint metal2
box 55.640um -8.310um 56.040um -7.910um
paint metal2
box 55.740um -8.210um 55.940um -8.010um
paint via2
box 55.640um -8.310um 56.040um -7.910um
paint metal3
box 55.640um -8.310um 56.040um -7.910um
paint metal3
box 55.740um -8.210um 55.940um -8.010um
paint via3
box 55.640um -8.310um 56.040um -7.910um
paint metal4
box 45.290um -8.210um 55.940um -8.010um
paint metal4
box 45.190um -8.310um 45.590um -7.910um
paint metal3
box 45.290um -8.210um 45.490um -8.010um
paint via3
box 45.190um -8.310um 45.590um -7.910um
paint metal4
box 45.290um -22.500um 45.490um -8.010um
paint metal3
box 45.190um -22.600um 45.590um -22.200um
paint metal3
box 45.290um -22.500um 45.490um -22.300um
paint via3
box 45.190um -22.600um 45.590um -22.200um
paint metal4
box 56.035um -7.450um 56.275um -7.210um
paint metal1
box 55.955um -7.530um 56.355um -7.130um
paint metal1
box 56.055um -7.430um 56.255um -7.230um
paint via1
box 55.955um -7.530um 56.355um -7.130um
paint metal2
box 43.655um -7.430um 56.255um -7.230um
paint metal2
box 43.555um -7.530um 43.955um -7.130um
paint metal2
box 43.655um -7.430um 43.855um -7.230um
paint via2
box 43.555um -7.530um 43.955um -7.130um
paint metal3
box 43.655um -22.500um 43.855um -7.230um
paint metal3
box 43.555um -22.600um 43.955um -22.200um
paint metal3
box 43.655um -22.500um 43.855um -22.300um
paint via3
box 43.555um -22.600um 43.955um -22.200um
paint metal4
box 55.410um -13.420um 55.650um -13.180um
paint metal1
box 55.330um -13.500um 55.730um -13.100um
paint metal1
box 55.430um -13.400um 55.630um -13.200um
paint via1
box 55.330um -13.500um 55.730um -13.100um
paint metal2
box 55.330um -13.500um 55.730um -13.100um
paint metal2
box 55.430um -13.400um 55.630um -13.200um
paint via2
box 55.330um -13.500um 55.730um -13.100um
paint metal3
box 55.330um -13.500um 55.730um -13.100um
paint metal3
box 55.430um -13.400um 55.630um -13.200um
paint via3
box 55.330um -13.500um 55.730um -13.100um
paint metal4
box 43.030um -13.400um 55.630um -13.200um
paint metal4
box 42.930um -13.500um 43.330um -13.100um
paint metal3
box 43.030um -13.400um 43.230um -13.200um
paint via3
box 42.930um -13.500um 43.330um -13.100um
paint metal4
box 43.030um -22.500um 43.230um -13.200um
paint metal3
box 42.930um -22.600um 43.330um -22.200um
paint metal3
box 43.030um -22.500um 43.230um -22.300um
paint via3
box 42.930um -22.600um 43.330um -22.200um
paint metal4
box 43.030um -22.500um 72.605um -22.300um
paint metal4
# net net13  trunk=-23.100
box 60.950um -10.830um 61.190um -10.590um
paint metal1
box 60.870um -10.910um 61.270um -10.510um
paint metal1
box 60.970um -10.810um 61.170um -10.610um
paint via1
box 60.870um -10.910um 61.270um -10.510um
paint metal2
box 60.870um -10.910um 61.270um -10.510um
paint metal2
box 60.970um -10.810um 61.170um -10.610um
paint via2
box 60.870um -10.910um 61.270um -10.510um
paint metal3
box 60.870um -10.910um 61.270um -10.510um
paint metal3
box 60.970um -10.810um 61.170um -10.610um
paint via3
box 60.870um -10.910um 61.270um -10.510um
paint metal4
box 60.970um -11.510um 61.170um -10.610um
paint metal4
box 60.970um -11.510um 73.570um -11.310um
paint metal4
box 73.270um -11.610um 73.670um -11.210um
paint metal3
box 73.370um -11.510um 73.570um -11.310um
paint via3
box 73.270um -11.610um 73.670um -11.210um
paint metal4
box 73.370um -23.200um 73.570um -11.310um
paint metal3
box 73.270um -23.300um 73.670um -22.900um
paint metal3
box 73.370um -23.200um 73.570um -23.000um
paint via3
box 73.270um -23.300um 73.670um -22.900um
paint metal4
box 60.320um -8.230um 60.560um -7.990um
paint metal1
box 60.240um -8.310um 60.640um -7.910um
paint metal1
box 60.340um -8.210um 60.540um -8.010um
paint via1
box 60.240um -8.310um 60.640um -7.910um
paint metal2
box 60.240um -8.310um 60.640um -7.910um
paint metal2
box 60.340um -8.210um 60.540um -8.010um
paint via2
box 60.240um -8.310um 60.640um -7.910um
paint metal3
box 60.240um -8.310um 60.640um -7.910um
paint metal3
box 60.340um -8.210um 60.540um -8.010um
paint via3
box 60.240um -8.310um 60.640um -7.910um
paint metal4
box 60.340um -8.910um 60.540um -8.010um
paint metal4
box 60.340um -8.910um 74.240um -8.710um
paint metal4
box 73.940um -9.010um 74.340um -8.610um
paint metal3
box 74.040um -8.910um 74.240um -8.710um
paint via3
box 73.940um -9.010um 74.340um -8.610um
paint metal4
box 74.040um -23.200um 74.240um -8.710um
paint metal3
box 73.940um -23.300um 74.340um -22.900um
paint metal3
box 74.040um -23.200um 74.240um -23.000um
paint via3
box 73.940um -23.300um 74.340um -22.900um
paint metal4
box 73.370um -23.200um 74.240um -23.000um
paint metal4
# net net14  trunk=-23.800
box 58.650um -10.830um 58.890um -10.590um
paint metal1
box 58.570um -10.910um 58.970um -10.510um
paint metal1
box 58.670um -10.810um 58.870um -10.610um
paint via1
box 58.570um -10.910um 58.970um -10.510um
paint metal2
box 58.570um -10.910um 58.970um -10.510um
paint metal2
box 58.670um -10.810um 58.870um -10.610um
paint via2
box 58.570um -10.910um 58.970um -10.510um
paint metal3
box 58.570um -10.910um 58.970um -10.510um
paint metal3
box 58.670um -10.810um 58.870um -10.610um
paint via3
box 58.570um -10.910um 58.970um -10.510um
paint metal4
box 42.370um -10.810um 58.870um -10.610um
paint metal4
box 42.270um -10.910um 42.670um -10.510um
paint metal3
box 42.370um -10.810um 42.570um -10.610um
paint via3
box 42.270um -10.910um 42.670um -10.510um
paint metal4
box 42.370um -23.900um 42.570um -10.610um
paint metal3
box 42.270um -24.000um 42.670um -23.600um
paint metal3
box 42.370um -23.900um 42.570um -23.700um
paint via3
box 42.270um -24.000um 42.670um -23.600um
paint metal4
box 58.020um -8.230um 58.260um -7.990um
paint metal1
box 57.940um -8.310um 58.340um -7.910um
paint metal1
box 58.040um -8.210um 58.240um -8.010um
paint via1
box 57.940um -8.310um 58.340um -7.910um
paint metal2
box 57.940um -8.310um 58.340um -7.910um
paint metal2
box 58.040um -8.210um 58.240um -8.010um
paint via2
box 57.940um -8.310um 58.340um -7.910um
paint metal3
box 57.940um -8.310um 58.340um -7.910um
paint metal3
box 58.040um -8.210um 58.240um -8.010um
paint via3
box 57.940um -8.310um 58.340um -7.910um
paint metal4
box 58.040um -8.910um 58.240um -8.010um
paint metal4
box 41.740um -8.910um 58.240um -8.710um
paint metal4
box 41.640um -9.010um 42.040um -8.610um
paint metal3
box 41.740um -8.910um 41.940um -8.710um
paint via3
box 41.640um -9.010um 42.040um -8.610um
paint metal4
box 41.740um -23.900um 41.940um -8.710um
paint metal3
box 41.640um -24.000um 42.040um -23.600um
paint metal3
box 41.740um -23.900um 41.940um -23.700um
paint via3
box 41.640um -24.000um 42.040um -23.600um
paint metal4
box 41.740um -23.900um 42.570um -23.700um
paint metal4
# net net5  trunk=-24.500
box 62.940um -13.420um 63.180um -13.180um
paint metal1
box 62.860um -13.500um 63.260um -13.100um
paint metal1
box 62.960um -13.400um 63.160um -13.200um
paint via1
box 62.860um -13.500um 63.260um -13.100um
paint metal2
box 62.860um -13.500um 63.260um -13.100um
paint metal2
box 62.960um -13.400um 63.160um -13.200um
paint via2
box 62.860um -13.500um 63.260um -13.100um
paint metal3
box 62.860um -13.500um 63.260um -13.100um
paint metal3
box 62.960um -13.400um 63.160um -13.200um
paint via3
box 62.860um -13.500um 63.260um -13.100um
paint metal4
box 62.960um -13.400um 63.160um -12.500um
paint metal4
box 62.960um -12.700um 74.910um -12.500um
paint metal4
box 74.610um -12.800um 75.010um -12.400um
paint metal3
box 74.710um -12.700um 74.910um -12.500um
paint via3
box 74.610um -12.800um 75.010um -12.400um
paint metal4
box 74.710um -24.600um 74.910um -12.500um
paint metal3
box 74.610um -24.700um 75.010um -24.300um
paint metal3
box 74.710um -24.600um 74.910um -24.400um
paint via3
box 74.610um -24.700um 75.010um -24.300um
paint metal4
box 62.310um -15.620um 62.550um -15.380um
paint metal1
box 62.230um -15.700um 62.630um -15.300um
paint metal1
box 62.330um -15.600um 62.530um -15.400um
paint via1
box 62.230um -15.700um 62.630um -15.300um
paint metal2
box 62.230um -15.700um 62.630um -15.300um
paint metal2
box 62.330um -15.600um 62.530um -15.400um
paint via2
box 62.230um -15.700um 62.630um -15.300um
paint metal3
box 62.230um -15.700um 62.630um -15.300um
paint metal3
box 62.330um -15.600um 62.530um -15.400um
paint via3
box 62.230um -15.700um 62.630um -15.300um
paint metal4
box 62.330um -16.300um 62.530um -15.400um
paint metal4
box 62.330um -16.300um 75.580um -16.100um
paint metal4
box 75.280um -16.400um 75.680um -16.000um
paint metal3
box 75.380um -16.300um 75.580um -16.100um
paint via3
box 75.280um -16.400um 75.680um -16.000um
paint metal4
box 75.380um -24.600um 75.580um -16.100um
paint metal3
box 75.280um -24.700um 75.680um -24.300um
paint metal3
box 75.380um -24.600um 75.580um -24.400um
paint via3
box 75.280um -24.700um 75.680um -24.300um
paint metal4
box 74.710um -24.600um 75.580um -24.400um
paint metal4
# net net6  trunk=-25.200
box 62.620um -10.830um 62.860um -10.590um
paint metal1
box 62.540um -10.910um 62.940um -10.510um
paint metal1
box 62.640um -10.810um 62.840um -10.610um
paint via1
box 62.540um -10.910um 62.940um -10.510um
paint metal2
box 62.640um -10.810um 62.840um -9.910um
paint metal2
box 62.640um -10.110um 76.540um -9.910um
paint metal2
box 76.240um -10.210um 76.640um -9.810um
paint metal2
box 76.340um -10.110um 76.540um -9.910um
paint via2
box 76.240um -10.210um 76.640um -9.810um
paint metal3
box 76.340um -25.300um 76.540um -9.910um
paint metal3
box 76.240um -25.400um 76.640um -25.000um
paint metal3
box 76.340um -25.300um 76.540um -25.100um
paint via3
box 76.240um -25.400um 76.640um -25.000um
paint metal4
box 62.310um -13.420um 62.550um -13.180um
paint metal1
box 62.230um -13.500um 62.630um -13.100um
paint metal1
box 62.330um -13.400um 62.530um -13.200um
paint via1
box 62.230um -13.500um 62.630um -13.100um
paint metal2
box 62.230um -13.500um 62.630um -13.100um
paint metal2
box 62.330um -13.400um 62.530um -13.200um
paint via2
box 62.230um -13.500um 62.630um -13.100um
paint metal3
box 62.230um -13.500um 62.630um -13.100um
paint metal3
box 62.330um -13.400um 62.530um -13.200um
paint via3
box 62.230um -13.500um 62.630um -13.100um
paint metal4
box 62.330um -14.100um 62.530um -13.200um
paint metal4
box 62.330um -14.100um 77.530um -13.900um
paint metal4
box 77.230um -14.200um 77.630um -13.800um
paint metal3
box 77.330um -14.100um 77.530um -13.900um
paint via3
box 77.230um -14.200um 77.630um -13.800um
paint metal4
box 77.330um -25.300um 77.530um -13.900um
paint metal3
box 77.230um -25.400um 77.630um -25.000um
paint metal3
box 77.330um -25.300um 77.530um -25.100um
paint via3
box 77.230um -25.400um 77.630um -25.000um
paint metal4
box 58.335um -10.050um 58.575um -9.810um
paint metal1
box 58.255um -10.130um 58.655um -9.730um
paint metal1
box 58.355um -10.030um 58.555um -9.830um
paint via1
box 58.255um -10.130um 58.655um -9.730um
paint metal2
box 58.255um -10.130um 58.655um -9.730um
paint metal2
box 58.355um -10.030um 58.555um -9.830um
paint via2
box 58.255um -10.130um 58.655um -9.730um
paint metal3
box 58.255um -10.130um 58.655um -9.730um
paint metal3
box 58.355um -10.030um 58.555um -9.830um
paint via3
box 58.255um -10.130um 58.655um -9.730um
paint metal4
box 40.755um -10.030um 58.555um -9.830um
paint metal4
box 40.655um -10.130um 41.055um -9.730um
paint metal3
box 40.755um -10.030um 40.955um -9.830um
paint via3
box 40.655um -10.130um 41.055um -9.730um
paint metal4
box 40.755um -25.300um 40.955um -9.830um
paint metal3
box 40.655um -25.400um 41.055um -25.000um
paint metal3
box 40.755um -25.300um 40.955um -25.100um
paint via3
box 40.655um -25.400um 41.055um -25.000um
paint metal4
box 58.025um -12.830um 58.265um -12.590um
paint metal1
box 57.945um -12.910um 58.345um -12.510um
paint metal1
box 58.045um -12.810um 58.245um -12.610um
paint via1
box 57.945um -12.910um 58.345um -12.510um
paint metal2
box 57.945um -12.910um 58.345um -12.510um
paint metal2
box 58.045um -12.810um 58.245um -12.610um
paint via2
box 57.945um -12.910um 58.345um -12.510um
paint metal3
box 57.945um -12.910um 58.345um -12.510um
paint metal3
box 58.045um -12.810um 58.245um -12.610um
paint via3
box 57.945um -12.910um 58.345um -12.510um
paint metal4
box 58.045um -12.810um 58.245um -11.210um
paint metal4
box 39.795um -11.410um 58.245um -11.210um
paint metal4
box 39.695um -11.510um 40.095um -11.110um
paint metal3
box 39.795um -11.410um 39.995um -11.210um
paint via3
box 39.695um -11.510um 40.095um -11.110um
paint metal4
box 39.795um -25.300um 39.995um -11.210um
paint metal3
box 39.695um -25.400um 40.095um -25.000um
paint metal3
box 39.795um -25.300um 39.995um -25.100um
paint via3
box 39.695um -25.400um 40.095um -25.000um
paint metal4
box 65.235um -10.050um 65.475um -9.810um
paint metal1
box 65.155um -10.130um 65.555um -9.730um
paint metal1
box 65.255um -10.030um 65.455um -9.830um
paint via1
box 65.155um -10.130um 65.555um -9.730um
paint metal2
box 65.155um -10.130um 65.555um -9.730um
paint metal2
box 65.255um -10.030um 65.455um -9.830um
paint via2
box 65.155um -10.130um 65.555um -9.730um
paint metal3
box 65.155um -10.130um 65.555um -9.730um
paint metal3
box 65.255um -10.030um 65.455um -9.830um
paint via3
box 65.155um -10.130um 65.555um -9.730um
paint metal4
box 65.155um -10.130um 65.555um -9.730um
paint metal4
box 65.255um -10.030um 65.455um -9.830um
paint via4
box 65.155um -10.130um 65.555um -9.730um
paint metal5
box 65.255um -11.430um 65.455um -9.830um
paint metal5
box 65.255um -11.430um 78.505um -11.230um
paint metal5
box 78.205um -11.530um 78.605um -11.130um
paint metal4
box 78.305um -11.430um 78.505um -11.230um
paint via4
box 78.205um -11.530um 78.605um -11.130um
paint metal5
box 78.205um -11.530um 78.605um -11.130um
paint metal3
box 78.305um -11.430um 78.505um -11.230um
paint via3
box 78.205um -11.530um 78.605um -11.130um
paint metal4
box 78.305um -25.300um 78.505um -11.230um
paint metal3
box 78.205um -25.400um 78.605um -25.000um
paint metal3
box 78.305um -25.300um 78.505um -25.100um
paint via3
box 78.205um -25.400um 78.605um -25.000um
paint metal4
box 64.925um -12.830um 65.165um -12.590um
paint metal1
box 64.845um -12.910um 65.245um -12.510um
paint metal1
box 64.945um -12.810um 65.145um -12.610um
paint via1
box 64.845um -12.910um 65.245um -12.510um
paint metal2
box 64.945um -12.810um 79.495um -12.610um
paint metal2
box 79.195um -12.910um 79.595um -12.510um
paint metal2
box 79.295um -12.810um 79.495um -12.610um
paint via2
box 79.195um -12.910um 79.595um -12.510um
paint metal3
box 79.295um -25.300um 79.495um -12.610um
paint metal3
box 79.195um -25.400um 79.595um -25.000um
paint metal3
box 79.295um -25.300um 79.495um -25.100um
paint via3
box 79.195um -25.400um 79.595um -25.000um
paint metal4
box 39.795um -25.300um 79.495um -25.100um
paint metal4
# net net7  trunk=-25.900
box 60.320um -10.830um 60.560um -10.590um
paint metal1
box 60.240um -10.910um 60.640um -10.510um
paint metal1
box 60.340um -10.810um 60.540um -10.610um
paint via1
box 60.240um -10.910um 60.640um -10.510um
paint metal2
box 60.340um -11.510um 60.540um -10.610um
paint metal2
box 60.340um -11.510um 80.090um -11.310um
paint metal2
box 79.790um -11.610um 80.190um -11.210um
paint metal2
box 79.890um -11.510um 80.090um -11.310um
paint via2
box 79.790um -11.610um 80.190um -11.210um
paint metal3
box 79.890um -26.000um 80.090um -11.310um
paint metal3
box 79.790um -26.100um 80.190um -25.700um
paint metal3
box 79.890um -26.000um 80.090um -25.800um
paint via3
box 79.790um -26.100um 80.190um -25.700um
paint metal4
box 60.010um -13.420um 60.250um -13.180um
paint metal1
box 59.930um -13.500um 60.330um -13.100um
paint metal1
box 60.030um -13.400um 60.230um -13.200um
paint via1
box 59.930um -13.500um 60.330um -13.100um
paint metal2
box 60.030um -14.100um 60.230um -13.200um
paint metal2
box 60.030um -14.100um 81.080um -13.900um
paint metal2
box 80.780um -14.200um 81.180um -13.800um
paint metal2
box 80.880um -14.100um 81.080um -13.900um
paint via2
box 80.780um -14.200um 81.180um -13.800um
paint metal3
box 80.880um -26.000um 81.080um -13.900um
paint metal3
box 80.780um -26.100um 81.180um -25.700um
paint metal3
box 80.880um -26.000um 81.080um -25.800um
paint via3
box 80.780um -26.100um 81.180um -25.700um
paint metal4
box 62.935um -10.050um 63.175um -9.810um
paint metal1
box 62.855um -10.130um 63.255um -9.730um
paint metal1
box 62.955um -10.030um 63.155um -9.830um
paint via1
box 62.855um -10.130um 63.255um -9.730um
paint metal2
box 62.855um -10.130um 63.255um -9.730um
paint metal2
box 62.955um -10.030um 63.155um -9.830um
paint via2
box 62.855um -10.130um 63.255um -9.730um
paint metal3
box 62.855um -10.130um 63.255um -9.730um
paint metal3
box 62.955um -10.030um 63.155um -9.830um
paint via3
box 62.855um -10.130um 63.255um -9.730um
paint metal4
box 62.855um -10.130um 63.255um -9.730um
paint metal4
box 62.955um -10.030um 63.155um -9.830um
paint via4
box 62.855um -10.130um 63.255um -9.730um
paint metal5
box 62.955um -12.130um 63.155um -9.830um
paint metal5
box 62.955um -12.130um 82.055um -11.930um
paint metal5
box 81.755um -12.230um 82.155um -11.830um
paint metal4
box 81.855um -12.130um 82.055um -11.930um
paint via4
box 81.755um -12.230um 82.155um -11.830um
paint metal5
box 81.755um -12.230um 82.155um -11.830um
paint metal3
box 81.855um -12.130um 82.055um -11.930um
paint via3
box 81.755um -12.230um 82.155um -11.830um
paint metal4
box 81.855um -26.000um 82.055um -11.930um
paint metal3
box 81.755um -26.100um 82.155um -25.700um
paint metal3
box 81.855um -26.000um 82.055um -25.800um
paint via3
box 81.755um -26.100um 82.155um -25.700um
paint metal4
box 62.625um -12.830um 62.865um -12.590um
paint metal1
box 62.545um -12.910um 62.945um -12.510um
paint metal1
box 62.645um -12.810um 62.845um -12.610um
paint via1
box 62.545um -12.910um 62.945um -12.510um
paint metal2
box 62.645um -12.810um 62.845um -11.910um
paint metal2
box 62.645um -12.110um 83.045um -11.910um
paint metal2
box 82.745um -12.210um 83.145um -11.810um
paint metal2
box 82.845um -12.110um 83.045um -11.910um
paint via2
box 82.745um -12.210um 83.145um -11.810um
paint metal3
box 82.845um -26.000um 83.045um -11.910um
paint metal3
box 82.745um -26.100um 83.145um -25.700um
paint metal3
box 82.845um -26.000um 83.045um -25.800um
paint via3
box 82.745um -26.100um 83.145um -25.700um
paint metal4
box 79.890um -26.000um 83.045um -25.800um
paint metal4
# net net8  trunk=-26.600
box 60.640um -13.420um 60.880um -13.180um
paint metal1
box 60.560um -13.500um 60.960um -13.100um
paint metal1
box 60.660um -13.400um 60.860um -13.200um
paint via1
box 60.560um -13.500um 60.960um -13.100um
paint metal2
box 60.560um -13.500um 60.960um -13.100um
paint metal2
box 60.660um -13.400um 60.860um -13.200um
paint via2
box 60.560um -13.500um 60.960um -13.100um
paint metal3
box 60.560um -13.500um 60.960um -13.100um
paint metal3
box 60.660um -13.400um 60.860um -13.200um
paint via3
box 60.560um -13.500um 60.960um -13.100um
paint metal4
box 60.560um -13.500um 60.960um -13.100um
paint metal4
box 60.660um -13.400um 60.860um -13.200um
paint via4
box 60.560um -13.500um 60.960um -13.100um
paint metal5
box 60.660um -13.400um 60.860um -12.500um
paint metal5
box 60.660um -12.700um 83.660um -12.500um
paint metal5
box 83.360um -12.800um 83.760um -12.400um
paint metal4
box 83.460um -12.700um 83.660um -12.500um
paint via4
box 83.360um -12.800um 83.760um -12.400um
paint metal5
box 83.360um -12.800um 83.760um -12.400um
paint metal3
box 83.460um -12.700um 83.660um -12.500um
paint via3
box 83.360um -12.800um 83.760um -12.400um
paint metal4
box 83.460um -26.700um 83.660um -12.500um
paint metal3
box 83.360um -26.800um 83.760um -26.400um
paint metal3
box 83.460um -26.700um 83.660um -26.500um
paint via3
box 83.360um -26.800um 83.760um -26.400um
paint metal4
box 60.010um -15.620um 60.250um -15.380um
paint metal1
box 59.930um -15.700um 60.330um -15.300um
paint metal1
box 60.030um -15.600um 60.230um -15.400um
paint via1
box 59.930um -15.700um 60.330um -15.300um
paint metal2
box 59.930um -15.700um 60.330um -15.300um
paint metal2
box 60.030um -15.600um 60.230um -15.400um
paint via2
box 59.930um -15.700um 60.330um -15.300um
paint metal3
box 59.930um -15.700um 60.330um -15.300um
paint metal3
box 60.030um -15.600um 60.230um -15.400um
paint via3
box 59.930um -15.700um 60.330um -15.300um
paint metal4
box 60.030um -17.000um 60.230um -15.400um
paint metal4
box 60.030um -17.000um 84.330um -16.800um
paint metal4
box 84.030um -17.100um 84.430um -16.700um
paint metal3
box 84.130um -17.000um 84.330um -16.800um
paint via3
box 84.030um -17.100um 84.430um -16.700um
paint metal4
box 84.130um -26.700um 84.330um -16.800um
paint metal3
box 84.030um -26.800um 84.430um -26.400um
paint metal3
box 84.130um -26.700um 84.330um -26.500um
paint via3
box 84.030um -26.800um 84.430um -26.400um
paint metal4
box 83.460um -26.700um 84.330um -26.500um
paint metal4
# net net9  trunk=-27.300
box 58.020um -10.830um 58.260um -10.590um
paint metal1
box 57.940um -10.910um 58.340um -10.510um
paint metal1
box 58.040um -10.810um 58.240um -10.610um
paint via1
box 57.940um -10.910um 58.340um -10.510um
paint metal2
box 31.340um -10.810um 58.240um -10.610um
paint metal2
box 31.240um -10.910um 31.640um -10.510um
paint metal2
box 31.340um -10.810um 31.540um -10.610um
paint via2
box 31.240um -10.910um 31.640um -10.510um
paint metal3
box 31.340um -27.400um 31.540um -10.610um
paint metal3
box 31.240um -27.500um 31.640um -27.100um
paint metal3
box 31.340um -27.400um 31.540um -27.200um
paint via3
box 31.240um -27.500um 31.640um -27.100um
paint metal4
box 57.710um -13.420um 57.950um -13.180um
paint metal1
box 57.630um -13.500um 58.030um -13.100um
paint metal1
box 57.730um -13.400um 57.930um -13.200um
paint via1
box 57.630um -13.500um 58.030um -13.100um
paint metal2
box 57.630um -13.500um 58.030um -13.100um
paint metal2
box 57.730um -13.400um 57.930um -13.200um
paint via2
box 57.630um -13.500um 58.030um -13.100um
paint metal3
box 57.630um -13.500um 58.030um -13.100um
paint metal3
box 57.730um -13.400um 57.930um -13.200um
paint via3
box 57.630um -13.500um 58.030um -13.100um
paint metal4
box 57.730um -14.100um 57.930um -13.200um
paint metal4
box 30.380um -14.100um 57.930um -13.900um
paint metal4
box 30.280um -14.200um 30.680um -13.800um
paint metal3
box 30.380um -14.100um 30.580um -13.900um
paint via3
box 30.280um -14.200um 30.680um -13.800um
paint metal4
box 30.380um -27.400um 30.580um -13.900um
paint metal3
box 30.280um -27.500um 30.680um -27.100um
paint metal3
box 30.380um -27.400um 30.580um -27.200um
paint via3
box 30.280um -27.500um 30.680um -27.100um
paint metal4
box 60.635um -10.050um 60.875um -9.810um
paint metal1
box 60.555um -10.130um 60.955um -9.730um
paint metal1
box 60.655um -10.030um 60.855um -9.830um
paint via1
box 60.555um -10.130um 60.955um -9.730um
paint metal2
box 60.655um -10.030um 60.855um -9.130um
paint metal2
box 60.655um -9.330um 84.955um -9.130um
paint metal2
box 84.655um -9.430um 85.055um -9.030um
paint metal2
box 84.755um -9.330um 84.955um -9.130um
paint via2
box 84.655um -9.430um 85.055um -9.030um
paint metal3
box 84.755um -27.400um 84.955um -9.130um
paint metal3
box 84.655um -27.500um 85.055um -27.100um
paint metal3
box 84.755um -27.400um 84.955um -27.200um
paint via3
box 84.655um -27.500um 85.055um -27.100um
paint metal4
box 60.325um -12.830um 60.565um -12.590um
paint metal1
box 60.245um -12.910um 60.645um -12.510um
paint metal1
box 60.345um -12.810um 60.545um -12.610um
paint via1
box 60.245um -12.910um 60.645um -12.510um
paint metal2
box 60.245um -12.910um 60.645um -12.510um
paint metal2
box 60.345um -12.810um 60.545um -12.610um
paint via2
box 60.245um -12.910um 60.645um -12.510um
paint metal3
box 60.245um -12.910um 60.645um -12.510um
paint metal3
box 60.345um -12.810um 60.545um -12.610um
paint via3
box 60.245um -12.910um 60.645um -12.510um
paint metal4
box 60.345um -12.810um 60.545um -11.910um
paint metal4
box 60.345um -12.110um 85.945um -11.910um
paint metal4
box 85.645um -12.210um 86.045um -11.810um
paint metal3
box 85.745um -12.110um 85.945um -11.910um
paint via3
box 85.645um -12.210um 86.045um -11.810um
paint metal4
box 85.745um -27.400um 85.945um -11.910um
paint metal3
box 85.645um -27.500um 86.045um -27.100um
paint metal3
box 85.745um -27.400um 85.945um -27.200um
paint via3
box 85.645um -27.500um 86.045um -27.100um
paint metal4
box 30.380um -27.400um 85.945um -27.200um
paint metal4
# net out  trunk=-28.000
box -5.500um 12.100um 95.000um 12.900um
paint metal5
box -5.500um -19.400um 95.000um -18.600um
paint metal5
# VPWR
box 6.600um 8.740um 6.840um 8.980um
paint metal1
box 6.520um 8.660um 6.920um 9.060um
paint metal1
box 6.620um 8.760um 6.820um 8.960um
paint via1
box 6.520um 8.660um 6.920um 9.060um
paint metal2
box 6.620um 8.760um 7.820um 8.960um
paint metal2
box 7.520um 8.660um 7.920um 9.060um
paint metal2
box 7.620um 8.760um 7.820um 8.960um
paint via2
box 7.520um 8.660um 7.920um 9.060um
paint metal3
box 7.520um 8.660um 7.920um 9.060um
paint metal3
box 7.620um 8.760um 7.820um 8.960um
paint via3
box 7.520um 8.660um 7.920um 9.060um
paint metal4
box 7.520um 8.660um 7.920um 9.060um
paint metal4
box 7.620um 8.760um 7.820um 8.960um
paint via4
box 7.520um 8.660um 7.920um 9.060um
paint metal5
box 7.620um 8.760um 7.820um 12.600um
paint metal5
box 6.600um 3.940um 6.840um 4.180um
paint metal1
box 6.520um 3.860um 6.920um 4.260um
paint metal1
box 6.620um 3.960um 6.820um 4.160um
paint via1
box 6.520um 3.860um 6.920um 4.260um
paint metal2
box 6.620um 3.960um 8.670um 4.160um
paint metal2
box 8.370um 3.860um 8.770um 4.260um
paint metal2
box 8.470um 3.960um 8.670um 4.160um
paint via2
box 8.370um 3.860um 8.770um 4.260um
paint metal3
box 8.370um 3.860um 8.770um 4.260um
paint metal3
box 8.470um 3.960um 8.670um 4.160um
paint via3
box 8.370um 3.860um 8.770um 4.260um
paint metal4
box 8.370um 3.860um 8.770um 4.260um
paint metal4
box 8.470um 3.960um 8.670um 4.160um
paint via4
box 8.370um 3.860um 8.770um 4.260um
paint metal5
box 8.470um 3.960um 8.670um 12.600um
paint metal5
box 15.120um 2.670um 15.360um 2.910um
paint metal1
box 15.040um 2.590um 15.440um 2.990um
paint metal1
box 15.140um 2.690um 15.340um 2.890um
paint via1
box 15.040um 2.590um 15.440um 2.990um
paint metal2
box 15.140um 2.690um 16.340um 2.890um
paint metal2
box 16.040um 2.590um 16.440um 2.990um
paint metal2
box 16.140um 2.690um 16.340um 2.890um
paint via2
box 16.040um 2.590um 16.440um 2.990um
paint metal3
box 16.040um 2.590um 16.440um 2.990um
paint metal3
box 16.140um 2.690um 16.340um 2.890um
paint via3
box 16.040um 2.590um 16.440um 2.990um
paint metal4
box 16.040um 2.590um 16.440um 2.990um
paint metal4
box 16.140um 2.690um 16.340um 2.890um
paint via4
box 16.040um 2.590um 16.440um 2.990um
paint metal5
box 16.140um 2.690um 16.340um 12.600um
paint metal5
box 18.150um 6.350um 18.390um 6.590um
paint metal1
box 18.070um 6.270um 18.470um 6.670um
paint metal1
box 18.170um 6.370um 18.370um 6.570um
paint via1
box 18.070um 6.270um 18.470um 6.670um
paint metal2
box 18.170um 6.370um 19.370um 6.570um
paint metal2
box 19.070um 6.270um 19.470um 6.670um
paint metal2
box 19.170um 6.370um 19.370um 6.570um
paint via2
box 19.070um 6.270um 19.470um 6.670um
paint metal3
box 19.070um 6.270um 19.470um 6.670um
paint metal3
box 19.170um 6.370um 19.370um 6.570um
paint via3
box 19.070um 6.270um 19.470um 6.670um
paint metal4
box 19.070um 6.270um 19.470um 6.670um
paint metal4
box 19.170um 6.370um 19.370um 6.570um
paint via4
box 19.070um 6.270um 19.470um 6.670um
paint metal5
box 19.170um 6.370um 19.370um 12.600um
paint metal5
box 0.547um 6.440um 0.787um 6.680um
paint metal1
box 0.468um 6.360um 0.867um 6.760um
paint metal1
box 0.568um 6.460um 0.767um 6.660um
paint via1
box 0.468um 6.360um 0.867um 6.760um
paint metal2
box 0.568um 6.460um 1.768um 6.660um
paint metal2
box 1.467um 6.360um 1.868um 6.760um
paint metal2
box 1.567um 6.460um 1.768um 6.660um
paint via2
box 1.467um 6.360um 1.868um 6.760um
paint metal3
box 1.467um 6.360um 1.868um 6.760um
paint metal3
box 1.567um 6.460um 1.768um 6.660um
paint via3
box 1.467um 6.360um 1.868um 6.760um
paint metal4
box 1.467um 6.360um 1.868um 6.760um
paint metal4
box 1.567um 6.460um 1.768um 6.660um
paint via4
box 1.467um 6.360um 1.868um 6.760um
paint metal5
box 1.567um 6.460um 1.768um 12.600um
paint metal5
box 0.547um 1.640um 0.787um 1.880um
paint metal1
box 0.468um 1.560um 0.867um 1.960um
paint metal1
box 0.568um 1.660um 0.767um 1.860um
paint via1
box 0.468um 1.560um 0.867um 1.960um
paint metal2
box 0.568um 1.660um 2.618um 1.860um
paint metal2
box 2.317um 1.560um 2.718um 1.960um
paint metal2
box 2.417um 1.660um 2.618um 1.860um
paint via2
box 2.317um 1.560um 2.718um 1.960um
paint metal3
box 2.317um 1.560um 2.718um 1.960um
paint metal3
box 2.417um 1.660um 2.618um 1.860um
paint via3
box 2.317um 1.560um 2.718um 1.960um
paint metal4
box 2.317um 1.560um 2.718um 1.960um
paint metal4
box 2.417um 1.660um 2.618um 1.860um
paint via4
box 2.317um 1.560um 2.718um 1.960um
paint metal5
box 2.417um 1.660um 2.618um 12.600um
paint metal5
box 22.290um 7.110um 22.530um 7.350um
paint metal1
box 22.210um 7.030um 22.610um 7.430um
paint metal1
box 22.310um 7.130um 22.510um 7.330um
paint via1
box 22.210um 7.030um 22.610um 7.430um
paint metal2
box 22.310um 7.130um 23.510um 7.330um
paint metal2
box 23.210um 7.030um 23.610um 7.430um
paint metal2
box 23.310um 7.130um 23.510um 7.330um
paint via2
box 23.210um 7.030um 23.610um 7.430um
paint metal3
box 23.210um 7.030um 23.610um 7.430um
paint metal3
box 23.310um 7.130um 23.510um 7.330um
paint via3
box 23.210um 7.030um 23.610um 7.430um
paint metal4
box 23.210um 7.030um 23.610um 7.430um
paint metal4
box 23.310um 7.130um 23.510um 7.330um
paint via4
box 23.210um 7.030um 23.610um 7.430um
paint metal5
box 23.310um 7.130um 23.510um 12.600um
paint metal5
box 21.650um -4.700um 21.890um -4.460um
paint metal1
box 21.570um -4.780um 21.970um -4.380um
paint metal1
box 21.670um -4.680um 21.870um -4.480um
paint via1
box 21.570um -4.780um 21.970um -4.380um
paint metal2
box 21.670um -4.680um 24.570um -4.480um
paint metal2
box 24.270um -4.780um 24.670um -4.380um
paint metal2
box 24.370um -4.680um 24.570um -4.480um
paint via2
box 24.270um -4.780um 24.670um -4.380um
paint metal3
box 24.270um -4.780um 24.670um -4.380um
paint metal3
box 24.370um -4.680um 24.570um -4.480um
paint via3
box 24.270um -4.780um 24.670um -4.380um
paint metal4
box 24.270um -4.780um 24.670um -4.380um
paint metal4
box 24.370um -4.680um 24.570um -4.480um
paint via4
box 24.270um -4.780um 24.670um -4.380um
paint metal5
box 24.370um -4.680um 24.570um 12.600um
paint metal5
box 1.190um -15.350um 1.430um -15.110um
paint metal1
box 1.110um -15.430um 1.510um -15.030um
paint metal1
box 1.210um -15.330um 1.410um -15.130um
paint via1
box 1.110um -15.430um 1.510um -15.030um
paint metal2
box 1.210um -15.330um 4.110um -15.130um
paint metal2
box 3.810um -15.430um 4.210um -15.030um
paint metal2
box 3.910um -15.330um 4.110um -15.130um
paint via2
box 3.810um -15.430um 4.210um -15.030um
paint metal3
box 3.810um -15.430um 4.210um -15.030um
paint metal3
box 3.910um -15.330um 4.110um -15.130um
paint via3
box 3.810um -15.430um 4.210um -15.030um
paint metal4
box 3.810um -15.430um 4.210um -15.030um
paint metal4
box 3.910um -15.330um 4.110um -15.130um
paint via4
box 3.810um -15.430um 4.210um -15.030um
paint metal5
box 3.910um -15.330um 4.110um 12.600um
paint metal5
box 65.550um -10.830um 65.790um -10.590um
paint metal1
box 65.470um -10.910um 65.870um -10.510um
paint metal1
box 65.570um -10.810um 65.770um -10.610um
paint via1
box 65.470um -10.910um 65.870um -10.510um
paint metal2
box 65.570um -10.810um 66.770um -10.610um
paint metal2
box 66.470um -10.910um 66.870um -10.510um
paint metal2
box 66.570um -10.810um 66.770um -10.610um
paint via2
box 66.470um -10.910um 66.870um -10.510um
paint metal3
box 66.470um -10.910um 66.870um -10.510um
paint metal3
box 66.570um -10.810um 66.770um -10.610um
paint via3
box 66.470um -10.910um 66.870um -10.510um
paint metal4
box 66.470um -10.910um 66.870um -10.510um
paint metal4
box 66.570um -10.810um 66.770um -10.610um
paint via4
box 66.470um -10.910um 66.870um -10.510um
paint metal5
box 66.570um -10.810um 66.770um 12.600um
paint metal5
box 63.250um -8.230um 63.490um -7.990um
paint metal1
box 63.170um -8.310um 63.570um -7.910um
paint metal1
box 63.270um -8.210um 63.470um -8.010um
paint via1
box 63.170um -8.310um 63.570um -7.910um
paint metal2
box 63.270um -8.210um 64.470um -8.010um
paint metal2
box 64.170um -8.310um 64.570um -7.910um
paint metal2
box 64.270um -8.210um 64.470um -8.010um
paint via2
box 64.170um -8.310um 64.570um -7.910um
paint metal3
box 64.170um -8.310um 64.570um -7.910um
paint metal3
box 64.270um -8.210um 64.470um -8.010um
paint via3
box 64.170um -8.310um 64.570um -7.910um
paint metal4
box 64.170um -8.310um 64.570um -7.910um
paint metal4
box 64.270um -8.210um 64.470um -8.010um
paint via4
box 64.170um -8.310um 64.570um -7.910um
paint metal5
box 64.270um -8.210um 64.470um 12.600um
paint metal5
box 60.950um -8.230um 61.190um -7.990um
paint metal1
box 60.870um -8.310um 61.270um -7.910um
paint metal1
box 60.970um -8.210um 61.170um -8.010um
paint via1
box 60.870um -8.310um 61.270um -7.910um
paint metal2
box 60.970um -8.210um 62.170um -8.010um
paint metal2
box 61.870um -8.310um 62.270um -7.910um
paint metal2
box 61.970um -8.210um 62.170um -8.010um
paint via2
box 61.870um -8.310um 62.270um -7.910um
paint metal3
box 61.870um -8.310um 62.270um -7.910um
paint metal3
box 61.970um -8.210um 62.170um -8.010um
paint via3
box 61.870um -8.310um 62.270um -7.910um
paint metal4
box 61.870um -8.310um 62.270um -7.910um
paint metal4
box 61.970um -8.210um 62.170um -8.010um
paint via4
box 61.870um -8.310um 62.270um -7.910um
paint metal5
box 61.970um -8.210um 62.170um 12.600um
paint metal5
box 58.650um -8.230um 58.890um -7.990um
paint metal1
box 58.570um -8.310um 58.970um -7.910um
paint metal1
box 58.670um -8.210um 58.870um -8.010um
paint via1
box 58.570um -8.310um 58.970um -7.910um
paint metal2
box 58.670um -8.210um 59.870um -8.010um
paint metal2
box 59.570um -8.310um 59.970um -7.910um
paint metal2
box 59.670um -8.210um 59.870um -8.010um
paint via2
box 59.570um -8.310um 59.970um -7.910um
paint metal3
box 59.570um -8.310um 59.970um -7.910um
paint metal3
box 59.670um -8.210um 59.870um -8.010um
paint via3
box 59.570um -8.310um 59.970um -7.910um
paint metal4
box 59.570um -8.310um 59.970um -7.910um
paint metal4
box 59.670um -8.210um 59.870um -8.010um
paint via4
box 59.570um -8.310um 59.970um -7.910um
paint metal5
box 59.670um -8.210um 59.870um 12.600um
paint metal5
box 56.350um -8.230um 56.590um -7.990um
paint metal1
box 56.270um -8.310um 56.670um -7.910um
paint metal1
box 56.370um -8.210um 56.570um -8.010um
paint via1
box 56.270um -8.310um 56.670um -7.910um
paint metal2
box 56.370um -8.210um 57.570um -8.010um
paint metal2
box 57.270um -8.310um 57.670um -7.910um
paint metal2
box 57.370um -8.210um 57.570um -8.010um
paint via2
box 57.270um -8.310um 57.670um -7.910um
paint metal3
box 57.270um -8.310um 57.670um -7.910um
paint metal3
box 57.370um -8.210um 57.570um -8.010um
paint via3
box 57.270um -8.310um 57.670um -7.910um
paint metal4
box 57.270um -8.310um 57.670um -7.910um
paint metal4
box 57.370um -8.210um 57.570um -8.010um
paint via4
box 57.270um -8.310um 57.670um -7.910um
paint metal5
box 57.370um -8.210um 57.570um 12.600um
paint metal5
# VGND
box 6.600um 4.960um 6.840um 5.200um
paint metal1
box 6.520um 4.880um 6.920um 5.280um
paint metal1
box 6.620um 4.980um 6.820um 5.180um
paint via1
box 6.520um 4.880um 6.920um 5.280um
paint metal2
box 6.620um 4.980um 9.520um 5.180um
paint metal2
box 9.220um 4.880um 9.620um 5.280um
paint metal2
box 9.320um 4.980um 9.520um 5.180um
paint via2
box 9.220um 4.880um 9.620um 5.280um
paint metal3
box 9.220um 4.880um 9.620um 5.280um
paint metal3
box 9.320um 4.980um 9.520um 5.180um
paint via3
box 9.220um 4.880um 9.620um 5.280um
paint metal4
box 9.220um 4.880um 9.620um 5.280um
paint metal4
box 9.320um 4.980um 9.520um 5.180um
paint via4
box 9.220um 4.880um 9.620um 5.280um
paint metal5
box 9.320um -19.100um 9.520um 5.180um
paint metal5
box 6.600um 0.160um 6.840um 0.400um
paint metal1
box 6.520um 0.080um 6.920um 0.480um
paint metal1
box 6.620um 0.180um 6.820um 0.380um
paint via1
box 6.520um 0.080um 6.920um 0.480um
paint metal2
box 6.620um 0.180um 10.370um 0.380um
paint metal2
box 10.070um 0.080um 10.470um 0.480um
paint metal2
box 10.170um 0.180um 10.370um 0.380um
paint via2
box 10.070um 0.080um 10.470um 0.480um
paint metal3
box 10.070um 0.080um 10.470um 0.480um
paint metal3
box 10.170um 0.180um 10.370um 0.380um
paint via3
box 10.070um 0.080um 10.470um 0.480um
paint metal4
box 10.070um 0.080um 10.470um 0.480um
paint metal4
box 10.170um 0.180um 10.370um 0.380um
paint via4
box 10.070um 0.080um 10.470um 0.480um
paint metal5
box 10.170um -19.100um 10.370um 0.380um
paint metal5
box 15.120um 6.450um 15.360um 6.690um
paint metal1
box 15.040um 6.370um 15.440um 6.770um
paint metal1
box 15.140um 6.470um 15.340um 6.670um
paint via1
box 15.040um 6.370um 15.440um 6.770um
paint metal2
box 15.140um 6.470um 17.190um 6.670um
paint metal2
box 16.890um 6.370um 17.290um 6.770um
paint metal2
box 16.990um 6.470um 17.190um 6.670um
paint via2
box 16.890um 6.370um 17.290um 6.770um
paint metal3
box 16.890um 6.370um 17.290um 6.770um
paint metal3
box 16.990um 6.470um 17.190um 6.670um
paint via3
box 16.890um 6.370um 17.290um 6.770um
paint metal4
box 16.890um 6.370um 17.290um 6.770um
paint metal4
box 16.990um 6.470um 17.190um 6.670um
paint via4
box 16.890um 6.370um 17.290um 6.770um
paint metal5
box 16.990um -19.100um 17.190um 6.670um
paint metal5
box 18.150um 2.570um 18.390um 2.810um
paint metal1
box 18.070um 2.490um 18.470um 2.890um
paint metal1
box 18.170um 2.590um 18.370um 2.790um
paint via1
box 18.070um 2.490um 18.470um 2.890um
paint metal2
box 18.170um 2.590um 20.220um 2.790um
paint metal2
box 19.920um 2.490um 20.320um 2.890um
paint metal2
box 20.020um 2.590um 20.220um 2.790um
paint via2
box 19.920um 2.490um 20.320um 2.890um
paint metal3
box 19.920um 2.490um 20.320um 2.890um
paint metal3
box 20.020um 2.590um 20.220um 2.790um
paint via3
box 19.920um 2.490um 20.320um 2.890um
paint metal4
box 19.920um 2.490um 20.320um 2.890um
paint metal4
box 20.020um 2.590um 20.220um 2.790um
paint via4
box 19.920um 2.490um 20.320um 2.890um
paint metal5
box 20.020um -19.100um 20.220um 2.790um
paint metal5
box 21.970um 2.270um 22.210um 2.510um
paint metal1
box 21.890um 2.190um 22.290um 2.590um
paint metal1
box 21.990um 2.290um 22.190um 2.490um
paint via1
box 21.890um 2.190um 22.290um 2.590um
paint metal2
box 21.990um 2.290um 25.740um 2.490um
paint metal2
box 25.440um 2.190um 25.840um 2.590um
paint metal2
box 25.540um 2.290um 25.740um 2.490um
paint via2
box 25.440um 2.190um 25.840um 2.590um
paint metal3
box 25.440um 2.190um 25.840um 2.590um
paint metal3
box 25.540um 2.290um 25.740um 2.490um
paint via3
box 25.440um 2.190um 25.840um 2.590um
paint metal4
box 25.440um 2.190um 25.840um 2.590um
paint metal4
box 25.540um 2.290um 25.740um 2.490um
paint via4
box 25.440um 2.190um 25.840um 2.590um
paint metal5
box 25.540um -19.100um 25.740um 2.490um
paint metal5
box 22.760um -2.990um 23.000um -2.750um
paint metal1
box 22.680um -3.070um 23.080um -2.670um
paint metal1
box 22.780um -2.970um 22.980um -2.770um
paint via1
box 22.680um -3.070um 23.080um -2.670um
paint metal2
box 22.780um -2.970um 27.380um -2.770um
paint metal2
box 27.080um -3.070um 27.480um -2.670um
paint metal2
box 27.180um -2.970um 27.380um -2.770um
paint via2
box 27.080um -3.070um 27.480um -2.670um
paint metal3
box 27.080um -3.070um 27.480um -2.670um
paint metal3
box 27.180um -2.970um 27.380um -2.770um
paint via3
box 27.080um -3.070um 27.480um -2.670um
paint metal4
box 27.080um -3.070um 27.480um -2.670um
paint metal4
box 27.180um -2.970um 27.380um -2.770um
paint via4
box 27.080um -3.070um 27.480um -2.670um
paint metal5
box 27.180um -19.100um 27.380um -2.770um
paint metal5
box 22.770um -1.440um 23.010um -1.200um
paint metal1
box 22.690um -1.520um 23.090um -1.120um
paint metal1
box 22.790um -1.420um 22.990um -1.220um
paint via1
box 22.690um -1.520um 23.090um -1.120um
paint metal2
box 22.790um -1.420um 28.240um -1.220um
paint metal2
box 27.940um -1.520um 28.340um -1.120um
paint metal2
box 28.040um -1.420um 28.240um -1.220um
paint via2
box 27.940um -1.520um 28.340um -1.120um
paint metal3
box 27.940um -1.520um 28.340um -1.120um
paint metal3
box 28.040um -1.420um 28.240um -1.220um
paint via3
box 27.940um -1.520um 28.340um -1.120um
paint metal4
box 27.940um -1.520um 28.340um -1.120um
paint metal4
box 28.040um -1.420um 28.240um -1.220um
paint via4
box 27.940um -1.520um 28.340um -1.120um
paint metal5
box 28.040um -19.100um 28.240um -1.220um
paint metal5
box 51.200um -5.700um 51.440um -5.460um
paint metal1
box 51.120um -5.780um 51.520um -5.380um
paint metal1
box 51.220um -5.680um 51.420um -5.480um
paint via1
box 51.120um -5.780um 51.520um -5.380um
paint metal2
box 51.220um -5.680um 52.420um -5.480um
paint metal2
box 52.120um -5.780um 52.520um -5.380um
paint metal2
box 52.220um -5.680um 52.420um -5.480um
paint via2
box 52.120um -5.780um 52.520um -5.380um
paint metal3
box 52.120um -5.780um 52.520um -5.380um
paint metal3
box 52.220um -5.680um 52.420um -5.480um
paint via3
box 52.120um -5.780um 52.520um -5.380um
paint metal4
box 52.120um -5.780um 52.520um -5.380um
paint metal4
box 52.220um -5.680um 52.420um -5.480um
paint via4
box 52.120um -5.780um 52.520um -5.380um
paint metal5
box 52.220um -19.100um 52.420um -5.480um
paint metal5
box 10.500um -16.060um 10.740um -15.820um
paint metal1
box 10.420um -16.140um 10.820um -15.740um
paint metal1
box 10.520um -16.040um 10.720um -15.840um
paint via1
box 10.420um -16.140um 10.820um -15.740um
paint metal2
box 10.520um -16.040um 11.720um -15.840um
paint metal2
box 11.420um -16.140um 11.820um -15.740um
paint metal2
box 11.520um -16.040um 11.720um -15.840um
paint via2
box 11.420um -16.140um 11.820um -15.740um
paint metal3
box 11.420um -16.140um 11.820um -15.740um
paint metal3
box 11.520um -16.040um 11.720um -15.840um
paint via3
box 11.420um -16.140um 11.820um -15.740um
paint metal4
box 11.420um -16.140um 11.820um -15.740um
paint metal4
box 11.520um -16.040um 11.720um -15.840um
paint via4
box 11.420um -16.140um 11.820um -15.740um
paint metal5
box 11.520um -19.100um 11.720um -15.840um
paint metal5
box 44.370um -6.160um 44.870um -5.660um
paint metal5
box 44.495um -19.125um 44.745um -5.785um
paint metal5
box 54.200um -12.200um 54.700um -11.700um
paint metal5
box 54.325um -19.125um 54.575um -11.825um
paint metal5
box 65.240um -13.420um 65.480um -13.180um
paint metal1
box 65.160um -13.500um 65.560um -13.100um
paint metal1
box 65.260um -13.400um 65.460um -13.200um
paint via1
box 65.160um -13.500um 65.560um -13.100um
paint metal2
box 65.260um -13.400um 68.160um -13.200um
paint metal2
box 67.860um -13.500um 68.260um -13.100um
paint metal2
box 67.960um -13.400um 68.160um -13.200um
paint via2
box 67.860um -13.500um 68.260um -13.100um
paint metal3
box 67.860um -13.500um 68.260um -13.100um
paint metal3
box 67.960um -13.400um 68.160um -13.200um
paint via3
box 67.860um -13.500um 68.260um -13.100um
paint metal4
box 67.860um -13.500um 68.260um -13.100um
paint metal4
box 67.960um -13.400um 68.160um -13.200um
paint via4
box 67.860um -13.500um 68.260um -13.100um
paint metal5
box 67.960um -19.100um 68.160um -13.200um
paint metal5
box 60.640um -15.620um 60.880um -15.380um
paint metal1
box 60.560um -15.700um 60.960um -15.300um
paint metal1
box 60.660um -15.600um 60.860um -15.400um
paint via1
box 60.560um -15.700um 60.960um -15.300um
paint metal2
box 60.660um -15.600um 63.560um -15.400um
paint metal2
box 63.260um -15.700um 63.660um -15.300um
paint metal2
box 63.360um -15.600um 63.560um -15.400um
paint via2
box 63.260um -15.700um 63.660um -15.300um
paint metal3
box 63.260um -15.700um 63.660um -15.300um
paint metal3
box 63.360um -15.600um 63.560um -15.400um
paint via3
box 63.260um -15.700um 63.660um -15.300um
paint metal4
box 63.260um -15.700um 63.660um -15.300um
paint metal4
box 63.360um -15.600um 63.560um -15.400um
paint via4
box 63.260um -15.700um 63.660um -15.300um
paint metal5
box 63.360um -19.100um 63.560um -15.400um
paint metal5
box 62.940um -15.620um 63.180um -15.380um
paint metal1
box 62.860um -15.700um 63.260um -15.300um
paint metal1
box 62.960um -15.600um 63.160um -15.400um
paint via1
box 62.860um -15.700um 63.260um -15.300um
paint metal2
box 62.960um -15.600um 65.860um -15.400um
paint metal2
box 65.560um -15.700um 65.960um -15.300um
paint metal2
box 65.660um -15.600um 65.860um -15.400um
paint via2
box 65.560um -15.700um 65.960um -15.300um
paint metal3
box 65.560um -15.700um 65.960um -15.300um
paint metal3
box 65.660um -15.600um 65.860um -15.400um
paint via3
box 65.560um -15.700um 65.960um -15.300um
paint metal4
box 65.560um -15.700um 65.960um -15.300um
paint metal4
box 65.660um -15.600um 65.860um -15.400um
paint via4
box 65.560um -15.700um 65.960um -15.300um
paint metal5
box 65.660um -19.100um 65.860um -15.400um
paint metal5
box 58.340um -15.620um 58.580um -15.380um
paint metal1
box 58.260um -15.700um 58.660um -15.300um
paint metal1
box 58.360um -15.600um 58.560um -15.400um
paint via1
box 58.260um -15.700um 58.660um -15.300um
paint metal2
box 58.360um -15.600um 61.260um -15.400um
paint metal2
box 60.960um -15.700um 61.360um -15.300um
paint metal2
box 61.060um -15.600um 61.260um -15.400um
paint via2
box 60.960um -15.700um 61.360um -15.300um
paint metal3
box 60.960um -15.700um 61.360um -15.300um
paint metal3
box 61.060um -15.600um 61.260um -15.400um
paint via3
box 60.960um -15.700um 61.360um -15.300um
paint metal4
box 60.960um -15.700um 61.360um -15.300um
paint metal4
box 61.060um -15.600um 61.260um -15.400um
paint via4
box 60.960um -15.700um 61.360um -15.300um
paint metal5
box 61.060um -19.100um 61.260um -15.400um
paint metal5
box 56.040um -13.420um 56.280um -13.180um
paint metal1
box 55.960um -13.500um 56.360um -13.100um
paint metal1
box 56.060um -13.400um 56.260um -13.200um
paint via1
box 55.960um -13.500um 56.360um -13.100um
paint metal2
box 56.060um -13.400um 58.960um -13.200um
paint metal2
box 58.660um -13.500um 59.060um -13.100um
paint metal2
box 58.760um -13.400um 58.960um -13.200um
paint via2
box 58.660um -13.500um 59.060um -13.100um
paint metal3
box 58.660um -13.500um 59.060um -13.100um
paint metal3
box 58.760um -13.400um 58.960um -13.200um
paint via3
box 58.660um -13.500um 59.060um -13.100um
paint metal4
box 58.660um -13.500um 59.060um -13.100um
paint metal4
box 58.760um -13.400um 58.960um -13.200um
paint via4
box 58.660um -13.500um 59.060um -13.100um
paint metal5
box 58.760um -19.100um 58.960um -13.200um
paint metal5
box 20.380um 12.380um 20.620um 12.620um
paint metal1
box 20.300um 12.300um 20.700um 12.700um
paint metal1
box 20.400um 12.400um 20.600um 12.600um
paint via1
box 20.300um 12.300um 20.700um 12.700um
paint metal2
box 20.400um 12.400um 21.600um 12.600um
paint metal2
box 21.300um 12.300um 21.700um 12.700um
paint metal2
box 21.400um 12.400um 21.600um 12.600um
paint via2
box 21.300um 12.300um 21.700um 12.700um
paint metal3
box 21.300um 12.300um 21.700um 12.700um
paint metal3
box 21.400um 12.400um 21.600um 12.600um
paint via3
box 21.300um 12.300um 21.700um 12.700um
paint metal4
box 21.300um 12.300um 21.700um 12.700um
paint metal4
box 21.400um 12.400um 21.600um 12.600um
paint via4
box 21.300um 12.300um 21.700um 12.700um
paint metal5
box 21.400um 12.400um 21.600um 12.600um
paint metal5
box 20.380um -19.120um 20.620um -18.880um
paint metal1
box 20.300um -19.200um 20.700um -18.800um
paint metal1
box 20.400um -19.100um 20.600um -18.900um
paint via1
box 20.300um -19.200um 20.700um -18.800um
paint metal2
box 20.400um -19.100um 22.450um -18.900um
paint metal2
box 22.150um -19.200um 22.550um -18.800um
paint metal2
box 22.250um -19.100um 22.450um -18.900um
paint via2
box 22.150um -19.200um 22.550um -18.800um
paint metal3
box 22.150um -19.200um 22.550um -18.800um
paint metal3
box 22.250um -19.100um 22.450um -18.900um
paint via3
box 22.150um -19.200um 22.550um -18.800um
paint metal4
box 22.150um -19.200um 22.550um -18.800um
paint metal4
box 22.250um -19.100um 22.450um -18.900um
paint via4
box 22.150um -19.200um 22.550um -18.800um
paint metal5
box 22.250um -19.100um 22.450um -18.900um
paint metal5
save pll_analog
puts DONE
quit -noprompt
