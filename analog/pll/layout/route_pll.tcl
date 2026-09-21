# Smarter up-and-over M4 spine router
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
box 74.250um -10.950um 74.750um -10.450um
paint metal1
label out FreeSans 0.7um 0 0 0
port make
port connections n s e w
box 36.250um 22.750um 36.750um 23.250um
paint metal1
label vctrl FreeSans 0.7um 0 0 0
# net clk_ref_gate  trunk=14.000
box 6.880um 8.040um 7.120um 8.280um
paint metal1
box 6.900um 8.060um 7.100um 8.260um
paint via1
box 6.800um 7.960um 7.200um 8.360um
paint metal2
box 6.800um 7.960um 7.200um 8.360um
paint metal2
box 6.900um 8.060um 7.100um 8.260um
paint via2
box 6.800um 7.960um 7.200um 8.360um
paint metal3
box 6.800um 7.960um 7.200um 8.360um
paint metal3
box 6.900um 8.060um 7.100um 8.260um
paint via3
box 6.800um 7.960um 7.200um 8.360um
paint metal4
box 6.800um 7.960um 7.200um 8.360um
paint metal3
box 6.900um 8.060um 7.100um 8.260um
paint via3
box 6.800um 7.960um 7.200um 8.360um
paint metal4
box 6.900um 8.060um 7.100um 14.100um
paint metal3
box 6.800um 13.800um 7.200um 14.200um
paint metal3
box 6.900um 13.900um 7.100um 14.100um
paint via3
box 6.800um 13.800um 7.200um 14.200um
paint metal4
box -1.620um 6.880um -1.380um 7.120um
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
box -1.700um 6.800um -1.300um 7.200um
paint metal3
box -1.600um 6.900um -1.400um 7.100um
paint via3
box -1.700um 6.800um -1.300um 7.200um
paint metal4
box -1.600um 6.900um -1.400um 14.100um
paint metal3
box -1.700um 13.800um -1.300um 14.200um
paint metal3
box -1.600um 13.900um -1.400um 14.100um
paint via3
box -1.700um 13.800um -1.300um 14.200um
paint metal4
# net net1  trunk=15.000
box 15.555um 3.830um 15.795um 4.070um
paint metal1
box 15.575um 3.850um 15.775um 4.050um
paint via1
box 15.475um 3.750um 15.875um 4.150um
paint metal2
box 15.475um 3.750um 15.875um 4.150um
paint metal2
box 15.575um 3.850um 15.775um 4.050um
paint via2
box 15.475um 3.750um 15.875um 4.150um
paint metal3
box 15.475um 3.750um 15.875um 4.150um
paint metal3
box 15.575um 3.850um 15.775um 4.050um
paint via3
box 15.475um 3.750um 15.875um 4.150um
paint metal4
box 15.475um 3.750um 15.875um 4.150um
paint metal3
box 15.575um 3.850um 15.775um 4.050um
paint via3
box 15.475um 3.750um 15.875um 4.150um
paint metal4
box 15.575um 3.850um 15.775um 15.100um
paint metal3
box 15.475um 14.800um 15.875um 15.200um
paint metal3
box 15.575um 14.900um 15.775um 15.100um
paint via3
box 15.475um 14.800um 15.875um 15.200um
paint metal4
box 2.607um 8.098um 2.848um 8.337um
paint metal1
box 2.627um 8.117um 2.828um 8.317um
paint via1
box 2.527um 8.018um 2.928um 8.417um
paint metal2
box 2.527um 8.018um 2.928um 8.417um
paint metal2
box 2.627um 8.117um 2.828um 8.317um
paint via2
box 2.527um 8.018um 2.928um 8.417um
paint metal3
box 2.527um 8.018um 2.928um 8.417um
paint metal3
box 2.627um 8.117um 2.828um 8.317um
paint via3
box 2.527um 8.018um 2.928um 8.417um
paint metal4
box 2.527um 8.018um 2.928um 8.417um
paint metal3
box 2.627um 8.117um 2.828um 8.317um
paint via3
box 2.527um 8.018um 2.928um 8.417um
paint metal4
box 2.627um 8.117um 2.828um 15.100um
paint metal3
box 2.527um 14.800um 2.928um 15.200um
paint metal3
box 2.627um 14.900um 2.828um 15.100um
paint via3
box 2.527um 14.800um 2.928um 15.200um
paint metal4
box 2.567um 1.897um 2.808um 2.138um
paint metal1
box 2.587um 1.917um 2.788um 2.118um
paint via1
box 2.487um 1.817um 2.888um 2.218um
paint metal2
box 2.487um 1.817um 2.888um 2.218um
paint metal2
box 2.587um 1.917um 2.788um 2.118um
paint via2
box 2.487um 1.817um 2.888um 2.218um
paint metal3
box 2.487um 1.817um 2.888um 2.218um
paint metal3
box 2.587um 1.917um 2.788um 2.118um
paint via3
box 2.487um 1.817um 2.888um 2.218um
paint metal4
box 2.587um 1.917um 4.087um 2.118um
paint metal4
box 3.787um 1.817um 4.187um 2.218um
paint metal3
box 3.887um 1.917um 4.087um 2.118um
paint via3
box 3.787um 1.817um 4.187um 2.218um
paint metal4
box 3.887um 1.917um 4.087um 15.100um
paint metal3
box 3.787um 14.800um 4.187um 15.200um
paint metal3
box 3.887um 14.900um 4.087um 15.100um
paint via3
box 3.787um 14.800um 4.187um 15.200um
paint metal4
# net net15  trunk=16.000
box 57.690um -4.310um 57.930um -4.070um
paint metal1
box 57.710um -4.290um 57.910um -4.090um
paint via1
box 57.610um -4.390um 58.010um -3.990um
paint metal2
box 57.610um -4.390um 58.010um -3.990um
paint metal2
box 57.710um -4.290um 57.910um -4.090um
paint via2
box 57.610um -4.390um 58.010um -3.990um
paint metal3
box 57.610um -4.390um 58.010um -3.990um
paint metal3
box 57.710um -4.290um 57.910um -4.090um
paint via3
box 57.610um -4.390um 58.010um -3.990um
paint metal4
box 57.610um -4.390um 58.010um -3.990um
paint metal3
box 57.710um -4.290um 57.910um -4.090um
paint via3
box 57.610um -4.390um 58.010um -3.990um
paint metal4
box 57.710um -4.290um 57.910um 16.100um
paint metal3
box 57.610um 15.800um 58.010um 16.200um
paint metal3
box 57.710um 15.900um 57.910um 16.100um
paint via3
box 57.610um 15.800um 58.010um 16.200um
paint metal4
box 35.110um -6.860um 36.110um -5.860um
paint metal1
box 35.510um -6.460um 35.710um -6.260um
paint via1
box 35.410um -6.560um 35.810um -6.160um
paint metal2
box 35.410um -6.560um 35.810um -6.160um
paint metal2
box 35.510um -6.460um 35.710um -6.260um
paint via2
box 35.410um -6.560um 35.810um -6.160um
paint metal3
box 35.410um -6.560um 35.810um -6.160um
paint metal3
box 35.510um -6.460um 35.710um -6.260um
paint via3
box 35.410um -6.560um 35.810um -6.160um
paint metal4
box 35.410um -6.560um 35.810um -6.160um
paint metal3
box 35.510um -6.460um 35.710um -6.260um
paint via3
box 35.410um -6.560um 35.810um -6.160um
paint metal4
box 35.510um -6.460um 35.710um 16.100um
paint metal3
box 35.410um 15.800um 35.810um 16.200um
paint metal3
box 35.510um 15.900um 35.710um 16.100um
paint via3
box 35.410um 15.800um 35.810um 16.200um
paint metal4
# net net2  trunk=17.000
box 22.495um 6.310um 22.735um 6.550um
paint metal1
box 22.515um 6.330um 22.715um 6.530um
paint via1
box 22.415um 6.230um 22.815um 6.630um
paint metal2
box 22.415um 6.230um 22.815um 6.630um
paint metal2
box 22.515um 6.330um 22.715um 6.530um
paint via2
box 22.415um 6.230um 22.815um 6.630um
paint metal3
box 22.415um 6.230um 22.815um 6.630um
paint metal3
box 22.515um 6.330um 22.715um 6.530um
paint via3
box 22.415um 6.230um 22.815um 6.630um
paint metal4
box 22.415um 6.230um 22.815um 6.630um
paint metal3
box 22.515um 6.330um 22.715um 6.530um
paint via3
box 22.415um 6.230um 22.815um 6.630um
paint metal4
box 22.515um 6.330um 22.715um 17.100um
paint metal3
box 22.415um 16.800um 22.815um 17.200um
paint metal3
box 22.515um 16.900um 22.715um 17.100um
paint via3
box 22.415um 16.800um 22.815um 17.200um
paint metal4
box 20.190um 4.513um 20.430um 4.753um
paint metal1
box 20.210um 4.533um 20.410um 4.732um
paint via1
box 20.110um 4.433um 20.510um 4.832um
paint metal2
box 20.110um 4.433um 20.510um 4.832um
paint metal2
box 20.210um 4.533um 20.410um 4.732um
paint via2
box 20.110um 4.433um 20.510um 4.832um
paint metal3
box 20.110um 4.433um 20.510um 4.832um
paint metal3
box 20.210um 4.533um 20.410um 4.732um
paint via3
box 20.110um 4.433um 20.510um 4.832um
paint metal4
box 20.110um 4.433um 20.510um 4.832um
paint metal3
box 20.210um 4.533um 20.410um 4.732um
paint via3
box 20.110um 4.433um 20.510um 4.832um
paint metal4
box 20.210um 4.533um 20.410um 17.100um
paint metal3
box 20.110um 16.800um 20.510um 17.200um
paint metal3
box 20.210um 16.900um 20.410um 17.100um
paint via3
box 20.110um 16.800um 20.510um 17.200um
paint metal4
# net net3  trunk=18.000
box 22.530um 3.830um 22.770um 4.070um
paint metal1
box 22.550um 3.850um 22.750um 4.050um
paint via1
box 22.450um 3.750um 22.850um 4.150um
paint metal2
box 22.450um 3.750um 22.850um 4.150um
paint metal2
box 22.550um 3.850um 22.750um 4.050um
paint via2
box 22.450um 3.750um 22.850um 4.150um
paint metal3
box 22.450um 3.750um 22.850um 4.150um
paint metal3
box 22.550um 3.850um 22.750um 4.050um
paint via3
box 22.450um 3.750um 22.850um 4.150um
paint metal4
box 22.550um 3.850um 24.050um 4.050um
paint metal4
box 23.750um 3.750um 24.150um 4.150um
paint metal3
box 23.850um 3.850um 24.050um 4.050um
paint via3
box 23.750um 3.750um 24.150um 4.150um
paint metal4
box 23.850um 3.850um 24.050um 18.100um
paint metal3
box 23.750um 17.800um 24.150um 18.200um
paint metal3
box 23.850um 17.900um 24.050um 18.100um
paint via3
box 23.750um 17.800um 24.150um 18.200um
paint metal4
box 21.810um 1.370um 22.050um 1.610um
paint metal1
box 21.830um 1.390um 22.030um 1.590um
paint via1
box 21.730um 1.290um 22.130um 1.690um
paint metal2
box 21.730um 1.290um 22.130um 1.690um
paint metal2
box 21.830um 1.390um 22.030um 1.590um
paint via2
box 21.730um 1.290um 22.130um 1.690um
paint metal3
box 21.730um 1.290um 22.130um 1.690um
paint metal3
box 21.830um 1.390um 22.030um 1.590um
paint via3
box 21.730um 1.290um 22.130um 1.690um
paint metal4
box 21.180um 1.390um 22.030um 1.590um
paint metal4
box 21.080um 1.290um 21.480um 1.690um
paint metal3
box 21.180um 1.390um 21.380um 1.590um
paint via3
box 21.080um 1.290um 21.480um 1.690um
paint metal4
box 21.180um 1.390um 21.380um 18.100um
paint metal3
box 21.080um 17.800um 21.480um 18.200um
paint metal3
box 21.180um 17.900um 21.380um 18.100um
paint via3
box 21.080um 17.800um 21.480um 18.200um
paint metal4
# net net4  trunk=19.000
box 22.750um 5.840um 22.990um 6.080um
paint metal1
box 22.770um 5.860um 22.970um 6.060um
paint via1
box 22.670um 5.760um 23.070um 6.160um
paint metal2
box 22.670um 5.760um 23.070um 6.160um
paint metal2
box 22.770um 5.860um 22.970um 6.060um
paint via2
box 22.670um 5.760um 23.070um 6.160um
paint metal3
box 22.670um 5.760um 23.070um 6.160um
paint metal3
box 22.770um 5.860um 22.970um 6.060um
paint via3
box 22.670um 5.760um 23.070um 6.160um
paint metal4
box 22.670um 5.760um 23.070um 6.160um
paint metal4
box 22.770um 5.860um 22.970um 6.060um
paint via4
box 22.670um 5.760um 23.070um 6.160um
paint metal5
box -5.180um 5.860um 22.970um 6.060um
paint metal5
box -5.280um 5.760um -4.880um 6.160um
paint metal4
box -5.180um 5.860um -4.980um 6.060um
paint via4
box -5.280um 5.760um -4.880um 6.160um
paint metal5
box -5.280um 5.760um -4.880um 6.160um
paint metal3
box -5.180um 5.860um -4.980um 6.060um
paint via3
box -5.280um 5.760um -4.880um 6.160um
paint metal4
box -5.180um 5.860um -4.980um 19.100um
paint metal3
box -5.280um 18.800um -4.880um 19.200um
paint metal3
box -5.180um 18.900um -4.980um 19.100um
paint via3
box -5.280um 18.800um -4.880um 19.200um
paint metal4
box 21.930um 8.380um 22.170um 8.620um
paint metal1
box 21.950um 8.400um 22.150um 8.600um
paint via1
box 21.850um 8.300um 22.250um 8.700um
paint metal2
box 21.850um 8.300um 22.250um 8.700um
paint metal2
box 21.950um 8.400um 22.150um 8.600um
paint via2
box 21.850um 8.300um 22.250um 8.700um
paint metal3
box 21.850um 8.300um 22.250um 8.700um
paint metal3
box 21.950um 8.400um 22.150um 8.600um
paint via3
box 21.850um 8.300um 22.250um 8.700um
paint metal4
box 21.950um 8.400um 25.400um 8.600um
paint metal4
box 25.100um 8.300um 25.500um 8.700um
paint metal3
box 25.200um 8.400um 25.400um 8.600um
paint via3
box 25.100um 8.300um 25.500um 8.700um
paint metal4
box 25.200um 8.400um 25.400um 19.100um
paint metal3
box 25.100um 18.800um 25.500um 19.200um
paint metal3
box 25.200um 18.900um 25.400um 19.100um
paint via3
box 25.100um 18.800um 25.500um 19.200um
paint metal4
# net pfd_down  trunk=20.000
box 22.275um 4.300um 22.515um 4.540um
paint metal1
box 22.295um 4.320um 22.495um 4.520um
paint via1
box 22.195um 4.220um 22.595um 4.620um
paint metal2
box 22.195um 4.220um 22.595um 4.620um
paint metal2
box 22.295um 4.320um 22.495um 4.520um
paint via2
box 22.195um 4.220um 22.595um 4.620um
paint metal3
box 22.195um 4.220um 22.595um 4.620um
paint metal3
box 22.295um 4.320um 22.495um 4.520um
paint via3
box 22.195um 4.220um 22.595um 4.620um
paint metal4
box 22.295um 4.320um 22.495um 5.570um
paint metal4
box 19.045um 5.370um 22.495um 5.570um
paint metal4
box 18.945um 5.270um 19.345um 5.670um
paint metal3
box 19.045um 5.370um 19.245um 5.570um
paint via3
box 18.945um 5.270um 19.345um 5.670um
paint metal4
box 19.045um 5.370um 19.245um 20.100um
paint metal3
box 18.945um 19.800um 19.345um 20.200um
paint metal3
box 19.045um 19.900um 19.245um 20.100um
paint via3
box 18.945um 19.800um 19.345um 20.200um
paint metal4
box 17.137um 5.798um 17.378um 6.038um
paint metal1
box 17.157um 5.818um 17.358um 6.018um
paint via1
box 17.057um 5.718um 17.458um 6.117um
paint metal2
box 17.057um 5.718um 17.458um 6.117um
paint metal2
box 17.157um 5.818um 17.358um 6.018um
paint via2
box 17.057um 5.718um 17.458um 6.117um
paint metal3
box 17.057um 5.718um 17.458um 6.117um
paint metal3
box 17.157um 5.818um 17.358um 6.018um
paint via3
box 17.057um 5.718um 17.458um 6.117um
paint metal4
box 17.057um 5.718um 17.458um 6.117um
paint metal3
box 17.157um 5.818um 17.358um 6.018um
paint via3
box 17.057um 5.718um 17.458um 6.117um
paint metal4
box 17.157um 5.818um 17.358um 20.100um
paint metal3
box 17.057um 19.800um 17.458um 20.200um
paint metal3
box 17.157um 19.900um 17.358um 20.100um
paint via3
box 17.057um 19.800um 17.458um 20.200um
paint metal4
box 12.623um 2.785um 12.862um 3.025um
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
box 12.543um 2.705um 12.942um 3.105um
paint metal3
box 12.643um 2.805um 12.842um 3.005um
paint via3
box 12.543um 2.705um 12.942um 3.105um
paint metal4
box 12.643um 2.805um 12.842um 20.100um
paint metal3
box 12.543um 19.800um 12.942um 20.200um
paint metal3
box 12.643um 19.900um 12.842um 20.100um
paint via3
box 12.543um 19.800um 12.942um 20.200um
paint metal4
# net pfd_up  trunk=21.000
box 19.688um 4.305um 19.928um 4.545um
paint metal1
box 19.707um 4.325um 19.908um 4.525um
paint via1
box 19.607um 4.225um 20.008um 4.625um
paint metal2
box 19.607um 4.225um 20.008um 4.625um
paint metal2
box 19.707um 4.325um 19.908um 4.525um
paint via2
box 19.607um 4.225um 20.008um 4.625um
paint metal3
box 19.607um 4.225um 20.008um 4.625um
paint metal3
box 19.707um 4.325um 19.908um 4.525um
paint via3
box 19.607um 4.225um 20.008um 4.625um
paint metal4
box 19.607um 4.225um 20.008um 4.625um
paint metal4
box 19.707um 4.325um 19.908um 4.525um
paint via4
box 19.607um 4.225um 20.008um 4.625um
paint metal5
box -6.292um 4.325um 19.908um 4.525um
paint metal5
box -6.392um 4.225um -5.992um 4.625um
paint metal4
box -6.292um 4.325um -6.092um 4.525um
paint via4
box -6.392um 4.225um -5.992um 4.625um
paint metal5
box -6.392um 4.225um -5.992um 4.625um
paint metal3
box -6.292um 4.325um -6.092um 4.525um
paint via3
box -6.392um 4.225um -5.992um 4.625um
paint metal4
box -6.292um 4.325um -6.092um 21.100um
paint metal3
box -6.392um 20.800um -5.992um 21.200um
paint metal3
box -6.292um 20.900um -6.092um 21.100um
paint via3
box -6.392um 20.800um -5.992um 21.200um
paint metal4
box 16.605um 4.827um 16.845um 5.067um
paint metal1
box 16.625um 4.848um 16.825um 5.047um
paint via1
box 16.525um 4.748um 16.925um 5.147um
paint metal2
box 16.525um 4.748um 16.925um 5.147um
paint metal2
box 16.625um 4.848um 16.825um 5.047um
paint via2
box 16.525um 4.748um 16.925um 5.147um
paint metal3
box 16.525um 4.748um 16.925um 5.147um
paint metal3
box 16.625um 4.848um 16.825um 5.047um
paint via3
box 16.525um 4.748um 16.925um 5.147um
paint metal4
box 14.025um 4.848um 16.825um 5.047um
paint metal4
box 13.925um 4.748um 14.325um 5.147um
paint metal3
box 14.025um 4.848um 14.225um 5.047um
paint via3
box 13.925um 4.748um 14.325um 5.147um
paint metal4
box 14.025um 4.848um 14.225um 21.100um
paint metal3
box 13.925um 20.800um 14.325um 21.200um
paint metal3
box 14.025um 20.900um 14.225um 21.100um
paint via3
box 13.925um 20.800um 14.325um 21.200um
paint metal4
box 12.663um 8.985um 12.902um 9.225um
paint metal1
box 12.683um 9.005um 12.883um 9.205um
paint via1
box 12.583um 8.905um 12.982um 9.305um
paint metal2
box 12.583um 8.905um 12.982um 9.305um
paint metal2
box 12.683um 9.005um 12.883um 9.205um
paint via2
box 12.583um 8.905um 12.982um 9.305um
paint metal3
box 12.583um 8.905um 12.982um 9.305um
paint metal3
box 12.683um 9.005um 12.883um 9.205um
paint via3
box 12.583um 8.905um 12.982um 9.305um
paint metal4
box 11.383um 9.005um 12.883um 9.205um
paint metal4
box 11.283um 8.905um 11.682um 9.305um
paint metal3
box 11.383um 9.005um 11.582um 9.205um
paint via3
box 11.283um 8.905um 11.682um 9.305um
paint metal4
box 11.383um 9.005um 11.582um 21.100um
paint metal3
box 11.283um 20.800um 11.682um 21.200um
paint metal3
box 11.383um 20.900um 11.582um 21.100um
paint via3
box 11.283um 20.800um 11.682um 21.200um
paint metal4
# net vbn  trunk=22.000
box 22.520um -0.810um 22.760um -0.570um
paint metal1
box 22.540um -0.790um 22.740um -0.590um
paint via1
box 22.440um -0.890um 22.840um -0.490um
paint metal2
box 22.440um -0.890um 22.840um -0.490um
paint metal2
box 22.540um -0.790um 22.740um -0.590um
paint via2
box 22.440um -0.890um 22.840um -0.490um
paint metal3
box 22.440um -0.890um 22.840um -0.490um
paint metal3
box 22.540um -0.790um 22.740um -0.590um
paint via3
box 22.440um -0.890um 22.840um -0.490um
paint metal4
box 22.540um -0.790um 26.640um -0.590um
paint metal4
box 26.340um -0.890um 26.740um -0.490um
paint metal3
box 26.440um -0.790um 26.640um -0.590um
paint via3
box 26.340um -0.890um 26.740um -0.490um
paint metal4
box 26.440um -0.790um 26.640um 22.100um
paint metal3
box 26.340um 21.800um 26.740um 22.200um
paint metal3
box 26.440um 21.900um 26.640um 22.100um
paint via3
box 26.340um 21.800um 26.740um 22.200um
paint metal4
box 22.500um -3.000um 22.740um -2.760um
paint metal1
box 22.520um -2.980um 22.720um -2.780um
paint via1
box 22.420um -3.080um 22.820um -2.680um
paint metal2
box 22.420um -3.080um 22.820um -2.680um
paint metal2
box 22.520um -2.980um 22.720um -2.780um
paint via2
box 22.420um -3.080um 22.820um -2.680um
paint metal3
box 22.420um -3.080um 22.820um -2.680um
paint metal3
box 22.520um -2.980um 22.720um -2.780um
paint via3
box 22.420um -3.080um 22.820um -2.680um
paint metal4
box 22.520um -2.980um 27.920um -2.780um
paint metal4
box 27.620um -3.080um 28.020um -2.680um
paint metal3
box 27.720um -2.980um 27.920um -2.780um
paint via3
box 27.620um -3.080um 28.020um -2.680um
paint metal4
box 27.720um -2.980um 27.920um 22.100um
paint metal3
box 27.620um 21.800um 28.020um 22.200um
paint metal3
box 27.720um 21.900um 27.920um 22.100um
paint via3
box 27.620um 21.800um 28.020um 22.200um
paint metal4
box 22.500um 1.840um 22.740um 2.080um
paint metal1
box 22.520um 1.860um 22.720um 2.060um
paint via1
box 22.420um 1.760um 22.820um 2.160um
paint metal2
box 22.420um 1.760um 22.820um 2.160um
paint metal2
box 22.520um 1.860um 22.720um 2.060um
paint via2
box 22.420um 1.760um 22.820um 2.160um
paint metal3
box 22.420um 1.760um 22.820um 2.160um
paint metal3
box 22.520um 1.860um 22.720um 2.060um
paint via3
box 22.420um 1.760um 22.820um 2.160um
paint metal4
box 22.520um 1.860um 29.220um 2.060um
paint metal4
box 28.920um 1.760um 29.320um 2.160um
paint metal3
box 29.020um 1.860um 29.220um 2.060um
paint via3
box 28.920um 1.760um 29.320um 2.160um
paint metal4
box 29.020um 1.860um 29.220um 22.100um
paint metal3
box 28.920um 21.800um 29.320um 22.200um
paint metal3
box 29.020um 21.900um 29.220um 22.100um
paint via3
box 28.920um 21.800um 29.320um 22.200um
paint metal4
box 21.830um -1.280um 22.070um -1.040um
paint metal1
box 21.850um -1.260um 22.050um -1.060um
paint via1
box 21.750um -1.360um 22.150um -0.960um
paint metal2
box 21.750um -1.360um 22.150um -0.960um
paint metal2
box 21.850um -1.260um 22.050um -1.060um
paint via2
box 21.750um -1.360um 22.150um -0.960um
paint metal3
box 21.750um -1.360um 22.150um -0.960um
paint metal3
box 21.850um -1.260um 22.050um -1.060um
paint via3
box 21.750um -1.360um 22.150um -0.960um
paint metal4
box 21.850um -1.260um 30.500um -1.060um
paint metal4
box 30.200um -1.360um 30.600um -0.960um
paint metal3
box 30.300um -1.260um 30.500um -1.060um
paint via3
box 30.200um -1.360um 30.600um -0.960um
paint metal4
box 30.300um -1.260um 30.500um 22.100um
paint metal3
box 30.200um 21.800um 30.600um 22.200um
paint metal3
box 30.300um 21.900um 30.500um 22.100um
paint via3
box 30.200um 21.800um 30.600um 22.200um
paint metal4
box 19.810um -15.350um 20.050um -15.110um
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
box 10.080um -15.330um 20.030um -15.130um
paint metal4
box 9.980um -15.430um 10.380um -15.030um
paint metal3
box 10.080um -15.330um 10.280um -15.130um
paint via3
box 9.980um -15.430um 10.380um -15.030um
paint metal4
box 10.080um -15.330um 10.280um 22.100um
paint metal3
box 9.980um 21.800um 10.380um 22.200um
paint metal3
box 10.080um 21.900um 10.280um 22.100um
paint via3
box 9.980um 21.800um 10.380um 22.200um
paint metal4
# net vbp  trunk=23.000
box 23.520um -6.250um 23.760um -6.010um
paint metal1
box 23.540um -6.230um 23.740um -6.030um
paint via1
box 23.440um -6.330um 23.840um -5.930um
paint metal2
box 23.440um -6.330um 23.840um -5.930um
paint metal2
box 23.540um -6.230um 23.740um -6.030um
paint via2
box 23.440um -6.330um 23.840um -5.930um
paint metal3
box 23.440um -6.330um 23.840um -5.930um
paint metal3
box 23.540um -6.230um 23.740um -6.030um
paint via3
box 23.440um -6.330um 23.840um -5.930um
paint metal4
box 23.540um -6.230um 32.190um -6.030um
paint metal4
box 31.890um -6.330um 32.290um -5.930um
paint metal3
box 31.990um -6.230um 32.190um -6.030um
paint via3
box 31.890um -6.330um 32.290um -5.930um
paint metal4
box 31.990um -6.230um 32.190um 23.100um
paint metal3
box 31.890um 22.800um 32.290um 23.200um
paint metal3
box 31.990um 22.900um 32.190um 23.100um
paint via3
box 31.890um 22.800um 32.290um 23.200um
paint metal4
box 22.830um -6.970um 23.070um -6.730um
paint metal1
box 22.850um -6.950um 23.050um -6.750um
paint via1
box 22.750um -7.050um 23.150um -6.650um
paint metal2
box 22.750um -7.050um 23.150um -6.650um
paint metal2
box 22.850um -6.950um 23.050um -6.750um
paint via2
box 22.750um -7.050um 23.150um -6.650um
paint metal3
box 22.750um -7.050um 23.150um -6.650um
paint metal3
box 22.850um -6.950um 23.050um -6.750um
paint via3
box 22.750um -7.050um 23.150um -6.650um
paint metal4
box 22.850um -6.950um 33.450um -6.750um
paint metal4
box 33.150um -7.050um 33.550um -6.650um
paint metal3
box 33.250um -6.950um 33.450um -6.750um
paint via3
box 33.150um -7.050um 33.550um -6.650um
paint metal4
box 33.250um -6.950um 33.450um 23.100um
paint metal3
box 33.150um 22.800um 33.550um 23.200um
paint metal3
box 33.250um 22.900um 33.450um 23.100um
paint via3
box 33.150um 22.800um 33.550um 23.200um
paint metal4
box 22.620um 9.100um 22.860um 9.340um
paint metal1
box 22.640um 9.120um 22.840um 9.320um
paint via1
box 22.540um 9.020um 22.940um 9.420um
paint metal2
box 22.540um 9.020um 22.940um 9.420um
paint metal2
box 22.640um 9.120um 22.840um 9.320um
paint via2
box 22.540um 9.020um 22.940um 9.420um
paint metal3
box 22.540um 9.020um 22.940um 9.420um
paint metal3
box 22.640um 9.120um 22.840um 9.320um
paint via3
box 22.540um 9.020um 22.940um 9.420um
paint metal4
box 22.640um 9.120um 34.540um 9.320um
paint metal4
box 34.240um 9.020um 34.640um 9.420um
paint metal3
box 34.340um 9.120um 34.540um 9.320um
paint via3
box 34.240um 9.020um 34.640um 9.420um
paint metal4
box 34.340um 9.120um 34.540um 23.100um
paint metal3
box 34.240um 22.800um 34.640um 23.200um
paint metal3
box 34.340um 22.900um 34.540um 23.100um
paint via3
box 34.240um 22.800um 34.640um 23.200um
paint metal4
box 21.810um -3.470um 22.050um -3.230um
paint metal1
box 21.830um -3.450um 22.030um -3.250um
paint via1
box 21.730um -3.550um 22.130um -3.150um
paint metal2
box 21.730um -3.550um 22.130um -3.150um
paint metal2
box 21.830um -3.450um 22.030um -3.250um
paint via2
box 21.730um -3.550um 22.130um -3.150um
paint metal3
box 21.730um -3.550um 22.130um -3.150um
paint metal3
box 21.830um -3.450um 22.030um -3.250um
paint via3
box 21.730um -3.550um 22.130um -3.150um
paint metal4
box 8.830um -3.450um 22.030um -3.250um
paint metal4
box 8.730um -3.550um 9.130um -3.150um
paint metal3
box 8.830um -3.450um 9.030um -3.250um
paint via3
box 8.730um -3.550um 9.130um -3.150um
paint metal4
box 8.830um -3.450um 9.030um 23.100um
paint metal3
box 8.730um 22.800um 9.130um 23.200um
paint metal3
box 8.830um 22.900um 9.030um 23.100um
paint via3
box 8.730um 22.800um 9.130um 23.200um
paint metal4
# net vco_out_div  trunk=24.000
box 6.840um 1.840um 7.080um 2.080um
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
box 5.560um 1.860um 7.060um 2.060um
paint metal4
box 5.460um 1.760um 5.860um 2.160um
paint metal3
box 5.560um 1.860um 5.760um 2.060um
paint via3
box 5.460um 1.760um 5.860um 2.160um
paint metal4
box 5.560um 1.860um 5.760um 24.100um
paint metal3
box 5.460um 23.800um 5.860um 24.200um
paint metal3
box 5.560um 23.900um 5.760um 24.100um
paint via3
box 5.460um 23.800um 5.860um 24.200um
paint metal4
box -1.620um 1.880um -1.380um 2.120um
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
box -1.600um 1.900um -0.100um 2.100um
paint metal4
box -0.400um 1.800um 0.000um 2.200um
paint metal3
box -0.300um 1.900um -0.100um 2.100um
paint via3
box -0.400um 1.800um 0.000um 2.200um
paint metal4
box -0.300um 1.900um -0.100um 24.100um
paint metal3
box -0.400um 23.800um 0.000um 24.200um
paint metal3
box -0.300um 23.900um -0.100um 24.100um
paint via3
box -0.400um 23.800um 0.000um 24.200um
paint metal4
# net vctrl  trunk=25.000
box 68.245um -15.120um 68.485um -14.880um
paint metal1
box 68.265um -15.100um 68.465um -14.900um
paint via1
box 68.165um -15.200um 68.565um -14.800um
paint metal2
box 68.165um -15.200um 68.565um -14.800um
paint metal2
box 68.265um -15.100um 68.465um -14.900um
paint via2
box 68.165um -15.200um 68.565um -14.800um
paint metal3
box 68.165um -15.200um 68.565um -14.800um
paint metal3
box 68.265um -15.100um 68.465um -14.900um
paint via3
box 68.165um -15.200um 68.565um -14.800um
paint metal4
box 68.165um -15.200um 68.565um -14.800um
paint metal3
box 68.265um -15.100um 68.465um -14.900um
paint via3
box 68.165um -15.200um 68.565um -14.800um
paint metal4
box 68.265um -15.100um 68.465um 25.100um
paint metal3
box 68.165um 24.800um 68.565um 25.200um
paint metal3
box 68.265um 24.900um 68.465um 25.100um
paint via3
box 68.165um 24.800um 68.565um 25.200um
paint metal4
box 64.805um -14.900um 65.045um -14.660um
paint metal1
box 64.825um -14.880um 65.025um -14.680um
paint via1
box 64.725um -14.980um 65.125um -14.580um
paint metal2
box 64.725um -14.980um 65.125um -14.580um
paint metal2
box 64.825um -14.880um 65.025um -14.680um
paint via2
box 64.725um -14.980um 65.125um -14.580um
paint metal3
box 64.725um -14.980um 65.125um -14.580um
paint metal3
box 64.825um -14.880um 65.025um -14.680um
paint via3
box 64.725um -14.980um 65.125um -14.580um
paint metal4
box 64.725um -14.980um 65.125um -14.580um
paint metal3
box 64.825um -14.880um 65.025um -14.680um
paint via3
box 64.725um -14.980um 65.125um -14.580um
paint metal4
box 64.825um -14.880um 65.025um 25.100um
paint metal3
box 64.725um 24.800um 65.125um 25.200um
paint metal3
box 64.825um 24.900um 65.025um 25.100um
paint via3
box 64.725um 24.800um 65.125um 25.200um
paint metal4
box 62.115um -14.870um 62.355um -14.630um
paint metal1
box 62.135um -14.850um 62.335um -14.650um
paint via1
box 62.035um -14.950um 62.435um -14.550um
paint metal2
box 62.035um -14.950um 62.435um -14.550um
paint metal2
box 62.135um -14.850um 62.335um -14.650um
paint via2
box 62.035um -14.950um 62.435um -14.550um
paint metal3
box 62.035um -14.950um 62.435um -14.550um
paint metal3
box 62.135um -14.850um 62.335um -14.650um
paint via3
box 62.035um -14.950um 62.435um -14.550um
paint metal4
box 62.035um -14.950um 62.435um -14.550um
paint metal3
box 62.135um -14.850um 62.335um -14.650um
paint via3
box 62.035um -14.950um 62.435um -14.550um
paint metal4
box 62.135um -14.850um 62.335um 25.100um
paint metal3
box 62.035um 24.800um 62.435um 25.200um
paint metal3
box 62.135um 24.900um 62.335um 25.100um
paint via3
box 62.035um 24.800um 62.435um 25.200um
paint metal4
box 59.315um -12.920um 59.555um -12.680um
paint metal1
box 59.335um -12.900um 59.535um -12.700um
paint via1
box 59.235um -13.000um 59.635um -12.600um
paint metal2
box 59.235um -13.000um 59.635um -12.600um
paint metal2
box 59.335um -12.900um 59.535um -12.700um
paint via2
box 59.235um -13.000um 59.635um -12.600um
paint metal3
box 59.235um -13.000um 59.635um -12.600um
paint metal3
box 59.335um -12.900um 59.535um -12.700um
paint via3
box 59.235um -13.000um 59.635um -12.600um
paint metal4
box 59.235um -13.000um 59.635um -12.600um
paint metal3
box 59.335um -12.900um 59.535um -12.700um
paint via3
box 59.235um -13.000um 59.635um -12.600um
paint metal4
box 59.335um -12.900um 59.535um 25.100um
paint metal3
box 59.235um 24.800um 59.635um 25.200um
paint metal3
box 59.335um 24.900um 59.535um 25.100um
paint via3
box 59.235um 24.800um 59.635um 25.200um
paint metal4
box 52.210um -12.820um 53.210um -11.820um
paint metal1
box 52.610um -12.420um 52.810um -12.220um
paint via1
box 52.510um -12.520um 52.910um -12.120um
paint metal2
box 52.510um -12.520um 52.910um -12.120um
paint metal2
box 52.610um -12.420um 52.810um -12.220um
paint via2
box 52.510um -12.520um 52.910um -12.120um
paint metal3
box 52.510um -12.520um 52.910um -12.120um
paint metal3
box 52.610um -12.420um 52.810um -12.220um
paint via3
box 52.510um -12.520um 52.910um -12.120um
paint metal4
box 52.510um -12.520um 52.910um -12.120um
paint metal3
box 52.610um -12.420um 52.810um -12.220um
paint via3
box 52.510um -12.520um 52.910um -12.120um
paint metal4
box 52.610um -12.420um 52.810um 25.100um
paint metal3
box 52.510um 24.800um 52.910um 25.200um
paint metal3
box 52.610um 24.900um 52.810um 25.100um
paint via3
box 52.510um 24.800um 52.910um 25.200um
paint metal4
box 48.870um -4.310um 49.110um -4.070um
paint metal1
box 48.890um -4.290um 49.090um -4.090um
paint via1
box 48.790um -4.390um 49.190um -3.990um
paint metal2
box 48.790um -4.390um 49.190um -3.990um
paint metal2
box 48.890um -4.290um 49.090um -4.090um
paint via2
box 48.790um -4.390um 49.190um -3.990um
paint metal3
box 48.790um -4.390um 49.190um -3.990um
paint metal3
box 48.890um -4.290um 49.090um -4.090um
paint via3
box 48.790um -4.390um 49.190um -3.990um
paint metal4
box 48.790um -4.390um 49.190um -3.990um
paint metal3
box 48.890um -4.290um 49.090um -4.090um
paint via3
box 48.790um -4.390um 49.190um -3.990um
paint metal4
box 48.890um -4.290um 49.090um 25.100um
paint metal3
box 48.790um 24.800um 49.190um 25.200um
paint metal3
box 48.890um 24.900um 49.090um 25.100um
paint via3
box 48.790um 24.800um 49.190um 25.200um
paint metal4
box 36.380um 22.880um 36.620um 23.120um
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
box 36.400um 22.900um 37.250um 23.100um
paint metal4
box 36.950um 22.800um 37.350um 23.200um
paint metal3
box 37.050um 22.900um 37.250um 23.100um
paint via3
box 36.950um 22.800um 37.350um 23.200um
paint metal4
box 37.050um 22.900um 37.250um 25.100um
paint metal3
box 36.950um 24.800um 37.350um 25.200um
paint metal3
box 37.050um 24.900um 37.250um 25.100um
paint via3
box 36.950um 24.800um 37.350um 25.200um
paint metal4
box 22.020um 3.830um 22.260um 4.070um
paint metal1
box 22.040um 3.850um 22.240um 4.050um
paint via1
box 21.940um 3.750um 22.340um 4.150um
paint metal2
box 21.940um 3.750um 22.340um 4.150um
paint metal2
box 22.040um 3.850um 22.240um 4.050um
paint via2
box 21.940um 3.750um 22.340um 4.150um
paint metal3
box 21.940um 3.750um 22.340um 4.150um
paint metal3
box 22.040um 3.850um 22.240um 4.050um
paint via3
box 21.940um 3.750um 22.340um 4.150um
paint metal4
box 22.040um 3.150um 22.240um 4.050um
paint metal4
box 22.040um 3.150um 38.490um 3.350um
paint metal4
box 38.190um 3.050um 38.590um 3.450um
paint metal3
box 38.290um 3.150um 38.490um 3.350um
paint via3
box 38.190um 3.050um 38.590um 3.450um
paint metal4
box 38.290um 3.150um 38.490um 25.100um
paint metal3
box 38.190um 24.800um 38.590um 25.200um
paint metal3
box 38.290um 24.900um 38.490um 25.100um
paint via3
box 38.190um 24.800um 38.590um 25.200um
paint metal4
# net net12  trunk=-21.000
box 68.365um -5.710um 68.605um -5.470um
paint metal1
box 68.385um -5.690um 68.585um -5.490um
paint via1
box 68.285um -5.790um 68.685um -5.390um
paint metal2
box 68.285um -5.790um 68.685um -5.390um
paint metal2
box 68.385um -5.690um 68.585um -5.490um
paint via2
box 68.285um -5.790um 68.685um -5.390um
paint metal3
box 68.285um -5.790um 68.685um -5.390um
paint metal3
box 68.385um -5.690um 68.585um -5.490um
paint via3
box 68.285um -5.790um 68.685um -5.390um
paint metal4
box 68.385um -5.690um 69.885um -5.490um
paint metal4
box 69.585um -5.790um 69.985um -5.390um
paint metal3
box 69.685um -5.690um 69.885um -5.490um
paint via3
box 69.585um -5.790um 69.985um -5.390um
paint metal4
box 69.685um -21.100um 69.885um -5.490um
paint metal3
box 69.585um -21.200um 69.985um -20.800um
paint metal3
box 69.685um -21.100um 69.885um -20.900um
paint via3
box 69.585um -21.200um 69.985um -20.800um
paint metal4
box 65.025um -5.620um 65.265um -5.380um
paint metal1
box 65.045um -5.600um 65.245um -5.400um
paint via1
box 64.945um -5.700um 65.345um -5.300um
paint metal2
box 64.945um -5.700um 65.345um -5.300um
paint metal2
box 65.045um -5.600um 65.245um -5.400um
paint via2
box 64.945um -5.700um 65.345um -5.300um
paint metal3
box 64.945um -5.700um 65.345um -5.300um
paint metal3
box 65.045um -5.600um 65.245um -5.400um
paint via3
box 64.945um -5.700um 65.345um -5.300um
paint metal4
box 65.045um -5.600um 66.545um -5.400um
paint metal4
box 66.245um -5.700um 66.645um -5.300um
paint metal3
box 66.345um -5.600um 66.545um -5.400um
paint via3
box 66.245um -5.700um 66.645um -5.300um
paint metal4
box 66.345um -21.100um 66.545um -5.400um
paint metal3
box 66.245um -21.200um 66.645um -20.800um
paint metal3
box 66.345um -21.100um 66.545um -20.900um
paint via3
box 66.245um -21.200um 66.645um -20.800um
paint metal4
box 62.245um -5.590um 62.485um -5.350um
paint metal1
box 62.265um -5.570um 62.465um -5.370um
paint via1
box 62.165um -5.670um 62.565um -5.270um
paint metal2
box 62.165um -5.670um 62.565um -5.270um
paint metal2
box 62.265um -5.570um 62.465um -5.370um
paint via2
box 62.165um -5.670um 62.565um -5.270um
paint metal3
box 62.165um -5.670um 62.565um -5.270um
paint metal3
box 62.265um -5.570um 62.465um -5.370um
paint via3
box 62.165um -5.670um 62.565um -5.270um
paint metal4
box 62.265um -5.570um 63.765um -5.370um
paint metal4
box 63.465um -5.670um 63.865um -5.270um
paint metal3
box 63.565um -5.570um 63.765um -5.370um
paint via3
box 63.465um -5.670um 63.865um -5.270um
paint metal4
box 63.565um -21.100um 63.765um -5.370um
paint metal3
box 63.465um -21.200um 63.865um -20.800um
paint metal3
box 63.565um -21.100um 63.765um -20.900um
paint via3
box 63.465um -21.200um 63.865um -20.800um
paint metal4
box 59.365um -7.100um 59.605um -6.860um
paint metal1
box 59.385um -7.080um 59.585um -6.880um
paint via1
box 59.285um -7.180um 59.685um -6.780um
paint metal2
box 59.285um -7.180um 59.685um -6.780um
paint metal2
box 59.385um -7.080um 59.585um -6.880um
paint via2
box 59.285um -7.180um 59.685um -6.780um
paint metal3
box 59.285um -7.180um 59.685um -6.780um
paint metal3
box 59.385um -7.080um 59.585um -6.880um
paint via3
box 59.285um -7.180um 59.685um -6.780um
paint metal4
box 59.385um -7.080um 60.235um -6.880um
paint metal4
box 59.935um -7.180um 60.335um -6.780um
paint metal3
box 60.035um -7.080um 60.235um -6.880um
paint via3
box 59.935um -7.180um 60.335um -6.780um
paint metal4
box 60.035um -21.100um 60.235um -6.880um
paint metal3
box 59.935um -21.200um 60.335um -20.800um
paint metal3
box 60.035um -21.100um 60.235um -20.900um
paint via3
box 59.935um -21.200um 60.335um -20.800um
paint metal4
box 59.050um -7.880um 59.290um -7.640um
paint metal1
box 59.070um -7.860um 59.270um -7.660um
paint via1
box 58.970um -7.960um 59.370um -7.560um
paint metal2
box 58.970um -7.960um 59.370um -7.560um
paint metal2
box 59.070um -7.860um 59.270um -7.660um
paint via2
box 58.970um -7.960um 59.370um -7.560um
paint metal3
box 58.970um -7.960um 59.370um -7.560um
paint metal3
box 59.070um -7.860um 59.270um -7.660um
paint via3
box 58.970um -7.960um 59.370um -7.560um
paint metal4
box 56.470um -7.860um 59.270um -7.660um
paint metal4
box 56.370um -7.960um 56.770um -7.560um
paint metal3
box 56.470um -7.860um 56.670um -7.660um
paint via3
box 56.370um -7.960um 56.770um -7.560um
paint metal4
box 56.470um -21.100um 56.670um -7.660um
paint metal3
box 56.370um -21.200um 56.770um -20.800um
paint metal3
box 56.470um -21.100um 56.670um -20.900um
paint via3
box 56.370um -21.200um 56.770um -20.800um
paint metal4
box 59.000um -13.510um 59.240um -13.270um
paint metal1
box 59.020um -13.490um 59.220um -13.290um
paint via1
box 58.920um -13.590um 59.320um -13.190um
paint metal2
box 58.920um -13.590um 59.320um -13.190um
paint metal2
box 59.020um -13.490um 59.220um -13.290um
paint via2
box 58.920um -13.590um 59.320um -13.190um
paint metal3
box 58.920um -13.590um 59.320um -13.190um
paint metal3
box 59.020um -13.490um 59.220um -13.290um
paint via3
box 58.920um -13.590um 59.320um -13.190um
paint metal4
box 55.120um -13.490um 59.220um -13.290um
paint metal4
box 55.020um -13.590um 55.420um -13.190um
paint metal3
box 55.120um -13.490um 55.320um -13.290um
paint via3
box 55.020um -13.590um 55.420um -13.190um
paint metal4
box 55.120um -21.100um 55.320um -13.290um
paint metal3
box 55.020um -21.200um 55.420um -20.800um
paint metal3
box 55.120um -21.100um 55.320um -20.900um
paint via3
box 55.020um -21.200um 55.420um -20.800um
paint metal4
# net net6  trunk=-22.000
box 71.705um -11.380um 71.945um -11.140um
paint metal1
box 71.725um -11.360um 71.925um -11.160um
paint via1
box 71.625um -11.460um 72.025um -11.060um
paint metal2
box 71.625um -11.460um 72.025um -11.060um
paint metal2
box 71.725um -11.360um 71.925um -11.160um
paint via2
box 71.625um -11.460um 72.025um -11.060um
paint metal3
box 71.625um -11.460um 72.025um -11.060um
paint metal3
box 71.725um -11.360um 71.925um -11.160um
paint via3
box 71.625um -11.460um 72.025um -11.060um
paint metal4
box 71.625um -11.460um 72.025um -11.060um
paint metal3
box 71.725um -11.360um 71.925um -11.160um
paint via3
box 71.625um -11.460um 72.025um -11.060um
paint metal4
box 71.725um -22.100um 71.925um -11.160um
paint metal3
box 71.625um -22.200um 72.025um -21.800um
paint metal3
box 71.725um -22.100um 71.925um -21.900um
paint via3
box 71.625um -22.200um 72.025um -21.800um
paint metal4
box 71.675um -8.830um 71.915um -8.590um
paint metal1
box 71.695um -8.810um 71.895um -8.610um
paint via1
box 71.595um -8.910um 71.995um -8.510um
paint metal2
box 71.595um -8.910um 71.995um -8.510um
paint metal2
box 71.695um -8.810um 71.895um -8.610um
paint via2
box 71.595um -8.910um 71.995um -8.510um
paint metal3
box 71.595um -8.910um 71.995um -8.510um
paint metal3
box 71.695um -8.810um 71.895um -8.610um
paint via3
box 71.595um -8.910um 71.995um -8.510um
paint metal4
box 71.695um -8.810um 73.195um -8.610um
paint metal4
box 72.895um -8.910um 73.295um -8.510um
paint metal3
box 72.995um -8.810um 73.195um -8.610um
paint via3
box 72.895um -8.910um 73.295um -8.510um
paint metal4
box 72.995um -22.100um 73.195um -8.610um
paint metal3
box 72.895um -22.200um 73.295um -21.800um
paint metal3
box 72.995um -22.100um 73.195um -21.900um
paint via3
box 72.895um -22.200um 73.295um -21.800um
paint metal4
box 67.930um -9.520um 68.170um -9.280um
paint metal1
box 67.950um -9.500um 68.150um -9.300um
paint via1
box 67.850um -9.600um 68.250um -9.200um
paint metal2
box 67.850um -9.600um 68.250um -9.200um
paint metal2
box 67.950um -9.500um 68.150um -9.300um
paint via2
box 67.850um -9.600um 68.250um -9.200um
paint metal3
box 67.850um -9.600um 68.250um -9.200um
paint metal3
box 67.950um -9.500um 68.150um -9.300um
paint via3
box 67.850um -9.600um 68.250um -9.200um
paint metal4
box 67.950um -9.500um 74.000um -9.300um
paint metal4
box 73.700um -9.600um 74.100um -9.200um
paint metal3
box 73.800um -9.500um 74.000um -9.300um
paint via3
box 73.700um -9.600um 74.100um -9.200um
paint metal4
box 73.800um -22.100um 74.000um -9.300um
paint metal3
box 73.700um -22.200um 74.100um -21.800um
paint metal3
box 73.800um -22.100um 74.000um -21.900um
paint via3
box 73.700um -22.200um 74.100um -21.800um
paint metal4
box 67.870um -12.710um 68.110um -12.470um
paint metal1
box 67.890um -12.690um 68.090um -12.490um
paint via1
box 67.790um -12.790um 68.190um -12.390um
paint metal2
box 67.790um -12.790um 68.190um -12.390um
paint metal2
box 67.890um -12.690um 68.090um -12.490um
paint via2
box 67.790um -12.790um 68.190um -12.390um
paint metal3
box 67.790um -12.790um 68.190um -12.390um
paint metal3
box 67.890um -12.690um 68.090um -12.490um
paint via3
box 67.790um -12.790um 68.190um -12.390um
paint metal4
box 67.890um -12.690um 75.240um -12.490um
paint metal4
box 74.940um -12.790um 75.340um -12.390um
paint metal3
box 75.040um -12.690um 75.240um -12.490um
paint via3
box 74.940um -12.790um 75.340um -12.390um
paint metal4
box 75.040um -22.100um 75.240um -12.490um
paint metal3
box 74.940um -22.200um 75.340um -21.800um
paint metal3
box 75.040um -22.100um 75.240um -21.900um
paint via3
box 74.940um -22.200um 75.340um -21.800um
paint metal4
box 62.305um -8.680um 62.545um -8.440um
paint metal1
box 62.325um -8.660um 62.525um -8.460um
paint via1
box 62.225um -8.760um 62.625um -8.360um
paint metal2
box 62.225um -8.760um 62.625um -8.360um
paint metal2
box 62.325um -8.660um 62.525um -8.460um
paint via2
box 62.225um -8.760um 62.625um -8.360um
paint metal3
box 62.225um -8.760um 62.625um -8.360um
paint metal3
box 62.325um -8.660um 62.525um -8.460um
paint via3
box 62.225um -8.760um 62.625um -8.360um
paint metal4
box 53.875um -8.660um 62.525um -8.460um
paint metal4
box 53.775um -8.760um 54.175um -8.360um
paint metal3
box 53.875um -8.660um 54.075um -8.460um
paint via3
box 53.775um -8.760um 54.175um -8.360um
paint metal4
box 53.875um -22.100um 54.075um -8.460um
paint metal3
box 53.775um -22.200um 54.175um -21.800um
paint metal3
box 53.875um -22.100um 54.075um -21.900um
paint via3
box 53.775um -22.200um 54.175um -21.800um
paint metal4
box 62.215um -12.090um 62.455um -11.850um
paint metal1
box 62.235um -12.070um 62.435um -11.870um
paint via1
box 62.135um -12.170um 62.535um -11.770um
paint metal2
box 62.135um -12.170um 62.535um -11.770um
paint metal2
box 62.235um -12.070um 62.435um -11.870um
paint via2
box 62.135um -12.170um 62.535um -11.770um
paint metal3
box 62.135um -12.170um 62.535um -11.770um
paint metal3
box 62.235um -12.070um 62.435um -11.870um
paint via3
box 62.135um -12.170um 62.535um -11.770um
paint metal4
box 62.235um -12.070um 62.435um -11.520um
paint metal4
box 51.185um -11.720um 62.435um -11.520um
paint metal4
box 51.085um -11.820um 51.485um -11.420um
paint metal3
box 51.185um -11.720um 51.385um -11.520um
paint via3
box 51.085um -11.820um 51.485um -11.420um
paint metal4
box 51.185um -22.100um 51.385um -11.520um
paint metal3
box 51.085um -22.200um 51.485um -21.800um
paint metal3
box 51.185um -22.100um 51.385um -21.900um
paint via3
box 51.085um -22.200um 51.485um -21.800um
paint metal4
# net net7  trunk=-23.000
box 68.245um -8.740um 68.485um -8.500um
paint metal1
box 68.265um -8.720um 68.465um -8.520um
paint via1
box 68.165um -8.820um 68.565um -8.420um
paint metal2
box 68.165um -8.820um 68.565um -8.420um
paint metal2
box 68.265um -8.720um 68.465um -8.520um
paint via2
box 68.165um -8.820um 68.565um -8.420um
paint metal3
box 68.165um -8.820um 68.565um -8.420um
paint metal3
box 68.265um -8.720um 68.465um -8.520um
paint via3
box 68.165um -8.820um 68.565um -8.420um
paint metal4
box 68.265um -8.720um 68.465um -7.820um
paint metal4
box 68.265um -8.020um 76.915um -7.820um
paint metal4
box 76.615um -8.120um 77.015um -7.720um
paint metal3
box 76.715um -8.020um 76.915um -7.820um
paint via3
box 76.615um -8.120um 77.015um -7.720um
paint metal4
box 76.715um -23.100um 76.915um -7.820um
paint metal3
box 76.615um -23.200um 77.015um -22.800um
paint metal3
box 76.715um -23.100um 76.915um -22.900um
paint via3
box 76.615um -23.200um 77.015um -22.800um
paint metal4
box 68.185um -12.120um 68.425um -11.880um
paint metal1
box 68.205um -12.100um 68.405um -11.900um
paint via1
box 68.105um -12.200um 68.505um -11.800um
paint metal2
box 68.105um -12.200um 68.505um -11.800um
paint metal2
box 68.205um -12.100um 68.405um -11.900um
paint via2
box 68.105um -12.200um 68.505um -11.800um
paint metal3
box 68.105um -12.200um 68.505um -11.800um
paint metal3
box 68.205um -12.100um 68.405um -11.900um
paint via3
box 68.105um -12.200um 68.505um -11.800um
paint metal4
box 68.205um -12.100um 78.155um -11.900um
paint metal4
box 77.855um -12.200um 78.255um -11.800um
paint metal3
box 77.955um -12.100um 78.155um -11.900um
paint via3
box 77.855um -12.200um 78.255um -11.800um
paint metal4
box 77.955um -23.100um 78.155um -11.900um
paint metal3
box 77.855um -23.200um 78.255um -22.800um
paint metal3
box 77.955um -23.100um 78.155um -22.900um
paint via3
box 77.855um -23.200um 78.255um -22.800um
paint metal4
box 64.770um -9.430um 65.010um -9.190um
paint metal1
box 64.790um -9.410um 64.990um -9.210um
paint via1
box 64.690um -9.510um 65.090um -9.110um
paint metal2
box 64.690um -9.510um 65.090um -9.110um
paint metal2
box 64.790um -9.410um 64.990um -9.210um
paint via2
box 64.690um -9.510um 65.090um -9.110um
paint metal3
box 64.690um -9.510um 65.090um -9.110um
paint metal3
box 64.790um -9.410um 64.990um -9.210um
paint via3
box 64.690um -9.510um 65.090um -9.110um
paint metal4
box 64.790um -10.110um 64.990um -9.210um
paint metal4
box 64.790um -10.110um 79.290um -9.910um
paint metal4
box 78.990um -10.210um 79.390um -9.810um
paint metal3
box 79.090um -10.110um 79.290um -9.910um
paint via3
box 78.990um -10.210um 79.390um -9.810um
paint metal4
box 79.090um -23.100um 79.290um -9.910um
paint metal3
box 78.990um -23.200um 79.390um -22.800um
paint metal3
box 79.090um -23.100um 79.290um -22.900um
paint via3
box 78.990um -23.200um 79.390um -22.800um
paint metal4
box 64.710um -12.770um 64.950um -12.530um
paint metal1
box 64.730um -12.750um 64.930um -12.550um
paint via1
box 64.630um -12.850um 65.030um -12.450um
paint metal2
box 64.630um -12.850um 65.030um -12.450um
paint metal2
box 64.730um -12.750um 64.930um -12.550um
paint via2
box 64.630um -12.850um 65.030um -12.450um
paint metal3
box 64.630um -12.850um 65.030um -12.450um
paint metal3
box 64.730um -12.750um 64.930um -12.550um
paint via3
box 64.630um -12.850um 65.030um -12.450um
paint metal4
box 64.730um -14.150um 64.930um -12.550um
paint metal4
box 49.780um -14.150um 64.930um -13.950um
paint metal4
box 49.680um -14.250um 50.080um -13.850um
paint metal3
box 49.780um -14.150um 49.980um -13.950um
paint via3
box 49.680um -14.250um 50.080um -13.850um
paint metal4
box 49.780um -23.100um 49.980um -13.950um
paint metal3
box 49.680um -23.200um 50.080um -22.800um
paint metal3
box 49.780um -23.100um 49.980um -22.900um
paint via3
box 49.680um -23.200um 50.080um -22.800um
paint metal4
# net net9  trunk=-24.000
box 65.085um -8.650um 65.325um -8.410um
paint metal1
box 65.105um -8.630um 65.305um -8.430um
paint via1
box 65.005um -8.730um 65.405um -8.330um
paint metal2
box 65.005um -8.730um 65.405um -8.330um
paint metal2
box 65.105um -8.630um 65.305um -8.430um
paint via2
box 65.005um -8.730um 65.405um -8.330um
paint metal3
box 65.005um -8.730um 65.405um -8.330um
paint metal3
box 65.105um -8.630um 65.305um -8.430um
paint via3
box 65.005um -8.730um 65.405um -8.330um
paint metal4
box 65.105um -8.630um 65.305um -7.030um
paint metal4
box 65.105um -7.230um 80.905um -7.030um
paint metal4
box 80.605um -7.330um 81.005um -6.930um
paint metal3
box 80.705um -7.230um 80.905um -7.030um
paint via3
box 80.605um -7.330um 81.005um -6.930um
paint metal4
box 80.705um -24.100um 80.905um -7.030um
paint metal3
box 80.605um -24.200um 81.005um -23.800um
paint metal3
box 80.705um -24.100um 80.905um -23.900um
paint via3
box 80.605um -24.200um 81.005um -23.800um
paint metal4
box 65.025um -12.180um 65.265um -11.940um
paint metal1
box 65.045um -12.160um 65.245um -11.960um
paint via1
box 64.945um -12.260um 65.345um -11.860um
paint metal2
box 64.945um -12.260um 65.345um -11.860um
paint metal2
box 65.045um -12.160um 65.245um -11.960um
paint via2
box 64.945um -12.260um 65.345um -11.860um
paint metal3
box 64.945um -12.260um 65.345um -11.860um
paint metal3
box 65.045um -12.160um 65.245um -11.960um
paint via3
box 64.945um -12.260um 65.345um -11.860um
paint metal4
box 65.045um -12.160um 65.245um -10.560um
paint metal4
box 65.045um -10.760um 82.145um -10.560um
paint metal4
box 81.845um -10.860um 82.245um -10.460um
paint metal3
box 81.945um -10.760um 82.145um -10.560um
paint via3
box 81.845um -10.860um 82.245um -10.460um
paint metal4
box 81.945um -24.100um 82.145um -10.560um
paint metal3
box 81.845um -24.200um 82.245um -23.800um
paint metal3
box 81.945um -24.100um 82.145um -23.900um
paint via3
box 81.845um -24.200um 82.245um -23.800um
paint metal4
box 61.990um -9.460um 62.230um -9.220um
paint metal1
box 62.010um -9.440um 62.210um -9.240um
paint via1
box 61.910um -9.540um 62.310um -9.140um
paint metal2
box 61.910um -9.540um 62.310um -9.140um
paint metal2
box 62.010um -9.440um 62.210um -9.240um
paint via2
box 61.910um -9.540um 62.310um -9.140um
paint metal3
box 61.910um -9.540um 62.310um -9.140um
paint metal3
box 62.010um -9.440um 62.210um -9.240um
paint via3
box 61.910um -9.540um 62.310um -9.140um
paint metal4
box 47.060um -9.440um 62.210um -9.240um
paint metal4
box 46.960um -9.540um 47.360um -9.140um
paint metal3
box 47.060um -9.440um 47.260um -9.240um
paint via3
box 46.960um -9.540um 47.360um -9.140um
paint metal4
box 47.060um -24.100um 47.260um -9.240um
paint metal3
box 46.960um -24.200um 47.360um -23.800um
paint metal3
box 47.060um -24.100um 47.260um -23.900um
paint via3
box 46.960um -24.200um 47.360um -23.800um
paint metal4
box 61.900um -12.680um 62.140um -12.440um
paint metal1
box 61.920um -12.660um 62.120um -12.460um
paint via1
box 61.820um -12.760um 62.220um -12.360um
paint metal2
box 61.820um -12.760um 62.220um -12.360um
paint metal2
box 61.920um -12.660um 62.120um -12.460um
paint via2
box 61.820um -12.760um 62.220um -12.360um
paint metal3
box 61.820um -12.760um 62.220um -12.360um
paint metal3
box 61.920um -12.660um 62.120um -12.460um
paint via3
box 61.820um -12.760um 62.220um -12.360um
paint metal4
box 61.820um -12.760um 62.220um -12.360um
paint metal4
box 61.920um -12.660um 62.120um -12.460um
paint via4
box 61.820um -12.760um 62.220um -12.360um
paint metal5
box 61.920um -12.660um 95.270um -12.460um
paint metal5
box 94.970um -12.760um 95.370um -12.360um
paint metal4
box 95.070um -12.660um 95.270um -12.460um
paint via4
box 94.970um -12.760um 95.370um -12.360um
paint metal5
box 94.970um -12.760um 95.370um -12.360um
paint metal3
box 95.070um -12.660um 95.270um -12.460um
paint via3
box 94.970um -12.760um 95.370um -12.360um
paint metal4
box 95.070um -24.100um 95.270um -12.460um
paint metal3
box 94.970um -24.200um 95.370um -23.800um
paint metal3
box 95.070um -24.100um 95.270um -23.900um
paint via3
box 94.970um -24.200um 95.370um -23.800um
paint metal4
# net out  trunk=-25.000
box 74.380um -10.820um 74.620um -10.580um
paint metal1
box 74.400um -10.800um 74.600um -10.600um
paint via1
box 74.300um -10.900um 74.700um -10.500um
paint metal2
box 74.300um -10.900um 74.700um -10.500um
paint metal2
box 74.400um -10.800um 74.600um -10.600um
paint via2
box 74.300um -10.900um 74.700um -10.500um
paint metal3
box 74.300um -10.900um 74.700um -10.500um
paint metal3
box 74.400um -10.800um 74.600um -10.600um
paint via3
box 74.300um -10.900um 74.700um -10.500um
paint metal4
box 74.300um -10.900um 74.700um -10.500um
paint metal4
box 74.400um -10.800um 74.600um -10.600um
paint via4
box 74.300um -10.900um 74.700um -10.500um
paint metal5
box 74.400um -10.800um 96.050um -10.600um
paint metal5
box 95.750um -10.900um 96.150um -10.500um
paint metal4
box 95.850um -10.800um 96.050um -10.600um
paint via4
box 95.750um -10.900um 96.150um -10.500um
paint metal5
box 95.750um -10.900um 96.150um -10.500um
paint metal3
box 95.850um -10.800um 96.050um -10.600um
paint via3
box 95.750um -10.900um 96.150um -10.500um
paint metal4
box 95.850um -25.100um 96.050um -10.600um
paint metal3
box 95.750um -25.200um 96.150um -24.800um
paint metal3
box 95.850um -25.100um 96.050um -24.900um
paint via3
box 95.750um -25.200um 96.150um -24.800um
paint metal4
box 71.390um -11.970um 71.630um -11.730um
paint metal1
box 71.410um -11.950um 71.610um -11.750um
paint via1
box 71.310um -12.050um 71.710um -11.650um
paint metal2
box 71.310um -12.050um 71.710um -11.650um
paint metal2
box 71.410um -11.950um 71.610um -11.750um
paint via2
box 71.310um -12.050um 71.710um -11.650um
paint metal3
box 71.310um -12.050um 71.710um -11.650um
paint metal3
box 71.410um -11.950um 71.610um -11.750um
paint via3
box 71.310um -12.050um 71.710um -11.650um
paint metal4
box 71.310um -12.050um 71.710um -11.650um
paint metal4
box 71.410um -11.950um 71.610um -11.750um
paint via4
box 71.310um -12.050um 71.710um -11.650um
paint metal5
box 71.410um -11.950um 97.610um -11.750um
paint metal5
box 97.310um -12.050um 97.710um -11.650um
paint metal4
box 97.410um -11.950um 97.610um -11.750um
paint via4
box 97.310um -12.050um 97.710um -11.650um
paint metal5
box 97.310um -12.050um 97.710um -11.650um
paint metal3
box 97.410um -11.950um 97.610um -11.750um
paint via3
box 97.310um -12.050um 97.710um -11.650um
paint metal4
box 97.410um -25.100um 97.610um -11.750um
paint metal3
box 97.310um -25.200um 97.710um -24.800um
paint metal3
box 97.410um -25.100um 97.610um -24.900um
paint via3
box 97.310um -25.200um 97.710um -24.800um
paint metal4
box 71.360um -9.610um 71.600um -9.370um
paint metal1
box 71.380um -9.590um 71.580um -9.390um
paint via1
box 71.280um -9.690um 71.680um -9.290um
paint metal2
box 71.280um -9.690um 71.680um -9.290um
paint metal2
box 71.380um -9.590um 71.580um -9.390um
paint via2
box 71.280um -9.690um 71.680um -9.290um
paint metal3
box 71.380um -9.590um 71.580um -6.240um
paint metal3
box 71.380um -6.440um 83.280um -6.240um
paint metal3
box 83.080um -25.100um 83.280um -6.240um
paint metal3
box 82.980um -25.200um 83.380um -24.800um
paint metal3
box 83.080um -25.100um 83.280um -24.900um
paint via3
box 82.980um -25.200um 83.380um -24.800um
paint metal4
# net net10  trunk=-26.000
box 61.800um -15.460um 62.040um -15.220um
paint metal1
box 61.820um -15.440um 62.020um -15.240um
paint via1
box 61.720um -15.540um 62.120um -15.140um
paint metal2
box 61.720um -15.540um 62.120um -15.140um
paint metal2
box 61.820um -15.440um 62.020um -15.240um
paint via2
box 61.720um -15.540um 62.120um -15.140um
paint metal3
box 61.720um -15.540um 62.120um -15.140um
paint metal3
box 61.820um -15.440um 62.020um -15.240um
paint via3
box 61.720um -15.540um 62.120um -15.140um
paint metal4
box 46.220um -15.440um 62.020um -15.240um
paint metal4
box 46.120um -15.540um 46.520um -15.140um
paint metal3
box 46.220um -15.440um 46.420um -15.240um
paint via3
box 46.120um -15.540um 46.520um -15.140um
paint metal4
box 46.220um -26.100um 46.420um -15.240um
paint metal3
box 46.120um -26.200um 46.520um -25.800um
paint metal3
box 46.220um -26.100um 46.420um -25.900um
paint via3
box 46.120um -26.200um 46.520um -25.800um
paint metal4
# net net11  trunk=-27.000
box 68.560um -9.520um 68.800um -9.280um
paint metal1
box 68.580um -9.500um 68.780um -9.300um
paint via1
box 68.480um -9.600um 68.880um -9.200um
paint metal2
box 68.480um -9.600um 68.880um -9.200um
paint metal2
box 68.580um -9.500um 68.780um -9.300um
paint via2
box 68.480um -9.600um 68.880um -9.200um
paint metal3
box 68.480um -9.600um 68.880um -9.200um
paint metal3
box 68.580um -9.500um 68.780um -9.300um
paint via3
box 68.480um -9.600um 68.880um -9.200um
paint metal4
box 68.480um -9.600um 68.880um -9.200um
paint metal4
box 68.580um -9.500um 68.780um -9.300um
paint via4
box 68.480um -9.600um 68.880um -9.200um
paint metal5
box 68.580um -9.500um 98.680um -9.300um
paint metal5
box 98.380um -9.600um 98.780um -9.200um
paint metal4
box 98.480um -9.500um 98.680um -9.300um
paint via4
box 98.380um -9.600um 98.780um -9.200um
paint metal5
box 98.380um -9.600um 98.780um -9.200um
paint metal3
box 98.480um -9.500um 98.680um -9.300um
paint via3
box 98.380um -9.600um 98.780um -9.200um
paint metal4
box 98.480um -27.100um 98.680um -9.300um
paint metal3
box 98.380um -27.200um 98.780um -26.800um
paint metal3
box 98.480um -27.100um 98.680um -26.900um
paint via3
box 98.380um -27.200um 98.780um -26.800um
paint metal4
box 68.050um -6.490um 68.290um -6.250um
paint metal1
box 68.070um -6.470um 68.270um -6.270um
paint via1
box 67.970um -6.570um 68.370um -6.170um
paint metal2
box 67.970um -6.570um 68.370um -6.170um
paint metal2
box 68.070um -6.470um 68.270um -6.270um
paint via2
box 67.970um -6.570um 68.370um -6.170um
paint metal3
box 67.970um -6.570um 68.370um -6.170um
paint metal3
box 68.070um -6.470um 68.270um -6.270um
paint via3
box 67.970um -6.570um 68.370um -6.170um
paint metal4
box 68.070um -6.470um 84.520um -6.270um
paint metal4
box 84.220um -6.570um 84.620um -6.170um
paint metal3
box 84.320um -6.470um 84.520um -6.270um
paint via3
box 84.220um -6.570um 84.620um -6.170um
paint metal4
box 84.320um -27.100um 84.520um -6.270um
paint metal3
box 84.220um -27.200um 84.620um -26.800um
paint metal3
box 84.320um -27.100um 84.520um -26.900um
paint via3
box 84.220um -27.200um 84.620um -26.800um
paint metal4
# net net13  trunk=-28.000
box 65.400um -9.430um 65.640um -9.190um
paint metal1
box 65.420um -9.410um 65.620um -9.210um
paint via1
box 65.320um -9.510um 65.720um -9.110um
paint metal2
box 65.320um -9.510um 65.720um -9.110um
paint metal2
box 65.420um -9.410um 65.620um -9.210um
paint via2
box 65.320um -9.510um 65.720um -9.110um
paint metal3
box 65.320um -9.510um 65.720um -9.110um
paint metal3
box 65.420um -9.410um 65.620um -9.210um
paint via3
box 65.320um -9.510um 65.720um -9.110um
paint metal4
box 65.320um -9.510um 65.720um -9.110um
paint metal4
box 65.420um -9.410um 65.620um -9.210um
paint via4
box 65.320um -9.510um 65.720um -9.110um
paint metal5
box 65.420um -9.410um 65.620um -8.510um
paint metal5
box 65.420um -8.710um 100.070um -8.510um
paint metal5
box 99.770um -8.810um 100.170um -8.410um
paint metal4
box 99.870um -8.710um 100.070um -8.510um
paint via4
box 99.770um -8.810um 100.170um -8.410um
paint metal5
box 99.770um -8.810um 100.170um -8.410um
paint metal3
box 99.870um -8.710um 100.070um -8.510um
paint via3
box 99.770um -8.810um 100.170um -8.410um
paint metal4
box 99.870um -28.100um 100.070um -8.510um
paint metal3
box 99.770um -28.200um 100.170um -27.800um
paint metal3
box 99.870um -28.100um 100.070um -27.900um
paint via3
box 99.770um -28.200um 100.170um -27.800um
paint metal4
box 64.710um -6.400um 64.950um -6.160um
paint metal1
box 64.730um -6.380um 64.930um -6.180um
paint via1
box 64.630um -6.480um 65.030um -6.080um
paint metal2
box 64.630um -6.480um 65.030um -6.080um
paint metal2
box 64.730um -6.380um 64.930um -6.180um
paint via2
box 64.630um -6.480um 65.030um -6.080um
paint metal3
box 64.630um -6.480um 65.030um -6.080um
paint metal3
box 64.730um -6.380um 64.930um -6.180um
paint via3
box 64.630um -6.480um 65.030um -6.080um
paint metal4
box 44.580um -6.380um 64.930um -6.180um
paint metal4
box 44.480um -6.480um 44.880um -6.080um
paint metal3
box 44.580um -6.380um 44.780um -6.180um
paint via3
box 44.480um -6.480um 44.880um -6.080um
paint metal4
box 44.580um -28.100um 44.780um -6.180um
paint metal3
box 44.480um -28.200um 44.880um -27.800um
paint metal3
box 44.580um -28.100um 44.780um -27.900um
paint via3
box 44.480um -28.200um 44.880um -27.800um
paint metal4
# net net14  trunk=-29.000
box 62.620um -9.460um 62.860um -9.220um
paint metal1
box 62.640um -9.440um 62.840um -9.240um
paint via1
box 62.540um -9.540um 62.940um -9.140um
paint metal2
box 62.540um -9.540um 62.940um -9.140um
paint metal2
box 62.640um -9.440um 62.840um -9.240um
paint via2
box 62.540um -9.540um 62.940um -9.140um
paint metal3
box 62.540um -9.540um 62.940um -9.140um
paint metal3
box 62.640um -9.440um 62.840um -9.240um
paint via3
box 62.540um -9.540um 62.940um -9.140um
paint metal4
box 62.640um -10.140um 62.840um -9.240um
paint metal4
box 43.140um -10.140um 62.840um -9.940um
paint metal4
box 43.040um -10.240um 43.440um -9.840um
paint metal3
box 43.140um -10.140um 43.340um -9.940um
paint via3
box 43.040um -10.240um 43.440um -9.840um
paint metal4
box 43.140um -29.100um 43.340um -9.940um
paint metal3
box 43.040um -29.200um 43.440um -28.800um
paint metal3
box 43.140um -29.100um 43.340um -28.900um
paint via3
box 43.040um -29.200um 43.440um -28.800um
paint metal4
box 61.930um -6.370um 62.170um -6.130um
paint metal1
box 61.950um -6.350um 62.150um -6.150um
paint via1
box 61.850um -6.450um 62.250um -6.050um
paint metal2
box 61.850um -6.450um 62.250um -6.050um
paint metal2
box 61.950um -6.350um 62.150um -6.150um
paint via2
box 61.850um -6.450um 62.250um -6.050um
paint metal3
box 61.850um -6.450um 62.250um -6.050um
paint metal3
box 61.950um -6.350um 62.150um -6.150um
paint via3
box 61.850um -6.450um 62.250um -6.050um
paint metal4
box 61.850um -6.450um 62.250um -6.050um
paint metal4
box 61.950um -6.350um 62.150um -6.150um
paint via4
box 61.850um -6.450um 62.250um -6.050um
paint metal5
box 61.950um -6.350um 101.800um -6.150um
paint metal5
box 101.500um -6.450um 101.900um -6.050um
paint metal4
box 101.600um -6.350um 101.800um -6.150um
paint via4
box 101.500um -6.450um 101.900um -6.050um
paint metal5
box 101.500um -6.450um 101.900um -6.050um
paint metal3
box 101.600um -6.350um 101.800um -6.150um
paint via3
box 101.500um -6.450um 101.900um -6.050um
paint metal4
box 101.600um -29.100um 101.800um -6.150um
paint metal3
box 101.500um -29.200um 101.900um -28.800um
paint metal3
box 101.600um -29.100um 101.800um -28.900um
paint via3
box 101.500um -29.200um 101.900um -28.800um
paint metal4
# net net5  trunk=-30.000
box 67.930um -15.710um 68.170um -15.470um
paint metal1
box 67.950um -15.690um 68.150um -15.490um
paint via1
box 67.850um -15.790um 68.250um -15.390um
paint metal2
box 67.850um -15.790um 68.250um -15.390um
paint metal2
box 67.950um -15.690um 68.150um -15.490um
paint via2
box 67.850um -15.790um 68.250um -15.390um
paint metal3
box 67.850um -15.790um 68.250um -15.390um
paint metal3
box 67.950um -15.690um 68.150um -15.490um
paint via3
box 67.850um -15.790um 68.250um -15.390um
paint metal4
box 67.950um -15.690um 85.700um -15.490um
paint metal4
box 85.400um -15.790um 85.800um -15.390um
paint metal3
box 85.500um -15.690um 85.700um -15.490um
paint via3
box 85.400um -15.790um 85.800um -15.390um
paint metal4
box 85.500um -30.100um 85.700um -15.490um
paint metal3
box 85.400um -30.200um 85.800um -29.800um
paint metal3
box 85.500um -30.100um 85.700um -29.900um
paint via3
box 85.400um -30.200um 85.800um -29.800um
paint metal4
# net net8  trunk=-31.000
box 65.340um -12.770um 65.580um -12.530um
paint metal1
box 65.360um -12.750um 65.560um -12.550um
paint via1
box 65.260um -12.850um 65.660um -12.450um
paint metal2
box 65.260um -12.850um 65.660um -12.450um
paint metal2
box 65.360um -12.750um 65.560um -12.550um
paint via2
box 65.260um -12.850um 65.660um -12.450um
paint metal3
box 65.260um -12.850um 65.660um -12.450um
paint metal3
box 65.360um -12.750um 65.560um -12.550um
paint via3
box 65.260um -12.850um 65.660um -12.450um
paint metal4
box 65.360um -13.450um 65.560um -12.550um
paint metal4
box 65.360um -13.450um 87.010um -13.250um
paint metal4
box 86.710um -13.550um 87.110um -13.150um
paint metal3
box 86.810um -13.450um 87.010um -13.250um
paint via3
box 86.710um -13.550um 87.110um -13.150um
paint metal4
box 86.810um -31.100um 87.010um -13.250um
paint metal3
box 86.710um -31.200um 87.110um -30.800um
paint metal3
box 86.810um -31.100um 87.010um -30.900um
paint via3
box 86.710um -31.200um 87.110um -30.800um
paint metal4
box 64.490um -15.490um 64.730um -15.250um
paint metal1
box 64.510um -15.470um 64.710um -15.270um
paint via1
box 64.410um -15.570um 64.810um -15.170um
paint metal2
box 64.410um -15.570um 64.810um -15.170um
paint metal2
box 64.510um -15.470um 64.710um -15.270um
paint via2
box 64.410um -15.570um 64.810um -15.170um
paint metal3
box 64.410um -15.570um 64.810um -15.170um
paint metal3
box 64.510um -15.470um 64.710um -15.270um
paint via3
box 64.410um -15.570um 64.810um -15.170um
paint metal4
box 64.510um -16.170um 64.710um -15.270um
paint metal4
box 42.410um -16.170um 64.710um -15.970um
paint metal4
box 42.310um -16.270um 42.710um -15.870um
paint metal3
box 42.410um -16.170um 42.610um -15.970um
paint via3
box 42.310um -16.270um 42.710um -15.870um
paint metal4
box 42.410um -31.100um 42.610um -15.970um
paint metal3
box 42.310um -31.200um 42.710um -30.800um
paint metal3
box 42.410um -31.100um 42.610um -30.900um
paint via3
box 42.310um -31.200um 42.710um -30.800um
paint metal4
box 62.530um -12.680um 62.770um -12.440um
paint metal1
box 62.550um -12.660um 62.750um -12.460um
paint via1
box 62.450um -12.760um 62.850um -12.360um
paint metal2
box 62.450um -12.760um 62.850um -12.360um
paint metal2
box 62.550um -12.660um 62.750um -12.460um
paint via2
box 62.450um -12.760um 62.850um -12.360um
paint metal3
box 62.450um -12.760um 62.850um -12.360um
paint metal3
box 62.550um -12.660um 62.750um -12.460um
paint via3
box 62.450um -12.760um 62.850um -12.360um
paint metal4
box 61.250um -12.660um 62.750um -12.460um
paint metal4
box 61.150um -12.760um 61.550um -12.360um
paint metal3
box 61.250um -12.660um 61.450um -12.460um
paint via3
box 61.150um -12.760um 61.550um -12.360um
paint metal4
box 61.250um -26.100um 61.450um -12.460um
paint metal3
box 61.150um -26.200um 61.550um -25.800um
paint metal3
box 61.250um -26.100um 61.450um -25.900um
paint via3
box 61.150um -26.200um 61.550um -25.800um
paint metal4
box -1.600um 13.900um 7.100um 14.100um
paint metal4
box 2.627um 14.900um 15.775um 15.100um
paint metal4
box 35.510um 15.900um 57.910um 16.100um
paint metal4
box 20.210um 16.900um 22.715um 17.100um
paint metal4
box 21.180um 17.900um 24.050um 18.100um
paint metal4
box -5.180um 18.900um 25.400um 19.100um
paint metal4
box 12.643um 19.900um 19.245um 20.100um
paint metal4
box -6.292um 20.900um 14.225um 21.100um
paint metal4
box 10.080um 21.900um 30.500um 22.100um
paint metal4
box 8.830um 22.900um 34.540um 23.100um
paint metal4
box -0.300um 23.900um 5.760um 24.100um
paint metal4
box 37.050um 24.900um 68.465um 25.100um
paint metal4
box 55.120um -21.100um 69.885um -20.900um
paint metal4
box 51.185um -22.100um 75.240um -21.900um
paint metal4
box 49.780um -23.100um 79.290um -22.900um
paint metal4
box 47.060um -24.100um 95.270um -23.900um
paint metal4
box 83.080um -25.100um 97.610um -24.900um
paint metal4
box 46.220um -26.100um 61.450um -25.900um
paint metal4
box 84.320um -27.100um 98.680um -26.900um
paint metal4
box 44.580um -28.100um 100.070um -27.900um
paint metal4
box 43.140um -29.100um 101.800um -28.900um
paint metal4
box 85.500um -30.100um 85.700um -29.900um
paint metal4
box 42.410um -31.100um 87.010um -30.900um
paint metal4
box -5.500um 12.100um 95.000um 12.900um
paint metal5
box -5.500um -19.400um 95.000um -18.600um
paint metal5
# VPWR
box 6.640um 10.140um 6.880um 10.380um
paint metal1
box 6.660um 10.160um 6.860um 10.360um
paint via1
box 6.560um 10.060um 6.960um 10.460um
paint metal2
box 6.660um 10.160um 7.660um 10.360um
paint metal2
box 7.360um 10.060um 7.760um 10.460um
paint metal2
box 7.460um 10.160um 7.660um 10.360um
paint via2
box 7.360um 10.060um 7.760um 10.460um
paint metal3
box 7.360um 10.060um 7.760um 10.460um
paint metal3
box 7.460um 10.160um 7.660um 10.360um
paint via3
box 7.360um 10.060um 7.760um 10.460um
paint metal4
box 7.360um 10.060um 7.760um 10.460um
paint metal4
box 7.460um 10.160um 7.660um 10.360um
paint via4
box 7.360um 10.060um 7.760um 10.460um
paint metal5
box 7.460um 10.160um 7.660um 12.600um
paint metal5
box 6.600um 3.940um 6.840um 4.180um
paint metal1
box 6.620um 3.960um 6.820um 4.160um
paint via1
box 6.520um 3.860um 6.920um 4.260um
paint metal2
box -7.180um 3.960um 6.820um 4.160um
paint metal2
box -7.280um 3.860um -6.880um 4.260um
paint metal2
box -7.180um 3.960um -6.980um 4.160um
paint via2
box -7.280um 3.860um -6.880um 4.260um
paint metal3
box -7.280um 3.860um -6.880um 4.260um
paint metal3
box -7.180um 3.960um -6.980um 4.160um
paint via3
box -7.280um 3.860um -6.880um 4.260um
paint metal4
box -7.280um 3.860um -6.880um 4.260um
paint metal4
box -7.180um 3.960um -6.980um 4.160um
paint via4
box -7.280um 3.860um -6.880um 4.260um
paint metal5
box -7.180um 3.960um -6.980um 12.600um
paint metal5
box 16.380um 2.700um 16.620um 2.940um
paint metal1
box 16.400um 2.720um 16.600um 2.920um
paint via1
box 16.300um 2.620um 16.700um 3.020um
paint metal2
box 16.400um 2.720um 17.400um 2.920um
paint metal2
box 17.100um 2.620um 17.500um 3.020um
paint metal2
box 17.200um 2.720um 17.400um 2.920um
paint via2
box 17.100um 2.620um 17.500um 3.020um
paint metal3
box 17.100um 2.620um 17.500um 3.020um
paint metal3
box 17.200um 2.720um 17.400um 2.920um
paint via3
box 17.100um 2.620um 17.500um 3.020um
paint metal4
box 17.100um 2.620um 17.500um 3.020um
paint metal4
box 17.200um 2.720um 17.400um 2.920um
paint via4
box 17.100um 2.620um 17.500um 3.020um
paint metal5
box 17.200um 2.720um 17.400um 12.600um
paint metal5
box 19.940um 6.400um 20.180um 6.640um
paint metal1
box 19.960um 6.420um 20.160um 6.620um
paint via1
box 19.860um 6.320um 20.260um 6.720um
paint metal2
box 18.510um 6.420um 20.160um 6.620um
paint metal2
box 18.410um 6.320um 18.810um 6.720um
paint metal2
box 18.510um 6.420um 18.710um 6.620um
paint via2
box 18.410um 6.320um 18.810um 6.720um
paint metal3
box 18.410um 6.320um 18.810um 6.720um
paint metal3
box 18.510um 6.420um 18.710um 6.620um
paint via3
box 18.410um 6.320um 18.810um 6.720um
paint metal4
box 18.410um 6.320um 18.810um 6.720um
paint metal4
box 18.510um 6.420um 18.710um 6.620um
paint via4
box 18.410um 6.320um 18.810um 6.720um
paint metal5
box 18.510um 6.420um 18.710um 12.600um
paint metal5
box 0.588um 7.840um 0.828um 8.080um
paint metal1
box 0.608um 7.860um 0.807um 8.060um
paint via1
box 0.508um 7.760um 0.907um 8.160um
paint metal2
box 0.608um 7.860um 1.608um 8.060um
paint metal2
box 1.307um 7.760um 1.708um 8.160um
paint metal2
box 1.407um 7.860um 1.608um 8.060um
paint via2
box 1.307um 7.760um 1.708um 8.160um
paint metal3
box 1.307um 7.760um 1.708um 8.160um
paint metal3
box 1.407um 7.860um 1.608um 8.060um
paint via3
box 1.307um 7.760um 1.708um 8.160um
paint metal4
box 1.307um 7.760um 1.708um 8.160um
paint metal4
box 1.407um 7.860um 1.608um 8.060um
paint via4
box 1.307um 7.760um 1.708um 8.160um
paint metal5
box 1.407um 7.860um 1.608um 12.600um
paint metal5
box 0.547um 1.640um 0.787um 1.880um
paint metal1
box 0.568um 1.660um 0.767um 1.860um
paint via1
box 0.468um 1.560um 0.867um 1.960um
paint metal2
box -2.183um 1.660um 0.767um 1.860um
paint metal2
box -2.283um 1.560um -1.882um 1.960um
paint metal2
box -2.183um 1.660um -1.982um 1.860um
paint via2
box -2.283um 1.560um -1.882um 1.960um
paint metal3
box -2.283um 1.560um -1.882um 1.960um
paint metal3
box -2.183um 1.660um -1.982um 1.860um
paint via3
box -2.283um 1.560um -1.882um 1.960um
paint metal4
box -2.283um 1.560um -1.882um 1.960um
paint metal4
box -2.183um 1.660um -1.982um 1.860um
paint via4
box -2.283um 1.560um -1.882um 1.960um
paint metal5
box -2.183um 1.660um -1.982um 12.600um
paint metal5
box 23.310um 8.380um 23.550um 8.620um
paint metal1
box 23.330um 8.400um 23.530um 8.600um
paint via1
box 23.230um 8.300um 23.630um 8.700um
paint metal2
box 23.330um 8.400um 31.480um 8.600um
paint metal2
box 31.180um 8.300um 31.580um 8.700um
paint metal2
box 31.280um 8.400um 31.480um 8.600um
paint via2
box 31.180um 8.300um 31.580um 8.700um
paint metal3
box 31.180um 8.300um 31.580um 8.700um
paint metal3
box 31.280um 8.400um 31.480um 8.600um
paint via3
box 31.180um 8.300um 31.580um 8.700um
paint metal4
box 31.180um 8.300um 31.580um 8.700um
paint metal4
box 31.280um 8.400um 31.480um 8.600um
paint via4
box 31.180um 8.300um 31.580um 8.700um
paint metal5
box 31.280um 8.400um 31.480um 12.600um
paint metal5
box 22.140um -6.250um 22.380um -6.010um
paint metal1
box 22.160um -6.230um 22.360um -6.030um
paint via1
box 22.060um -6.330um 22.460um -5.930um
paint metal2
box 22.160um -6.230um 23.160um -6.030um
paint metal2
box 22.860um -6.330um 23.260um -5.930um
paint metal2
box 22.960um -6.230um 23.160um -6.030um
paint via2
box 22.860um -6.330um 23.260um -5.930um
paint metal3
box 22.860um -6.330um 23.260um -5.930um
paint metal3
box 22.960um -6.230um 23.160um -6.030um
paint via3
box 22.860um -6.330um 23.260um -5.930um
paint metal4
box 22.860um -6.330um 23.260um -5.930um
paint metal4
box 22.960um -6.230um 23.160um -6.030um
paint via4
box 22.860um -6.330um 23.260um -5.930um
paint metal5
box 22.960um -6.230um 23.160um 12.600um
paint metal5
box 1.190um -15.350um 1.430um -15.110um
paint metal1
box 1.210um -15.330um 1.410um -15.130um
paint via1
box 1.110um -15.430um 1.510um -15.030um
paint metal2
box 1.210um -15.330um 2.410um -15.130um
paint metal2
box 2.110um -15.430um 2.510um -15.030um
paint metal2
box 2.210um -15.330um 2.410um -15.130um
paint via2
box 2.110um -15.430um 2.510um -15.030um
paint metal3
box 2.110um -15.430um 2.510um -15.030um
paint metal3
box 2.210um -15.330um 2.410um -15.130um
paint via3
box 2.110um -15.430um 2.510um -15.030um
paint metal4
box 2.110um -15.430um 2.510um -15.030um
paint metal4
box 2.210um -15.330um 2.410um -15.130um
paint via4
box 2.110um -15.430um 2.510um -15.030um
paint metal5
box 2.210um -15.330um 2.410um 12.600um
paint metal5
box 71.990um -9.610um 72.230um -9.370um
paint metal1
box 72.010um -9.590um 72.210um -9.390um
paint via1
box 71.910um -9.690um 72.310um -9.290um
paint metal2
box 72.010um -9.590um 100.960um -9.390um
paint metal2
box 100.660um -9.690um 101.060um -9.290um
paint metal2
box 100.760um -9.590um 100.960um -9.390um
paint via2
box 100.660um -9.690um 101.060um -9.290um
paint metal3
box 100.660um -9.690um 101.060um -9.290um
paint metal3
box 100.760um -9.590um 100.960um -9.390um
paint via3
box 100.660um -9.690um 101.060um -9.290um
paint metal4
box 100.660um -9.690um 101.060um -9.290um
paint metal4
box 100.760um -9.590um 100.960um -9.390um
paint via4
box 100.660um -9.690um 101.060um -9.290um
paint metal5
box 100.760um -9.590um 100.960um 12.600um
paint metal5
box 68.680um -6.490um 68.920um -6.250um
paint metal1
box 68.700um -6.470um 68.900um -6.270um
paint via1
box 68.600um -6.570um 69.000um -6.170um
paint metal2
box 68.700um -6.470um 102.850um -6.270um
paint metal2
box 102.550um -6.570um 102.950um -6.170um
paint metal2
box 102.650um -6.470um 102.850um -6.270um
paint via2
box 102.550um -6.570um 102.950um -6.170um
paint metal3
box 102.550um -6.570um 102.950um -6.170um
paint metal3
box 102.650um -6.470um 102.850um -6.270um
paint via3
box 102.550um -6.570um 102.950um -6.170um
paint metal4
box 102.550um -6.570um 102.950um -6.170um
paint metal4
box 102.650um -6.470um 102.850um -6.270um
paint via4
box 102.550um -6.570um 102.950um -6.170um
paint metal5
box 102.650um -6.470um 102.850um 12.600um
paint metal5
box 65.340um -6.400um 65.580um -6.160um
paint metal1
box 65.360um -6.380um 65.560um -6.180um
paint via1
box 65.260um -6.480um 65.660um -6.080um
paint metal2
box 65.360um -6.380um 66.560um -6.180um
paint metal2
box 66.260um -6.480um 66.660um -6.080um
paint metal2
box 66.360um -6.380um 66.560um -6.180um
paint via2
box 66.260um -6.480um 66.660um -6.080um
paint metal3
box 66.260um -6.480um 66.660um -6.080um
paint metal3
box 66.360um -6.380um 66.560um -6.180um
paint via3
box 66.260um -6.480um 66.660um -6.080um
paint metal4
box 66.260um -6.480um 66.660um -6.080um
paint metal4
box 66.360um -6.380um 66.560um -6.180um
paint via4
box 66.260um -6.480um 66.660um -6.080um
paint metal5
box 66.360um -6.380um 66.560um 12.600um
paint metal5
box 62.560um -6.370um 62.800um -6.130um
paint metal1
box 62.580um -6.350um 62.780um -6.150um
paint via1
box 62.480um -6.450um 62.880um -6.050um
paint metal2
box 62.580um -6.350um 63.780um -6.150um
paint metal2
box 63.480um -6.450um 63.880um -6.050um
paint metal2
box 63.580um -6.350um 63.780um -6.150um
paint via2
box 63.480um -6.450um 63.880um -6.050um
paint metal3
box 63.480um -6.450um 63.880um -6.050um
paint metal3
box 63.580um -6.350um 63.780um -6.150um
paint via3
box 63.480um -6.450um 63.880um -6.050um
paint metal4
box 63.480um -6.450um 63.880um -6.050um
paint metal4
box 63.580um -6.350um 63.780um -6.150um
paint via4
box 63.480um -6.450um 63.880um -6.050um
paint metal5
box 63.580um -6.350um 63.780um 12.600um
paint metal5
box 59.680um -7.880um 59.920um -7.640um
paint metal1
box 59.700um -7.860um 59.900um -7.660um
paint via1
box 59.600um -7.960um 60.000um -7.560um
paint metal2
box 59.700um -7.860um 61.350um -7.660um
paint metal2
box 61.050um -7.960um 61.450um -7.560um
paint metal2
box 61.150um -7.860um 61.350um -7.660um
paint via2
box 61.050um -7.960um 61.450um -7.560um
paint metal3
box 61.050um -7.960um 61.450um -7.560um
paint metal3
box 61.150um -7.860um 61.350um -7.660um
paint via3
box 61.050um -7.960um 61.450um -7.560um
paint metal4
box 61.050um -7.960um 61.450um -7.560um
paint metal4
box 61.150um -7.860um 61.350um -7.660um
paint via4
box 61.050um -7.960um 61.450um -7.560um
paint metal5
box 61.150um -7.860um 61.350um 12.600um
paint metal5
# VGND
box 6.640um 6.360um 6.880um 6.600um
paint metal1
box 6.660um 6.380um 6.860um 6.580um
paint via1
box 6.560um 6.280um 6.960um 6.680um
paint metal2
box 4.560um 6.380um 6.860um 6.580um
paint metal2
box 4.460um 6.280um 4.860um 6.680um
paint metal2
box 4.560um 6.380um 4.760um 6.580um
paint via2
box 4.460um 6.280um 4.860um 6.680um
paint metal3
box 4.460um 6.280um 4.860um 6.680um
paint metal3
box 4.560um 6.380um 4.760um 6.580um
paint via3
box 4.460um 6.280um 4.860um 6.680um
paint metal4
box 4.460um 6.280um 4.860um 6.680um
paint metal4
box 4.560um 6.380um 4.760um 6.580um
paint via4
box 4.460um 6.280um 4.860um 6.680um
paint metal5
box 4.560um -19.100um 4.760um 6.580um
paint metal5
box 6.600um 0.160um 6.840um 0.400um
paint metal1
box 6.620um 0.180um 6.820um 0.380um
paint via1
box 6.520um 0.080um 6.920um 0.480um
paint metal2
box 5.820um 0.180um 6.820um 0.380um
paint metal2
box 5.720um 0.080um 6.120um 0.480um
paint metal2
box 5.820um 0.180um 6.020um 0.380um
paint via2
box 5.720um 0.080um 6.120um 0.480um
paint metal3
box 5.720um 0.080um 6.120um 0.480um
paint metal3
box 5.820um 0.180um 6.020um 0.380um
paint via3
box 5.720um 0.080um 6.120um 0.480um
paint metal4
box 5.720um 0.080um 6.120um 0.480um
paint metal4
box 5.820um 0.180um 6.020um 0.380um
paint via4
box 5.720um 0.080um 6.120um 0.480um
paint metal5
box 5.820um -19.100um 6.020um 0.380um
paint metal5
box 16.380um 6.480um 16.620um 6.720um
paint metal1
box 16.400um 6.500um 16.600um 6.700um
paint via1
box 16.300um 6.400um 16.700um 6.800um
paint metal2
box 14.950um 6.500um 16.600um 6.700um
paint metal2
box 14.850um 6.400um 15.250um 6.800um
paint metal2
box 14.950um 6.500um 15.150um 6.700um
paint via2
box 14.850um 6.400um 15.250um 6.800um
paint metal3
box 14.850um 6.400um 15.250um 6.800um
paint metal3
box 14.950um 6.500um 15.150um 6.700um
paint via3
box 14.850um 6.400um 15.250um 6.800um
paint metal4
box 14.850um 6.400um 15.250um 6.800um
paint metal4
box 14.950um 6.500um 15.150um 6.700um
paint via4
box 14.850um 6.400um 15.250um 6.800um
paint metal5
box 14.950um -19.100um 15.150um 6.700um
paint metal5
box 19.940um 2.620um 20.180um 2.860um
paint metal1
box 19.960um 2.640um 20.160um 2.840um
paint via1
box 19.860um 2.540um 20.260um 2.940um
paint metal2
box 15.910um 2.640um 20.160um 2.840um
paint metal2
box 15.810um 2.540um 16.210um 2.940um
paint metal2
box 15.910um 2.640um 16.110um 2.840um
paint via2
box 15.810um 2.540um 16.210um 2.940um
paint metal3
box 15.810um 2.540um 16.210um 2.940um
paint metal3
box 15.910um 2.640um 16.110um 2.840um
paint via3
box 15.810um 2.540um 16.210um 2.940um
paint metal4
box 15.810um 2.540um 16.210um 2.940um
paint metal4
box 15.910um 2.640um 16.110um 2.840um
paint via4
box 15.810um 2.540um 16.210um 2.940um
paint metal5
box 15.910um -19.100um 16.110um 2.840um
paint metal5
box 23.190um 1.370um 23.430um 1.610um
paint metal1
box 23.210um 1.390um 23.410um 1.590um
paint via1
box 23.110um 1.290um 23.510um 1.690um
paint metal2
box 23.210um 1.390um 24.410um 1.590um
paint metal2
box 24.110um 1.290um 24.510um 1.690um
paint metal2
box 24.210um 1.390um 24.410um 1.590um
paint via2
box 24.110um 1.290um 24.510um 1.690um
paint metal3
box 24.110um 1.290um 24.510um 1.690um
paint metal3
box 24.210um 1.390um 24.410um 1.590um
paint via3
box 24.110um 1.290um 24.510um 1.690um
paint metal4
box 24.110um 1.290um 24.510um 1.690um
paint metal4
box 24.210um 1.390um 24.410um 1.590um
paint via4
box 24.110um 1.290um 24.510um 1.690um
paint metal5
box 24.210um -19.100um 24.410um 1.590um
paint metal5
box 23.190um -3.470um 23.430um -3.230um
paint metal1
box 23.210um -3.450um 23.410um -3.250um
paint via1
box 23.110um -3.550um 23.510um -3.150um
paint metal2
box 23.210um -3.450um 24.410um -3.250um
paint metal2
box 24.110um -3.550um 24.510um -3.150um
paint metal2
box 24.210um -3.450um 24.410um -3.250um
paint via2
box 24.110um -3.550um 24.510um -3.150um
paint metal3
box 24.110um -3.550um 24.510um -3.150um
paint metal3
box 24.210um -3.450um 24.410um -3.250um
paint via3
box 24.110um -3.550um 24.510um -3.150um
paint metal4
box 24.110um -3.550um 24.510um -3.150um
paint metal4
box 24.210um -3.450um 24.410um -3.250um
paint via4
box 24.110um -3.550um 24.510um -3.150um
paint metal5
box 24.210um -19.100um 24.410um -3.250um
paint metal5
box 23.210um -1.280um 23.450um -1.040um
paint metal1
box 23.230um -1.260um 23.430um -1.060um
paint via1
box 23.130um -1.360um 23.530um -0.960um
paint metal2
box 23.230um -1.260um 24.430um -1.060um
paint metal2
box 24.130um -1.360um 24.530um -0.960um
paint metal2
box 24.230um -1.260um 24.430um -1.060um
paint via2
box 24.130um -1.360um 24.530um -0.960um
paint metal3
box 24.130um -1.360um 24.530um -0.960um
paint metal3
box 24.230um -1.260um 24.430um -1.060um
paint via3
box 24.130um -1.360um 24.530um -0.960um
paint metal4
box 24.130um -1.360um 24.530um -0.960um
paint metal4
box 24.230um -1.260um 24.430um -1.060um
paint via4
box 24.130um -1.360um 24.530um -0.960um
paint metal5
box 24.230um -19.100um 24.430um -1.060um
paint metal5
box 53.280um -5.020um 53.520um -4.780um
paint metal1
box 53.300um -5.000um 53.500um -4.800um
paint via1
box 53.200um -5.100um 53.600um -4.700um
paint metal2
box 53.300um -5.000um 54.300um -4.800um
paint metal2
box 54.000um -5.100um 54.400um -4.700um
paint metal2
box 54.100um -5.000um 54.300um -4.800um
paint via2
box 54.000um -5.100um 54.400um -4.700um
paint metal3
box 54.000um -5.100um 54.400um -4.700um
paint metal3
box 54.100um -5.000um 54.300um -4.800um
paint via3
box 54.000um -5.100um 54.400um -4.700um
paint metal4
box 54.000um -5.100um 54.400um -4.700um
paint metal4
box 54.100um -5.000um 54.300um -4.800um
paint via4
box 54.000um -5.100um 54.400um -4.700um
paint metal5
box 54.100um -19.100um 54.300um -4.800um
paint metal5
box 10.500um -16.060um 10.740um -15.820um
paint metal1
box 10.520um -16.040um 10.720um -15.840um
paint via1
box 10.420um -16.140um 10.820um -15.740um
paint metal2
box 10.520um -16.040um 11.520um -15.840um
paint metal2
box 11.220um -16.140um 11.620um -15.740um
paint metal2
box 11.320um -16.040um 11.520um -15.840um
paint via2
box 11.220um -16.140um 11.620um -15.740um
paint metal3
box 11.220um -16.140um 11.620um -15.740um
paint metal3
box 11.320um -16.040um 11.520um -15.840um
paint via3
box 11.220um -16.140um 11.620um -15.740um
paint metal4
box 11.220um -16.140um 11.620um -15.740um
paint metal4
box 11.320um -16.040um 11.520um -15.840um
paint via4
box 11.220um -16.140um 11.620um -15.740um
paint metal5
box 11.320um -19.100um 11.520um -15.840um
paint metal5
box 45.460um -6.610um 45.960um -6.110um
paint metal5
box 45.585um -19.125um 45.835um -6.235um
paint metal5
box 56.560um -12.570um 57.060um -12.070um
paint metal5
box 56.685um -19.125um 56.935um -12.195um
paint metal5
box 72.020um -11.970um 72.260um -11.730um
paint metal1
box 72.040um -11.950um 72.240um -11.750um
paint via1
box 71.940um -12.050um 72.340um -11.650um
paint metal2
box 72.040um -11.950um 73.240um -11.750um
paint metal2
box 72.940um -12.050um 73.340um -11.650um
paint metal2
box 73.040um -11.950um 73.240um -11.750um
paint via2
box 72.940um -12.050um 73.340um -11.650um
paint metal3
box 72.940um -12.050um 73.340um -11.650um
paint metal3
box 73.040um -11.950um 73.240um -11.750um
paint via3
box 72.940um -12.050um 73.340um -11.650um
paint metal4
box 72.940um -12.050um 73.340um -11.650um
paint metal4
box 73.040um -11.950um 73.240um -11.750um
paint via4
box 72.940um -12.050um 73.340um -11.650um
paint metal5
box 73.040um -19.100um 73.240um -11.750um
paint metal5
box 65.120um -15.490um 65.360um -15.250um
paint metal1
box 65.140um -15.470um 65.340um -15.270um
paint via1
box 65.040um -15.570um 65.440um -15.170um
paint metal2
box 65.140um -15.470um 66.340um -15.270um
paint metal2
box 66.040um -15.570um 66.440um -15.170um
paint metal2
box 66.140um -15.470um 66.340um -15.270um
paint via2
box 66.040um -15.570um 66.440um -15.170um
paint metal3
box 66.040um -15.570um 66.440um -15.170um
paint metal3
box 66.140um -15.470um 66.340um -15.270um
paint via3
box 66.040um -15.570um 66.440um -15.170um
paint metal4
box 66.040um -15.570um 66.440um -15.170um
paint metal4
box 66.140um -15.470um 66.340um -15.270um
paint via4
box 66.040um -15.570um 66.440um -15.170um
paint metal5
box 66.140um -19.100um 66.340um -15.270um
paint metal5
box 68.560um -15.710um 68.800um -15.470um
paint metal1
box 68.580um -15.690um 68.780um -15.490um
paint via1
box 68.480um -15.790um 68.880um -15.390um
paint metal2
box 68.580um -15.690um 69.780um -15.490um
paint metal2
box 69.480um -15.790um 69.880um -15.390um
paint metal2
box 69.580um -15.690um 69.780um -15.490um
paint via2
box 69.480um -15.790um 69.880um -15.390um
paint metal3
box 69.480um -15.790um 69.880um -15.390um
paint metal3
box 69.580um -15.690um 69.780um -15.490um
paint via3
box 69.480um -15.790um 69.880um -15.390um
paint metal4
box 69.480um -15.790um 69.880um -15.390um
paint metal4
box 69.580um -15.690um 69.780um -15.490um
paint via4
box 69.480um -15.790um 69.880um -15.390um
paint metal5
box 69.580um -19.100um 69.780um -15.490um
paint metal5
box 62.430um -15.460um 62.670um -15.220um
paint metal1
box 62.450um -15.440um 62.650um -15.240um
paint via1
box 62.350um -15.540um 62.750um -15.140um
paint metal2
box 62.450um -15.440um 63.650um -15.240um
paint metal2
box 63.350um -15.540um 63.750um -15.140um
paint metal2
box 63.450um -15.440um 63.650um -15.240um
paint via2
box 63.350um -15.540um 63.750um -15.140um
paint metal3
box 63.350um -15.540um 63.750um -15.140um
paint metal3
box 63.450um -15.440um 63.650um -15.240um
paint via3
box 63.350um -15.540um 63.750um -15.140um
paint metal4
box 63.350um -15.540um 63.750um -15.140um
paint metal4
box 63.450um -15.440um 63.650um -15.240um
paint via4
box 63.350um -15.540um 63.750um -15.140um
paint metal5
box 63.450um -19.100um 63.650um -15.240um
paint metal5
box 59.630um -13.510um 59.870um -13.270um
paint metal1
box 59.650um -13.490um 59.850um -13.290um
paint via1
box 59.550um -13.590um 59.950um -13.190um
paint metal2
box 59.650um -13.490um 60.850um -13.290um
paint metal2
box 60.550um -13.590um 60.950um -13.190um
paint metal2
box 60.650um -13.490um 60.850um -13.290um
paint via2
box 60.550um -13.590um 60.950um -13.190um
paint metal3
box 60.550um -13.590um 60.950um -13.190um
paint metal3
box 60.650um -13.490um 60.850um -13.290um
paint via3
box 60.550um -13.590um 60.950um -13.190um
paint metal4
box 60.550um -13.590um 60.950um -13.190um
paint metal4
box 60.650um -13.490um 60.850um -13.290um
paint via4
box 60.550um -13.590um 60.950um -13.190um
paint metal5
box 60.650um -19.100um 60.850um -13.290um
paint metal5
box 20.380um 12.380um 20.620um 12.620um
paint metal1
box 20.400um 12.400um 20.600um 12.600um
paint via1
box 20.300um 12.300um 20.700um 12.700um
paint metal2
box -10.950um 12.400um 20.600um 12.600um
paint metal2
box -11.050um 12.300um -10.650um 12.700um
paint metal2
box -10.950um 12.400um -10.750um 12.600um
paint via2
box -11.050um 12.300um -10.650um 12.700um
paint metal3
box -11.050um 12.300um -10.650um 12.700um
paint metal3
box -10.950um 12.400um -10.750um 12.600um
paint via3
box -11.050um 12.300um -10.650um 12.700um
paint metal4
box -11.050um 12.300um -10.650um 12.700um
paint metal4
box -10.950um 12.400um -10.750um 12.600um
paint via4
box -11.050um 12.300um -10.650um 12.700um
paint metal5
box -10.950um 12.400um -10.750um 12.600um
paint metal5
box 20.380um -19.120um 20.620um -18.880um
paint metal1
box 20.400um -19.100um 20.600um -18.900um
paint via1
box 20.300um -19.200um 20.700um -18.800um
paint metal2
box -12.250um -19.100um 20.600um -18.900um
paint metal2
box -12.350um -19.200um -11.950um -18.800um
paint metal2
box -12.250um -19.100um -12.050um -18.900um
paint via2
box -12.350um -19.200um -11.950um -18.800um
paint metal3
box -12.350um -19.200um -11.950um -18.800um
paint metal3
box -12.250um -19.100um -12.050um -18.900um
paint via3
box -12.350um -19.200um -11.950um -18.800um
paint metal4
box -12.350um -19.200um -11.950um -18.800um
paint metal4
box -12.250um -19.100um -12.050um -18.900um
paint via4
box -12.350um -19.200um -11.950um -18.800um
paint metal5
box -12.250um -19.100um -12.050um -18.900um
paint metal5
save pll_analog
puts DONE
quit -noprompt
