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
box -15um -60um 115um 55um
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
box -1.580um 6.920um -1.420um 7.080um
paint metal1
box -1.605um 6.895um -1.395um 7.105um
paint metal1
box -1.580um 6.920um -1.420um 7.080um
paint via1
box -1.605um 6.895um -1.395um 7.105um
paint metal2
box -1.605um 6.895um -1.395um 7.105um
paint metal2
box -1.580um 6.920um -1.420um 7.080um
paint via2
box -1.605um 6.895um -1.395um 7.105um
paint metal3
box -1.605um 6.895um -1.395um 7.105um
paint metal3
box -1.580um 6.920um -1.420um 7.080um
paint via3
box -1.605um 6.895um -1.395um 7.105um
paint metal4
box -2.130um 6.920um -1.420um 7.080um
paint metal4
box -2.155um 6.895um -1.945um 7.105um
paint metal3
box -2.130um 6.920um -1.970um 7.080um
paint via3
box -2.155um 6.895um -1.945um 7.105um
paint metal4
box -2.130um 6.920um -1.970um 14.080um
paint metal3
box -2.155um 13.895um -1.945um 14.105um
paint metal3
box -2.130um 13.920um -1.970um 14.080um
paint via3
box -2.155um 13.895um -1.945um 14.105um
paint metal4
box 6.880um 6.680um 7.040um 6.840um
paint metal1
box 6.855um 6.655um 7.065um 6.865um
paint metal1
box 6.880um 6.680um 7.040um 6.840um
paint via1
box 6.855um 6.655um 7.065um 6.865um
paint metal2
box 6.855um 6.655um 7.065um 6.865um
paint metal2
box 6.880um 6.680um 7.040um 6.840um
paint via2
box 6.855um 6.655um 7.065um 6.865um
paint metal3
box 6.855um 6.655um 7.065um 6.865um
paint metal3
box 6.880um 6.680um 7.040um 6.840um
paint via3
box 6.855um 6.655um 7.065um 6.865um
paint metal4
box 6.880um 6.680um 7.590um 6.840um
paint metal4
box 7.405um 6.655um 7.615um 6.865um
paint metal3
box 7.430um 6.680um 7.590um 6.840um
paint via3
box 7.405um 6.655um 7.615um 6.865um
paint metal4
box 7.430um 6.680um 7.590um 14.080um
paint metal3
box 7.405um 13.895um 7.615um 14.105um
paint metal3
box 7.430um 13.920um 7.590um 14.080um
paint via3
box 7.405um 13.895um 7.615um 14.105um
paint metal4
box -2.130um 13.920um 7.590um 14.080um
paint metal4
# net net1  trunk=14.600
box 2.607um 6.737um 2.768um 6.897um
paint metal1
box 2.607um 1.938um 2.768um 2.098um
paint metal1
box 14.335um 3.840um 14.495um 4.000um
paint metal1
box 14.310um 3.815um 14.520um 4.025um
paint metal1
box 14.335um 3.840um 14.495um 4.000um
paint via1
box 14.310um 3.815um 14.520um 4.025um
paint metal2
box 14.310um 3.815um 14.520um 4.025um
paint metal2
box 14.335um 3.840um 14.495um 4.000um
paint via2
box 14.310um 3.815um 14.520um 4.025um
paint metal3
box 14.310um 3.815um 14.520um 4.025um
paint metal3
box 14.335um 3.840um 14.495um 4.000um
paint via3
box 14.310um 3.815um 14.520um 4.025um
paint metal4
box 13.785um 3.840um 14.495um 4.000um
paint metal4
box 13.760um 3.815um 13.970um 4.025um
paint metal3
box 13.785um 3.840um 13.945um 4.000um
paint via3
box 13.760um 3.815um 13.970um 4.025um
paint metal4
box 13.785um 3.840um 13.945um 14.680um
paint metal3
box 13.760um 14.495um 13.970um 14.705um
paint metal3
box 13.785um 14.520um 13.945um 14.680um
paint via3
box 13.760um 14.495um 13.970um 14.705um
paint metal4
box 13.785um 14.520um 13.945um 14.680um
paint metal4
# net net15  trunk=15.200
box 55.650um -4.950um 55.810um -4.790um
paint metal1
box 55.625um -4.975um 55.835um -4.765um
paint metal1
box 55.650um -4.950um 55.810um -4.790um
paint via1
box 55.625um -4.975um 55.835um -4.765um
paint metal2
box 55.625um -4.975um 55.835um -4.765um
paint metal2
box 55.650um -4.950um 55.810um -4.790um
paint via2
box 55.625um -4.975um 55.835um -4.765um
paint metal3
box 55.625um -4.975um 55.835um -4.765um
paint metal3
box 55.650um -4.950um 55.810um -4.790um
paint via3
box 55.625um -4.975um 55.835um -4.765um
paint metal4
box 55.650um -4.950um 57.260um -4.790um
paint metal4
box 57.075um -4.975um 57.285um -4.765um
paint metal3
box 57.100um -4.950um 57.260um -4.790um
paint via3
box 57.075um -4.975um 57.285um -4.765um
paint metal4
box 57.100um -4.950um 57.260um 15.280um
paint metal3
box 57.075um 15.095um 57.285um 15.305um
paint metal3
box 57.100um 15.120um 57.260um 15.280um
paint via3
box 57.075um 15.095um 57.285um 15.305um
paint metal4
box 34.020um -6.410um 35.020um -5.410um
paint metal1
box 34.415um -6.015um 34.625um -5.805um
paint metal1
box 34.440um -5.990um 34.600um -5.830um
paint via1
box 34.415um -6.015um 34.625um -5.805um
paint metal2
box 34.415um -6.015um 34.625um -5.805um
paint metal2
box 34.440um -5.990um 34.600um -5.830um
paint via2
box 34.415um -6.015um 34.625um -5.805um
paint metal3
box 34.415um -6.015um 34.625um -5.805um
paint metal3
box 34.440um -5.990um 34.600um -5.830um
paint via3
box 34.415um -6.015um 34.625um -5.805um
paint metal4
box 33.890um -5.990um 34.600um -5.830um
paint metal4
box 33.865um -6.015um 34.075um -5.805um
paint metal3
box 33.890um -5.990um 34.050um -5.830um
paint via3
box 33.865um -6.015um 34.075um -5.805um
paint metal4
box 33.890um -5.990um 34.050um 15.280um
paint metal3
box 33.865um 15.095um 34.075um 15.305um
paint metal3
box 33.890um 15.120um 34.050um 15.280um
paint via3
box 33.865um 15.095um 34.075um 15.305um
paint metal4
box 33.890um 15.120um 57.260um 15.280um
paint metal4
# net net2  trunk=15.800
box 18.440um 4.503um 18.600um 4.663um
paint metal1
box 18.415um 4.478um 18.625um 4.688um
paint metal1
box 18.440um 4.503um 18.600um 4.663um
paint via1
box 18.415um 4.478um 18.625um 4.688um
paint metal2
box 18.415um 4.478um 18.625um 4.688um
paint metal2
box 18.440um 4.503um 18.600um 4.663um
paint via2
box 18.415um 4.478um 18.625um 4.688um
paint metal3
box 18.415um 4.478um 18.625um 4.688um
paint metal3
box 18.440um 4.503um 18.600um 4.663um
paint via3
box 18.415um 4.478um 18.625um 4.688um
paint metal4
box 18.440um 4.503um 19.150um 4.663um
paint metal4
box 18.965um 4.478um 19.175um 4.688um
paint metal3
box 18.990um 4.503um 19.150um 4.663um
paint via3
box 18.965um 4.478um 19.175um 4.688um
paint metal4
box 18.990um 4.503um 19.150um 15.880um
paint metal3
box 18.965um 15.695um 19.175um 15.905um
paint metal3
box 18.990um 15.720um 19.150um 15.880um
paint via3
box 18.965um 15.695um 19.175um 15.905um
paint metal4
box 21.205um 5.560um 21.365um 5.720um
paint metal1
box 21.180um 5.535um 21.390um 5.745um
paint metal1
box 21.205um 5.560um 21.365um 5.720um
paint via1
box 21.180um 5.535um 21.390um 5.745um
paint metal2
box 21.180um 5.535um 21.390um 5.745um
paint metal2
box 21.205um 5.560um 21.365um 5.720um
paint via2
box 21.180um 5.535um 21.390um 5.745um
paint metal3
box 21.180um 5.535um 21.390um 5.745um
paint metal3
box 21.205um 5.560um 21.365um 5.720um
paint via3
box 21.180um 5.535um 21.390um 5.745um
paint metal4
box 19.305um 5.560um 21.365um 5.720um
paint metal4
box 19.280um 5.535um 19.490um 5.745um
paint metal3
box 19.305um 5.560um 19.465um 5.720um
paint via3
box 19.280um 5.535um 19.490um 5.745um
paint metal4
box 19.305um 5.560um 19.465um 15.880um
paint metal3
box 19.280um 15.695um 19.490um 15.905um
paint metal3
box 19.305um 15.720um 19.465um 15.880um
paint via3
box 19.280um 15.695um 19.490um 15.905um
paint metal4
box 18.990um 15.720um 19.465um 15.880um
paint metal4
# net net3  trunk=16.400
box 21.150um 3.770um 21.310um 3.930um
paint metal1
box 21.125um 3.745um 21.335um 3.955um
paint metal1
box 21.150um 3.770um 21.310um 3.930um
paint via1
box 21.125um 3.745um 21.335um 3.955um
paint metal2
box 21.125um 3.745um 21.335um 3.955um
paint metal2
box 21.150um 3.770um 21.310um 3.930um
paint via2
box 21.125um 3.745um 21.335um 3.955um
paint metal3
box 21.125um 3.745um 21.335um 3.955um
paint metal3
box 21.150um 3.770um 21.310um 3.930um
paint via3
box 21.125um 3.745um 21.335um 3.955um
paint metal4
box 21.150um 3.770um 25.010um 3.930um
paint metal4
box 24.825um 3.745um 25.035um 3.955um
paint metal3
box 24.850um 3.770um 25.010um 3.930um
paint via3
box 24.825um 3.745um 25.035um 3.955um
paint metal4
box 24.850um 3.770um 25.010um 16.480um
paint metal3
box 24.825um 16.295um 25.035um 16.505um
paint metal3
box 24.850um 16.320um 25.010um 16.480um
paint via3
box 24.825um 16.295um 25.035um 16.505um
paint metal4
box 20.630um 2.310um 20.790um 2.470um
paint metal1
box 20.605um 2.285um 20.815um 2.495um
paint metal1
box 20.630um 2.310um 20.790um 2.470um
paint via1
box 20.605um 2.285um 20.815um 2.495um
paint metal2
box 20.605um 2.285um 20.815um 2.495um
paint metal2
box 20.630um 2.310um 20.790um 2.470um
paint via2
box 20.605um 2.285um 20.815um 2.495um
paint metal3
box 20.605um 2.285um 20.815um 2.495um
paint metal3
box 20.630um 2.310um 20.790um 2.470um
paint via3
box 20.605um 2.285um 20.815um 2.495um
paint metal4
box 20.630um 2.310um 25.390um 2.470um
paint metal4
box 25.205um 2.285um 25.415um 2.495um
paint metal3
box 25.230um 2.310um 25.390um 2.470um
paint via3
box 25.205um 2.285um 25.415um 2.495um
paint metal4
box 25.230um 2.310um 25.390um 16.480um
paint metal3
box 25.205um 16.295um 25.415um 16.505um
paint metal3
box 25.230um 16.320um 25.390um 16.480um
paint via3
box 25.205um 16.295um 25.415um 16.505um
paint metal4
box 24.850um 16.320um 25.390um 16.480um
paint metal4
# net net4  trunk=17.000
box 20.950um 7.150um 21.110um 7.310um
paint metal1
box 20.925um 7.125um 21.135um 7.335um
paint metal1
box 20.950um 7.150um 21.110um 7.310um
paint via1
box 20.925um 7.125um 21.135um 7.335um
paint metal2
box 20.925um 7.125um 21.135um 7.335um
paint metal2
box 20.950um 7.150um 21.110um 7.310um
paint via2
box 20.925um 7.125um 21.135um 7.335um
paint metal3
box 20.925um 7.125um 21.135um 7.335um
paint metal3
box 20.950um 7.150um 21.110um 7.310um
paint via3
box 20.925um 7.125um 21.135um 7.335um
paint metal4
box 11.850um 7.150um 21.110um 7.310um
paint metal4
box 11.825um 7.125um 12.035um 7.335um
paint metal3
box 11.850um 7.150um 12.010um 7.310um
paint via3
box 11.825um 7.125um 12.035um 7.335um
paint metal4
box 11.850um 7.150um 12.010um 17.080um
paint metal3
box 11.825um 16.895um 12.035um 17.105um
paint metal3
box 11.850um 16.920um 12.010um 17.080um
paint via3
box 11.825um 16.895um 12.035um 17.105um
paint metal4
box 21.460um 5.090um 21.620um 5.250um
paint metal1
box 21.435um 5.065um 21.645um 5.275um
paint metal1
box 21.460um 5.090um 21.620um 5.250um
paint via1
box 21.435um 5.065um 21.645um 5.275um
paint metal2
box 21.435um 5.065um 21.645um 5.275um
paint metal2
box 21.460um 5.090um 21.620um 5.250um
paint via2
box 21.435um 5.065um 21.645um 5.275um
paint metal3
box 21.435um 5.065um 21.645um 5.275um
paint metal3
box 21.460um 5.090um 21.620um 5.250um
paint via3
box 21.435um 5.065um 21.645um 5.275um
paint metal4
box 21.460um 5.090um 25.770um 5.250um
paint metal4
box 25.585um 5.065um 25.795um 5.275um
paint metal3
box 25.610um 5.090um 25.770um 5.250um
paint via3
box 25.585um 5.065um 25.795um 5.275um
paint metal4
box 25.610um 5.090um 25.770um 17.080um
paint metal3
box 25.585um 16.895um 25.795um 17.105um
paint metal3
box 25.610um 16.920um 25.770um 17.080um
paint via3
box 25.585um 16.895um 25.795um 17.105um
paint metal4
box 11.850um 16.920um 25.770um 17.080um
paint metal4
# net pfd_down  trunk=17.600
box 12.662um 2.825um 12.822um 2.985um
paint metal1
box 12.637um 2.800um 12.848um 3.010um
paint metal1
box 12.662um 2.825um 12.822um 2.985um
paint via1
box 12.637um 2.800um 12.848um 3.010um
paint metal2
box 12.637um 2.800um 12.848um 3.010um
paint metal2
box 12.662um 2.825um 12.822um 2.985um
paint via2
box 12.637um 2.800um 12.848um 3.010um
paint metal3
box 12.637um 2.800um 12.848um 3.010um
paint metal3
box 12.662um 2.825um 12.822um 2.985um
paint via3
box 12.637um 2.800um 12.848um 3.010um
paint metal4
box 12.112um 2.825um 12.822um 2.985um
paint metal4
box 12.087um 2.800um 12.297um 3.010um
paint metal3
box 12.112um 2.825um 12.272um 2.985um
paint via3
box 12.087um 2.800um 12.297um 3.010um
paint metal4
box 12.112um 2.825um 12.272um 17.680um
paint metal3
box 12.087um 17.495um 12.297um 17.705um
paint metal3
box 12.112um 17.520um 12.272um 17.680um
paint via3
box 12.087um 17.495um 12.297um 17.705um
paint metal4
box 15.918um 5.808um 16.078um 5.968um
paint metal1
box 15.893um 5.782um 16.102um 5.993um
paint metal1
box 15.918um 5.808um 16.078um 5.968um
paint via1
box 15.893um 5.782um 16.102um 5.993um
paint metal2
box 15.893um 5.782um 16.102um 5.993um
paint metal2
box 15.918um 5.808um 16.078um 5.968um
paint via2
box 15.893um 5.782um 16.102um 5.993um
paint metal3
box 15.893um 5.782um 16.102um 5.993um
paint metal3
box 15.918um 5.808um 16.078um 5.968um
paint via3
box 15.893um 5.782um 16.102um 5.993um
paint metal4
box 11.318um 5.808um 16.078um 5.968um
paint metal4
box 11.293um 5.782um 11.503um 5.993um
paint metal3
box 11.318um 5.808um 11.478um 5.968um
paint via3
box 11.293um 5.782um 11.503um 5.993um
paint metal4
box 11.318um 5.808um 11.478um 17.680um
paint metal3
box 11.293um 17.495um 11.503um 17.705um
paint metal3
box 11.318um 17.520um 11.478um 17.680um
paint via3
box 11.293um 17.495um 11.503um 17.705um
paint metal4
box 20.895um 4.240um 21.055um 4.400um
paint metal1
box 20.870um 4.215um 21.080um 4.425um
paint metal1
box 20.895um 4.240um 21.055um 4.400um
paint via1
box 20.870um 4.215um 21.080um 4.425um
paint metal2
box 20.870um 4.215um 21.080um 4.425um
paint metal2
box 20.895um 4.240um 21.055um 4.400um
paint via2
box 20.870um 4.215um 21.080um 4.425um
paint metal3
box 20.870um 4.215um 21.080um 4.425um
paint metal3
box 20.895um 4.240um 21.055um 4.400um
paint via3
box 20.870um 4.215um 21.080um 4.425um
paint metal4
box 20.895um 4.240um 26.105um 4.400um
paint metal4
box 25.920um 4.215um 26.130um 4.425um
paint metal3
box 25.945um 4.240um 26.105um 4.400um
paint via3
box 25.920um 4.215um 26.130um 4.425um
paint metal4
box 25.945um 4.240um 26.105um 17.680um
paint metal3
box 25.920um 17.495um 26.130um 17.705um
paint metal3
box 25.945um 17.520um 26.105um 17.680um
paint via3
box 25.920um 17.495um 26.130um 17.705um
paint metal4
box 11.318um 17.520um 26.105um 17.680um
paint metal4
# net pfd_up  trunk=18.200
box 12.662um 7.625um 12.822um 7.785um
paint metal1
box 12.637um 7.600um 12.848um 7.810um
paint metal1
box 12.662um 7.625um 12.822um 7.785um
paint via1
box 12.637um 7.600um 12.848um 7.810um
paint metal2
box 12.637um 7.600um 12.848um 7.810um
paint metal2
box 12.662um 7.625um 12.822um 7.785um
paint via2
box 12.637um 7.600um 12.848um 7.810um
paint metal3
box 12.637um 7.600um 12.848um 7.810um
paint metal3
box 12.662um 7.625um 12.822um 7.785um
paint via3
box 12.637um 7.600um 12.848um 7.810um
paint metal4
box 9.862um 7.625um 12.822um 7.785um
paint metal4
box 9.837um 7.600um 10.047um 7.810um
paint metal3
box 9.862um 7.625um 10.022um 7.785um
paint via3
box 9.837um 7.600um 10.047um 7.810um
paint metal4
box 9.862um 7.625um 10.022um 18.280um
paint metal3
box 9.837um 18.095um 10.047um 18.305um
paint metal3
box 9.862um 18.120um 10.022um 18.280um
paint via3
box 9.837um 18.095um 10.047um 18.305um
paint metal4
box 15.385um 4.838um 15.545um 4.998um
paint metal1
box 15.360um 4.812um 15.570um 5.023um
paint metal1
box 15.385um 4.838um 15.545um 4.998um
paint via1
box 15.360um 4.812um 15.570um 5.023um
paint metal2
box 15.360um 4.812um 15.570um 5.023um
paint metal2
box 15.385um 4.838um 15.545um 4.998um
paint via2
box 15.360um 4.812um 15.570um 5.023um
paint metal3
box 15.360um 4.812um 15.570um 5.023um
paint metal3
box 15.385um 4.838um 15.545um 4.998um
paint via3
box 15.360um 4.812um 15.570um 5.023um
paint metal4
box 9.435um 4.838um 15.545um 4.998um
paint metal4
box 9.410um 4.812um 9.620um 5.023um
paint metal3
box 9.435um 4.838um 9.595um 4.998um
paint via3
box 9.410um 4.812um 9.620um 5.023um
paint metal4
box 9.435um 4.838um 9.595um 18.280um
paint metal3
box 9.410um 18.095um 9.620um 18.305um
paint metal3
box 9.435um 18.120um 9.595um 18.280um
paint via3
box 9.410um 18.095um 9.620um 18.305um
paint metal4
box 17.938um 4.295um 18.098um 4.455um
paint metal1
box 17.913um 4.270um 18.122um 4.480um
paint metal1
box 17.938um 4.295um 18.098um 4.455um
paint via1
box 17.913um 4.270um 18.122um 4.480um
paint metal2
box 17.913um 4.270um 18.122um 4.480um
paint metal2
box 17.938um 4.295um 18.098um 4.455um
paint via2
box 17.913um 4.270um 18.122um 4.480um
paint metal3
box 17.913um 4.270um 18.122um 4.480um
paint metal3
box 17.938um 4.295um 18.098um 4.455um
paint via3
box 17.913um 4.270um 18.122um 4.480um
paint metal4
box 7.938um 4.295um 18.098um 4.455um
paint metal4
box 7.912um 4.270um 8.123um 4.480um
paint metal3
box 7.938um 4.295um 8.098um 4.455um
paint via3
box 7.912um 4.270um 8.123um 4.480um
paint metal4
box 7.938um 4.295um 8.098um 18.280um
paint metal3
box 7.912um 18.095um 8.123um 18.305um
paint metal3
box 7.938um 18.120um 8.098um 18.280um
paint via3
box 7.912um 18.095um 8.123um 18.305um
paint metal4
box 7.938um 18.120um 10.022um 18.280um
paint metal4
# net vbn  trunk=18.800
box 21.320um 2.780um 21.480um 2.940um
paint metal1
box 21.295um 2.755um 21.505um 2.965um
paint metal1
box 21.320um 2.780um 21.480um 2.940um
paint via1
box 21.295um 2.755um 21.505um 2.965um
paint metal2
box 21.295um 2.755um 21.505um 2.965um
paint metal2
box 21.320um 2.780um 21.480um 2.940um
paint via2
box 21.295um 2.755um 21.505um 2.965um
paint metal3
box 21.295um 2.755um 21.505um 2.965um
paint metal3
box 21.320um 2.780um 21.480um 2.940um
paint via3
box 21.295um 2.755um 21.505um 2.965um
paint metal4
box 21.320um 2.780um 26.530um 2.940um
paint metal4
box 26.345um 2.755um 26.555um 2.965um
paint metal3
box 26.370um 2.780um 26.530um 2.940um
paint via3
box 26.345um 2.755um 26.555um 2.965um
paint metal4
box 26.370um 2.780um 26.530um 18.880um
paint metal3
box 26.345um 18.695um 26.555um 18.905um
paint metal3
box 26.370um 18.720um 26.530um 18.880um
paint via3
box 26.345um 18.695um 26.555um 18.905um
paint metal4
box 22.110um -2.480um 22.270um -2.320um
paint metal1
box 22.085um -2.505um 22.295um -2.295um
paint metal1
box 22.110um -2.480um 22.270um -2.320um
paint via1
box 22.085um -2.505um 22.295um -2.295um
paint metal2
box 22.085um -2.505um 22.295um -2.295um
paint metal2
box 22.110um -2.480um 22.270um -2.320um
paint via2
box 22.085um -2.505um 22.295um -2.295um
paint metal3
box 22.085um -2.505um 22.295um -2.295um
paint metal3
box 22.110um -2.480um 22.270um -2.320um
paint via3
box 22.085um -2.505um 22.295um -2.295um
paint metal4
box 22.110um -2.480um 26.870um -2.320um
paint metal4
box 26.685um -2.505um 26.895um -2.295um
paint metal3
box 26.710um -2.480um 26.870um -2.320um
paint via3
box 26.685um -2.505um 26.895um -2.295um
paint metal4
box 26.710um -2.480um 26.870um 18.880um
paint metal3
box 26.685um 18.695um 26.895um 18.905um
paint metal3
box 26.710um 18.720um 26.870um 18.880um
paint via3
box 26.685um 18.695um 26.895um 18.905um
paint metal4
box 21.430um -1.400um 21.590um -1.240um
paint metal1
box 21.405um -1.425um 21.615um -1.215um
paint metal1
box 21.430um -1.400um 21.590um -1.240um
paint via1
box 21.405um -1.425um 21.615um -1.215um
paint metal2
box 21.405um -1.425um 21.615um -1.215um
paint metal2
box 21.430um -1.400um 21.590um -1.240um
paint via2
box 21.405um -1.425um 21.615um -1.215um
paint metal3
box 21.405um -1.425um 21.615um -1.215um
paint metal3
box 21.430um -1.400um 21.590um -1.240um
paint via3
box 21.405um -1.425um 21.615um -1.215um
paint metal4
box 21.430um -1.400um 27.540um -1.240um
paint metal4
box 27.355um -1.425um 27.565um -1.215um
paint metal3
box 27.380um -1.400um 27.540um -1.240um
paint via3
box 27.355um -1.425um 27.565um -1.215um
paint metal4
box 27.380um -1.400um 27.540um 18.880um
paint metal3
box 27.355um 18.695um 27.565um 18.905um
paint metal3
box 27.380um 18.720um 27.540um 18.880um
paint via3
box 27.355um 18.695um 27.565um 18.905um
paint metal4
box 22.120um -0.930um 22.280um -0.770um
paint metal1
box 22.095um -0.955um 22.305um -0.745um
paint metal1
box 22.120um -0.930um 22.280um -0.770um
paint via1
box 22.095um -0.955um 22.305um -0.745um
paint metal2
box 22.095um -0.955um 22.305um -0.745um
paint metal2
box 22.120um -0.930um 22.280um -0.770um
paint via2
box 22.095um -0.955um 22.305um -0.745um
paint metal3
box 22.095um -0.955um 22.305um -0.745um
paint metal3
box 22.120um -0.930um 22.280um -0.770um
paint via3
box 22.095um -0.955um 22.305um -0.745um
paint metal4
box 22.120um -0.930um 28.230um -0.770um
paint metal4
box 28.045um -0.955um 28.255um -0.745um
paint metal3
box 28.070um -0.930um 28.230um -0.770um
paint via3
box 28.045um -0.955um 28.255um -0.745um
paint metal4
box 28.070um -0.930um 28.230um 18.880um
paint metal3
box 28.045um 18.695um 28.255um 18.905um
paint metal3
box 28.070um 18.720um 28.230um 18.880um
paint via3
box 28.045um 18.695um 28.255um 18.905um
paint metal4
box 19.850um -15.310um 20.010um -15.150um
paint metal1
box 19.825um -15.335um 20.035um -15.125um
paint metal1
box 19.850um -15.310um 20.010um -15.150um
paint via1
box 19.825um -15.335um 20.035um -15.125um
paint metal2
box 19.825um -15.335um 20.035um -15.125um
paint metal2
box 19.850um -15.310um 20.010um -15.150um
paint via2
box 19.825um -15.335um 20.035um -15.125um
paint metal3
box 19.825um -15.335um 20.035um -15.125um
paint metal3
box 19.850um -15.310um 20.010um -15.150um
paint via3
box 19.825um -15.335um 20.035um -15.125um
paint metal4
box 19.850um -15.310um 28.660um -15.150um
paint metal4
box 28.475um -15.335um 28.685um -15.125um
paint metal3
box 28.500um -15.310um 28.660um -15.150um
paint via3
box 28.475um -15.335um 28.685um -15.125um
paint metal4
box 28.500um -15.310um 28.660um 18.880um
paint metal3
box 28.475um 18.695um 28.685um 18.905um
paint metal3
box 28.500um 18.720um 28.660um 18.880um
paint via3
box 28.475um 18.695um 28.685um 18.905um
paint metal4
box 26.370um 18.720um 28.660um 18.880um
paint metal4
# net vbp  trunk=19.400
box 21.640um 7.870um 21.800um 8.030um
paint metal1
box 21.615um 7.845um 21.825um 8.055um
paint metal1
box 21.640um 7.870um 21.800um 8.030um
paint via1
box 21.615um 7.845um 21.825um 8.055um
paint metal2
box 21.615um 7.845um 21.825um 8.055um
paint metal2
box 21.640um 7.870um 21.800um 8.030um
paint via2
box 21.615um 7.845um 21.825um 8.055um
paint metal3
box 21.615um 7.845um 21.825um 8.055um
paint metal3
box 21.640um 7.870um 21.800um 8.030um
paint via3
box 21.615um 7.845um 21.825um 8.055um
paint metal4
box 21.640um 7.870um 29.100um 8.030um
paint metal4
box 28.915um 7.845um 29.125um 8.055um
paint metal3
box 28.940um 7.870um 29.100um 8.030um
paint via3
box 28.915um 7.845um 29.125um 8.055um
paint metal4
box 28.940um 7.870um 29.100um 19.480um
paint metal3
box 28.915um 19.295um 29.125um 19.505um
paint metal3
box 28.940um 19.320um 29.100um 19.480um
paint via3
box 28.915um 19.295um 29.125um 19.505um
paint metal4
box 21.420um -2.950um 21.580um -2.790um
paint metal1
box 21.395um -2.975um 21.605um -2.765um
paint metal1
box 21.420um -2.950um 21.580um -2.790um
paint via1
box 21.395um -2.975um 21.605um -2.765um
paint metal2
box 21.395um -2.975um 21.605um -2.765um
paint metal2
box 21.420um -2.950um 21.580um -2.790um
paint via2
box 21.395um -2.975um 21.605um -2.765um
paint metal3
box 21.395um -2.975um 21.605um -2.765um
paint metal3
box 21.420um -2.950um 21.580um -2.790um
paint via3
box 21.395um -2.975um 21.605um -2.765um
paint metal4
box 21.420um -2.950um 29.780um -2.790um
paint metal4
box 29.595um -2.975um 29.805um -2.765um
paint metal3
box 29.620um -2.950um 29.780um -2.790um
paint via3
box 29.595um -2.975um 29.805um -2.765um
paint metal4
box 29.620um -2.950um 29.780um 19.480um
paint metal3
box 29.595um 19.295um 29.805um 19.505um
paint metal3
box 29.620um 19.320um 29.780um 19.480um
paint via3
box 29.595um 19.295um 29.805um 19.505um
paint metal4
box 23.070um -4.660um 23.230um -4.500um
paint metal1
box 23.045um -4.685um 23.255um -4.475um
paint metal1
box 23.070um -4.660um 23.230um -4.500um
paint via1
box 23.045um -4.685um 23.255um -4.475um
paint metal2
box 23.045um -4.685um 23.255um -4.475um
paint metal2
box 23.070um -4.660um 23.230um -4.500um
paint via2
box 23.045um -4.685um 23.255um -4.475um
paint metal3
box 23.045um -4.685um 23.255um -4.475um
paint metal3
box 23.070um -4.660um 23.230um -4.500um
paint via3
box 23.045um -4.685um 23.255um -4.475um
paint metal4
box 16.670um -4.660um 23.230um -4.500um
paint metal4
box 16.645um -4.685um 16.855um -4.475um
paint metal3
box 16.670um -4.660um 16.830um -4.500um
paint via3
box 16.645um -4.685um 16.855um -4.475um
paint metal4
box 16.670um -4.660um 16.830um 19.480um
paint metal3
box 16.645um 19.295um 16.855um 19.505um
paint metal3
box 16.670um 19.320um 16.830um 19.480um
paint via3
box 16.645um 19.295um 16.855um 19.505um
paint metal4
box 22.380um -5.380um 22.540um -5.220um
paint metal1
box 22.355um -5.405um 22.565um -5.195um
paint metal1
box 22.380um -5.380um 22.540um -5.220um
paint via1
box 22.355um -5.405um 22.565um -5.195um
paint metal2
box 22.355um -5.405um 22.565um -5.195um
paint metal2
box 22.380um -5.380um 22.540um -5.220um
paint via2
box 22.355um -5.405um 22.565um -5.195um
paint metal3
box 22.355um -5.405um 22.565um -5.195um
paint metal3
box 22.380um -5.380um 22.540um -5.220um
paint via3
box 22.355um -5.405um 22.565um -5.195um
paint metal4
box 22.380um -5.380um 27.140um -5.220um
paint metal4
box 26.955um -5.405um 27.165um -5.195um
paint metal3
box 26.980um -5.380um 27.140um -5.220um
paint via3
box 26.955um -5.405um 27.165um -5.195um
paint metal4
box 26.980um -5.380um 27.140um 19.480um
paint metal3
box 26.955um 19.295um 27.165um 19.505um
paint metal3
box 26.980um 19.320um 27.140um 19.480um
paint via3
box 26.955um 19.295um 27.165um 19.505um
paint metal4
box 16.670um 19.320um 29.780um 19.480um
paint metal4
# net vco_out_div  trunk=20.000
box -1.580um 1.920um -1.420um 2.080um
paint metal1
box -1.605um 1.895um -1.395um 2.105um
paint metal1
box -1.580um 1.920um -1.420um 2.080um
paint via1
box -1.605um 1.895um -1.395um 2.105um
paint metal2
box -1.605um 1.895um -1.395um 2.105um
paint metal2
box -1.580um 1.920um -1.420um 2.080um
paint via2
box -1.605um 1.895um -1.395um 2.105um
paint metal3
box -1.605um 1.895um -1.395um 2.105um
paint metal3
box -1.580um 1.920um -1.420um 2.080um
paint via3
box -1.605um 1.895um -1.395um 2.105um
paint metal4
box -1.580um 1.920um -0.870um 2.080um
paint metal4
box -1.055um 1.895um -0.845um 2.105um
paint metal3
box -1.030um 1.920um -0.870um 2.080um
paint via3
box -1.055um 1.895um -0.845um 2.105um
paint metal4
box -1.030um 1.920um -0.870um 20.080um
paint metal3
box -1.055um 19.895um -0.845um 20.105um
paint metal3
box -1.030um 19.920um -0.870um 20.080um
paint via3
box -1.055um 19.895um -0.845um 20.105um
paint metal4
box 6.880um 1.880um 7.040um 2.040um
paint metal1
box 6.855um 1.855um 7.065um 2.065um
paint metal1
box 6.880um 1.880um 7.040um 2.040um
paint via1
box 6.855um 1.855um 7.065um 2.065um
paint metal2
box 6.855um 1.855um 7.065um 2.065um
paint metal2
box 6.880um 1.880um 7.040um 2.040um
paint via2
box 6.855um 1.855um 7.065um 2.065um
paint metal3
box 6.855um 1.855um 7.065um 2.065um
paint metal3
box 6.880um 1.880um 7.040um 2.040um
paint via3
box 6.855um 1.855um 7.065um 2.065um
paint metal4
box 5.880um 1.880um 7.040um 2.040um
paint metal4
box 5.855um 1.855um 6.065um 2.065um
paint metal3
box 5.880um 1.880um 6.040um 2.040um
paint via3
box 5.855um 1.855um 6.065um 2.065um
paint metal4
box 5.880um 1.880um 6.040um 20.080um
paint metal3
box 5.855um 19.895um 6.065um 20.105um
paint metal3
box 5.880um 19.920um 6.040um 20.080um
paint via3
box 5.855um 19.895um 6.065um 20.105um
paint metal4
box -1.030um 19.920um 6.040um 20.080um
paint metal4
# net vctrl  trunk=20.600
box 36.420um 22.920um 36.580um 23.080um
paint metal1
box 36.395um 22.895um 36.605um 23.105um
paint metal1
box 36.420um 22.920um 36.580um 23.080um
paint via1
box 36.395um 22.895um 36.605um 23.105um
paint metal2
box 36.395um 22.895um 36.605um 23.105um
paint metal2
box 36.420um 22.920um 36.580um 23.080um
paint via2
box 36.395um 22.895um 36.605um 23.105um
paint metal3
box 36.395um 22.895um 36.605um 23.105um
paint metal3
box 36.420um 22.920um 36.580um 23.080um
paint via3
box 36.395um 22.895um 36.605um 23.105um
paint metal4
box 35.870um 22.920um 36.580um 23.080um
paint metal4
box 35.845um 22.895um 36.055um 23.105um
paint metal3
box 35.870um 22.920um 36.030um 23.080um
paint via3
box 35.845um 22.895um 36.055um 23.105um
paint metal4
box 35.870um 20.520um 36.030um 23.080um
paint metal3
box 35.845um 20.495um 36.055um 20.705um
paint metal3
box 35.870um 20.520um 36.030um 20.680um
paint via3
box 35.845um 20.495um 36.055um 20.705um
paint metal4
box 20.640um 3.770um 20.800um 3.930um
paint metal1
box 20.950um 5.090um 21.110um 5.250um
paint metal1
box 46.830um -4.950um 46.990um -4.790um
paint metal1
box 46.805um -4.975um 47.015um -4.765um
paint metal1
box 46.830um -4.950um 46.990um -4.790um
paint via1
box 46.805um -4.975um 47.015um -4.765um
paint metal2
box 46.805um -4.975um 47.015um -4.765um
paint metal2
box 46.830um -4.950um 46.990um -4.790um
paint via2
box 46.805um -4.975um 47.015um -4.765um
paint metal3
box 46.805um -4.975um 47.015um -4.765um
paint metal3
box 46.830um -4.950um 46.990um -4.790um
paint via3
box 46.805um -4.975um 47.015um -4.765um
paint metal4
box 46.280um -4.950um 46.990um -4.790um
paint metal4
box 46.255um -4.975um 46.465um -4.765um
paint metal3
box 46.280um -4.950um 46.440um -4.790um
paint via3
box 46.255um -4.975um 46.465um -4.765um
paint metal4
box 46.280um -4.950um 46.440um 20.680um
paint metal3
box 46.255um 20.495um 46.465um 20.705um
paint metal3
box 46.280um 20.520um 46.440um 20.680um
paint via3
box 46.255um 20.495um 46.465um 20.705um
paint metal4
box 49.850um -12.450um 50.850um -11.450um
paint metal1
box 50.245um -12.055um 50.455um -11.845um
paint metal1
box 50.270um -12.030um 50.430um -11.870um
paint via1
box 50.245um -12.055um 50.455um -11.845um
paint metal2
box 50.245um -12.055um 50.455um -11.845um
paint metal2
box 50.270um -12.030um 50.430um -11.870um
paint via2
box 50.245um -12.055um 50.455um -11.845um
paint metal3
box 50.245um -12.055um 50.455um -11.845um
paint metal3
box 50.270um -12.030um 50.430um -11.870um
paint via3
box 50.245um -12.055um 50.455um -11.845um
paint metal4
box 49.720um -12.030um 50.430um -11.870um
paint metal4
box 49.695um -12.055um 49.905um -11.845um
paint metal3
box 49.720um -12.030um 49.880um -11.870um
paint via3
box 49.695um -12.055um 49.905um -11.845um
paint metal4
box 49.720um -12.030um 49.880um 20.680um
paint metal3
box 49.695um 20.495um 49.905um 20.705um
paint metal3
box 49.720um 20.520um 49.880um 20.680um
paint via3
box 49.695um 20.495um 49.905um 20.705um
paint metal4
box 60.365um -14.990um 60.525um -14.830um
paint metal1
box 60.340um -15.015um 60.550um -14.805um
paint metal1
box 60.365um -14.990um 60.525um -14.830um
paint via1
box 60.340um -15.015um 60.550um -14.805um
paint metal2
box 60.340um -15.015um 60.550um -14.805um
paint metal2
box 60.365um -14.990um 60.525um -14.830um
paint via2
box 60.340um -15.015um 60.550um -14.805um
paint metal3
box 60.340um -15.015um 60.550um -14.805um
paint metal3
box 60.365um -14.990um 60.525um -14.830um
paint via3
box 60.340um -15.015um 60.550um -14.805um
paint metal4
box 59.365um -14.990um 60.525um -14.830um
paint metal4
box 59.340um -15.015um 59.550um -14.805um
paint metal3
box 59.365um -14.990um 59.525um -14.830um
paint via3
box 59.340um -15.015um 59.550um -14.805um
paint metal4
box 59.365um -14.990um 59.525um 20.680um
paint metal3
box 59.340um 20.495um 59.550um 20.705um
paint metal3
box 59.365um 20.520um 59.525um 20.680um
paint via3
box 59.340um 20.495um 59.550um 20.705um
paint metal4
box 62.665um -14.990um 62.825um -14.830um
paint metal1
box 62.640um -15.015um 62.850um -14.805um
paint metal1
box 62.665um -14.990um 62.825um -14.830um
paint via1
box 62.640um -15.015um 62.850um -14.805um
paint metal2
box 62.640um -15.015um 62.850um -14.805um
paint metal2
box 62.665um -14.990um 62.825um -14.830um
paint via2
box 62.640um -15.015um 62.850um -14.805um
paint metal3
box 62.640um -15.015um 62.850um -14.805um
paint metal3
box 62.665um -14.990um 62.825um -14.830um
paint via3
box 62.640um -15.015um 62.850um -14.805um
paint metal4
box 61.665um -14.990um 62.825um -14.830um
paint metal4
box 61.640um -15.015um 61.850um -14.805um
paint metal3
box 61.665um -14.990um 61.825um -14.830um
paint via3
box 61.640um -15.015um 61.850um -14.805um
paint metal4
box 61.665um -14.990um 61.825um 20.680um
paint metal3
box 61.640um 20.495um 61.850um 20.705um
paint metal3
box 61.665um 20.520um 61.825um 20.680um
paint via3
box 61.640um 20.495um 61.850um 20.705um
paint metal4
box 58.065um -14.990um 58.225um -14.830um
paint metal1
box 58.040um -15.015um 58.250um -14.805um
paint metal1
box 58.065um -14.990um 58.225um -14.830um
paint via1
box 58.040um -15.015um 58.250um -14.805um
paint metal2
box 58.040um -15.015um 58.250um -14.805um
paint metal2
box 58.065um -14.990um 58.225um -14.830um
paint via2
box 58.040um -15.015um 58.250um -14.805um
paint metal3
box 58.040um -15.015um 58.250um -14.805um
paint metal3
box 58.065um -14.990um 58.225um -14.830um
paint via3
box 58.040um -15.015um 58.250um -14.805um
paint metal4
box 53.465um -14.990um 58.225um -14.830um
paint metal4
box 53.440um -15.015um 53.650um -14.805um
paint metal3
box 53.465um -14.990um 53.625um -14.830um
paint via3
box 53.440um -15.015um 53.650um -14.805um
paint metal4
box 53.465um -14.990um 53.625um 20.680um
paint metal3
box 53.440um 20.495um 53.650um 20.705um
paint metal3
box 53.465um 20.520um 53.625um 20.680um
paint via3
box 53.440um 20.495um 53.650um 20.705um
paint metal4
box 55.765um -12.790um 55.925um -12.630um
paint metal1
box 55.740um -12.815um 55.950um -12.605um
paint metal1
box 55.765um -12.790um 55.925um -12.630um
paint via1
box 55.740um -12.815um 55.950um -12.605um
paint metal2
box 55.740um -12.815um 55.950um -12.605um
paint metal2
box 55.765um -12.790um 55.925um -12.630um
paint via2
box 55.740um -12.815um 55.950um -12.605um
paint metal3
box 55.740um -12.815um 55.950um -12.605um
paint metal3
box 55.765um -12.790um 55.925um -12.630um
paint via3
box 55.740um -12.815um 55.950um -12.605um
paint metal4
box 52.965um -12.790um 55.925um -12.630um
paint metal4
box 52.940um -12.815um 53.150um -12.605um
paint metal3
box 52.965um -12.790um 53.125um -12.630um
paint via3
box 52.940um -12.815um 53.150um -12.605um
paint metal4
box 52.965um -12.790um 53.125um 20.680um
paint metal3
box 52.940um 20.495um 53.150um 20.705um
paint metal3
box 52.965um 20.520um 53.125um 20.680um
paint via3
box 52.940um 20.495um 53.150um 20.705um
paint metal4
box 35.870um 20.520um 61.825um 20.680um
paint metal4
# net net10  trunk=-21.000
box 58.380um -13.380um 58.540um -13.220um
paint metal1
box 57.750um -15.580um 57.910um -15.420um
paint metal1
# net net11  trunk=-21.600
box 63.290um -10.790um 63.450um -10.630um
paint metal1
box 63.265um -10.815um 63.475um -10.605um
paint metal1
box 63.290um -10.790um 63.450um -10.630um
paint via1
box 63.265um -10.815um 63.475um -10.605um
paint metal2
box 63.265um -10.815um 63.475um -10.605um
paint metal2
box 63.290um -10.790um 63.450um -10.630um
paint via2
box 63.265um -10.815um 63.475um -10.605um
paint metal3
box 63.265um -10.815um 63.475um -10.605um
paint metal3
box 63.290um -10.790um 63.450um -10.630um
paint via3
box 63.265um -10.815um 63.475um -10.605um
paint metal4
box 63.290um -10.790um 64.000um -10.630um
paint metal4
box 63.815um -10.815um 64.025um -10.605um
paint metal3
box 63.840um -10.790um 64.000um -10.630um
paint via3
box 63.815um -10.815um 64.025um -10.605um
paint metal4
box 63.840um -21.680um 64.000um -10.630um
paint metal3
box 63.815um -21.705um 64.025um -21.495um
paint metal3
box 63.840um -21.680um 64.000um -21.520um
paint via3
box 63.815um -21.705um 64.025um -21.495um
paint metal4
box 62.660um -8.190um 62.820um -8.030um
paint metal1
box 63.840um -21.680um 64.000um -21.520um
paint metal4
# net net12  trunk=-22.200
box 62.975um -7.410um 63.135um -7.250um
paint metal1
box 62.950um -7.435um 63.160um -7.225um
paint metal1
box 62.975um -7.410um 63.135um -7.250um
paint via1
box 62.950um -7.435um 63.160um -7.225um
paint metal2
box 62.950um -7.435um 63.160um -7.225um
paint metal2
box 62.975um -7.410um 63.135um -7.250um
paint via2
box 62.950um -7.435um 63.160um -7.225um
paint metal3
box 62.950um -7.435um 63.160um -7.225um
paint metal3
box 62.975um -7.410um 63.135um -7.250um
paint via3
box 62.950um -7.435um 63.160um -7.225um
paint metal4
box 62.975um -7.410um 66.385um -7.250um
paint metal4
box 66.200um -7.435um 66.410um -7.225um
paint metal3
box 66.225um -7.410um 66.385um -7.250um
paint via3
box 66.200um -7.435um 66.410um -7.225um
paint metal4
box 66.225um -22.280um 66.385um -7.250um
paint metal3
box 66.200um -22.305um 66.410um -22.095um
paint metal3
box 66.225um -22.280um 66.385um -22.120um
paint via3
box 66.200um -22.305um 66.410um -22.095um
paint metal4
box 60.675um -7.410um 60.835um -7.250um
paint metal1
box 60.650um -7.435um 60.860um -7.225um
paint metal1
box 60.675um -7.410um 60.835um -7.250um
paint via1
box 60.650um -7.435um 60.860um -7.225um
paint metal2
box 60.650um -7.435um 60.860um -7.225um
paint metal2
box 60.675um -7.410um 60.835um -7.250um
paint via2
box 60.650um -7.435um 60.860um -7.225um
paint metal3
box 60.650um -7.435um 60.860um -7.225um
paint metal3
box 60.675um -7.410um 60.835um -7.250um
paint via3
box 60.650um -7.435um 60.860um -7.225um
paint metal4
box 52.475um -7.410um 60.835um -7.250um
paint metal4
box 52.450um -7.435um 52.660um -7.225um
paint metal3
box 52.475um -7.410um 52.635um -7.250um
paint via3
box 52.450um -7.435um 52.660um -7.225um
paint metal4
box 52.475um -22.280um 52.635um -7.250um
paint metal3
box 52.450um -22.305um 52.660um -22.095um
paint metal3
box 52.475um -22.280um 52.635um -22.120um
paint via3
box 52.450um -22.305um 52.660um -22.095um
paint metal4
box 58.375um -7.410um 58.535um -7.250um
paint metal1
box 58.350um -7.435um 58.560um -7.225um
paint metal1
box 58.375um -7.410um 58.535um -7.250um
paint via1
box 58.350um -7.435um 58.560um -7.225um
paint metal2
box 51.975um -7.410um 58.535um -7.250um
paint metal2
box 51.950um -7.435um 52.160um -7.225um
paint metal2
box 51.975um -7.410um 52.135um -7.250um
paint via2
box 51.950um -7.435um 52.160um -7.225um
paint metal3
box 51.975um -22.280um 52.135um -7.250um
paint metal3
box 51.950um -22.305um 52.160um -22.095um
paint metal3
box 51.975um -22.280um 52.135um -22.120um
paint via3
box 51.950um -22.305um 52.160um -22.095um
paint metal4
box 55.760um -8.190um 55.920um -8.030um
paint metal1
box 55.735um -8.215um 55.945um -8.005um
paint metal1
box 55.760um -8.190um 55.920um -8.030um
paint via1
box 55.735um -8.215um 55.945um -8.005um
paint metal2
box 55.735um -8.215um 55.945um -8.005um
paint metal2
box 55.760um -8.190um 55.920um -8.030um
paint via2
box 55.735um -8.215um 55.945um -8.005um
paint metal3
box 55.735um -8.215um 55.945um -8.005um
paint metal3
box 55.760um -8.190um 55.920um -8.030um
paint via3
box 55.735um -8.215um 55.945um -8.005um
paint metal4
box 48.460um -8.190um 55.920um -8.030um
paint metal4
box 48.435um -8.215um 48.645um -8.005um
paint metal3
box 48.460um -8.190um 48.620um -8.030um
paint via3
box 48.435um -8.215um 48.645um -8.005um
paint metal4
box 48.460um -22.280um 48.620um -8.030um
paint metal3
box 48.435um -22.305um 48.645um -22.095um
paint metal3
box 48.460um -22.280um 48.620um -22.120um
paint via3
box 48.435um -22.305um 48.645um -22.095um
paint metal4
box 56.075um -7.410um 56.235um -7.250um
paint metal1
box 55.450um -13.380um 55.610um -13.220um
paint metal1
box 55.425um -13.405um 55.635um -13.195um
paint metal1
box 55.450um -13.380um 55.610um -13.220um
paint via1
box 55.425um -13.405um 55.635um -13.195um
paint metal2
box 55.425um -13.405um 55.635um -13.195um
paint metal2
box 55.450um -13.380um 55.610um -13.220um
paint via2
box 55.425um -13.405um 55.635um -13.195um
paint metal3
box 55.425um -13.405um 55.635um -13.195um
paint metal3
box 55.450um -13.380um 55.610um -13.220um
paint via3
box 55.425um -13.405um 55.635um -13.195um
paint metal4
box 54.900um -13.380um 55.610um -13.220um
paint metal4
box 54.875um -13.405um 55.085um -13.195um
paint metal3
box 54.900um -13.380um 55.060um -13.220um
paint via3
box 54.875um -13.405um 55.085um -13.195um
paint metal4
box 54.900um -22.280um 55.060um -13.220um
paint metal3
box 54.875um -22.305um 55.085um -22.095um
paint metal3
box 54.900um -22.280um 55.060um -22.120um
paint via3
box 54.875um -22.305um 55.085um -22.095um
paint metal4
box 48.460um -22.280um 66.385um -22.120um
paint metal4
# net net13  trunk=-22.800
box 60.990um -10.790um 61.150um -10.630um
paint metal1
box 60.965um -10.815um 61.175um -10.605um
paint metal1
box 60.990um -10.790um 61.150um -10.630um
paint via1
box 60.965um -10.815um 61.175um -10.605um
paint metal2
box 60.965um -10.815um 61.175um -10.605um
paint metal2
box 60.990um -10.790um 61.150um -10.630um
paint via2
box 60.965um -10.815um 61.175um -10.605um
paint metal3
box 60.965um -10.815um 61.175um -10.605um
paint metal3
box 60.990um -10.790um 61.150um -10.630um
paint via3
box 60.965um -10.815um 61.175um -10.605um
paint metal4
box 48.740um -10.790um 61.150um -10.630um
paint metal4
box 48.715um -10.815um 48.925um -10.605um
paint metal3
box 48.740um -10.790um 48.900um -10.630um
paint via3
box 48.715um -10.815um 48.925um -10.605um
paint metal4
box 48.740um -22.880um 48.900um -10.630um
paint metal3
box 48.715um -22.905um 48.925um -22.695um
paint metal3
box 48.740um -22.880um 48.900um -22.720um
paint via3
box 48.715um -22.905um 48.925um -22.695um
paint metal4
box 60.360um -8.190um 60.520um -8.030um
paint metal1
box 48.740um -22.880um 48.900um -22.720um
paint metal4
# net net14  trunk=-23.400
box 58.690um -10.790um 58.850um -10.630um
paint metal1
box 58.665um -10.815um 58.875um -10.605um
paint metal1
box 58.690um -10.790um 58.850um -10.630um
paint via1
box 58.665um -10.815um 58.875um -10.605um
paint metal2
box 47.790um -10.790um 58.850um -10.630um
paint metal2
box 47.765um -10.815um 47.975um -10.605um
paint metal2
box 47.790um -10.790um 47.950um -10.630um
paint via2
box 47.765um -10.815um 47.975um -10.605um
paint metal3
box 47.790um -23.480um 47.950um -10.630um
paint metal3
box 47.765um -23.505um 47.975um -23.295um
paint metal3
box 47.790um -23.480um 47.950um -23.320um
paint via3
box 47.765um -23.505um 47.975um -23.295um
paint metal4
box 58.060um -8.190um 58.220um -8.030um
paint metal1
box 47.790um -23.480um 47.950um -23.320um
paint metal4
# net net5  trunk=-24.000
box 62.980um -13.380um 63.140um -13.220um
paint metal1
box 62.350um -15.580um 62.510um -15.420um
paint metal1
box 62.325um -15.605um 62.535um -15.395um
paint metal1
box 62.350um -15.580um 62.510um -15.420um
paint via1
box 62.325um -15.605um 62.535um -15.395um
paint metal2
box 62.325um -15.605um 62.535um -15.395um
paint metal2
box 62.350um -15.580um 62.510um -15.420um
paint via2
box 62.325um -15.605um 62.535um -15.395um
paint metal3
box 62.325um -15.605um 62.535um -15.395um
paint metal3
box 62.350um -15.580um 62.510um -15.420um
paint via3
box 62.325um -15.605um 62.535um -15.395um
paint metal4
box 62.350um -15.580um 68.460um -15.420um
paint metal4
box 68.275um -15.605um 68.485um -15.395um
paint metal3
box 68.300um -15.580um 68.460um -15.420um
paint via3
box 68.275um -15.605um 68.485um -15.395um
paint metal4
box 68.300um -24.080um 68.460um -15.420um
paint metal3
box 68.275um -24.105um 68.485um -23.895um
paint metal3
box 68.300um -24.080um 68.460um -23.920um
paint via3
box 68.275um -24.105um 68.485um -23.895um
paint metal4
box 68.300um -24.080um 68.460um -23.920um
paint metal4
# net net6  trunk=-24.600
box 62.660um -10.790um 62.820um -10.630um
paint metal1
box 62.350um -13.380um 62.510um -13.220um
paint metal1
box 58.375um -10.010um 58.535um -9.850um
paint metal1
box 58.350um -10.035um 58.560um -9.825um
paint metal1
box 58.375um -10.010um 58.535um -9.850um
paint via1
box 58.350um -10.035um 58.560um -9.825um
paint metal2
box 58.350um -10.035um 58.560um -9.825um
paint metal2
box 58.375um -10.010um 58.535um -9.850um
paint via2
box 58.350um -10.035um 58.560um -9.825um
paint metal3
box 58.350um -10.035um 58.560um -9.825um
paint metal3
box 58.375um -10.010um 58.535um -9.850um
paint via3
box 58.350um -10.035um 58.560um -9.825um
paint metal4
box 58.375um -10.010um 68.985um -9.850um
paint metal4
box 68.800um -10.035um 69.010um -9.825um
paint metal3
box 68.825um -10.010um 68.985um -9.850um
paint via3
box 68.800um -10.035um 69.010um -9.825um
paint metal4
box 68.825um -24.680um 68.985um -9.850um
paint metal3
box 68.800um -24.705um 69.010um -24.495um
paint metal3
box 68.825um -24.680um 68.985um -24.520um
paint via3
box 68.800um -24.705um 69.010um -24.495um
paint metal4
box 58.065um -12.790um 58.225um -12.630um
paint metal1
box 58.040um -12.815um 58.250um -12.605um
paint metal1
box 58.065um -12.790um 58.225um -12.630um
paint via1
box 58.040um -12.815um 58.250um -12.605um
paint metal2
box 58.040um -12.815um 58.250um -12.605um
paint metal2
box 58.065um -12.790um 58.225um -12.630um
paint via2
box 58.040um -12.815um 58.250um -12.605um
paint metal3
box 58.040um -12.815um 58.250um -12.605um
paint metal3
box 58.065um -12.790um 58.225um -12.630um
paint via3
box 58.040um -12.815um 58.250um -12.605um
paint metal4
box 58.065um -12.790um 69.575um -12.630um
paint metal4
box 69.390um -12.815um 69.600um -12.605um
paint metal3
box 69.415um -12.790um 69.575um -12.630um
paint via3
box 69.390um -12.815um 69.600um -12.605um
paint metal4
box 69.415um -24.680um 69.575um -12.630um
paint metal3
box 69.390um -24.705um 69.600um -24.495um
paint metal3
box 69.415um -24.680um 69.575um -24.520um
paint via3
box 69.390um -24.705um 69.600um -24.495um
paint metal4
box 65.275um -10.010um 65.435um -9.850um
paint metal1
box 65.250um -10.035um 65.460um -9.825um
paint metal1
box 65.275um -10.010um 65.435um -9.850um
paint via1
box 65.250um -10.035um 65.460um -9.825um
paint metal2
box 65.275um -10.010um 70.035um -9.850um
paint metal2
box 69.850um -10.035um 70.060um -9.825um
paint metal2
box 69.875um -10.010um 70.035um -9.850um
paint via2
box 69.850um -10.035um 70.060um -9.825um
paint metal3
box 69.875um -24.680um 70.035um -9.850um
paint metal3
box 69.850um -24.705um 70.060um -24.495um
paint metal3
box 69.875um -24.680um 70.035um -24.520um
paint via3
box 69.850um -24.705um 70.060um -24.495um
paint metal4
box 64.965um -12.790um 65.125um -12.630um
paint metal1
box 64.940um -12.815um 65.150um -12.605um
paint metal1
box 64.965um -12.790um 65.125um -12.630um
paint via1
box 64.940um -12.815um 65.150um -12.605um
paint metal2
box 64.965um -12.790um 69.275um -12.630um
paint metal2
box 69.090um -12.815um 69.300um -12.605um
paint metal2
box 69.115um -12.790um 69.275um -12.630um
paint via2
box 69.090um -12.815um 69.300um -12.605um
paint metal3
box 69.115um -24.680um 69.275um -12.630um
paint metal3
box 69.090um -24.705um 69.300um -24.495um
paint metal3
box 69.115um -24.680um 69.275um -24.520um
paint via3
box 69.090um -24.705um 69.300um -24.495um
paint metal4
box 68.825um -24.680um 70.035um -24.520um
paint metal4
# net net7  trunk=-25.200
box 60.360um -10.790um 60.520um -10.630um
paint metal1
box 60.050um -13.380um 60.210um -13.220um
paint metal1
box 62.975um -10.010um 63.135um -9.850um
paint metal1
box 62.665um -12.790um 62.825um -12.630um
paint metal1
box 62.640um -12.815um 62.850um -12.605um
paint metal1
box 62.665um -12.790um 62.825um -12.630um
paint via1
box 62.640um -12.815um 62.850um -12.605um
paint metal2
box 62.665um -12.790um 64.275um -12.630um
paint metal2
box 64.090um -12.815um 64.300um -12.605um
paint metal2
box 64.115um -12.790um 64.275um -12.630um
paint via2
box 64.090um -12.815um 64.300um -12.605um
paint metal3
box 64.115um -25.280um 64.275um -12.630um
paint metal3
box 64.090um -25.305um 64.300um -25.095um
paint metal3
box 64.115um -25.280um 64.275um -25.120um
paint via3
box 64.090um -25.305um 64.300um -25.095um
paint metal4
box 64.115um -25.280um 64.275um -25.120um
paint metal4
# net net8  trunk=-25.800
box 60.680um -13.380um 60.840um -13.220um
paint metal1
box 60.050um -15.580um 60.210um -15.420um
paint metal1
# net net9  trunk=-26.400
box 58.060um -10.790um 58.220um -10.630um
paint metal1
box 57.750um -13.380um 57.910um -13.220um
paint metal1
box 60.675um -10.010um 60.835um -9.850um
paint metal1
box 60.365um -12.790um 60.525um -12.630um
paint metal1
# net out  trunk=-27.000
box 66.890um -12.000um 67.050um -11.840um
paint metal1
box 66.865um -12.025um 67.075um -11.815um
paint metal1
box 66.890um -12.000um 67.050um -11.840um
paint via1
box 66.865um -12.025um 67.075um -11.815um
paint metal2
box 66.865um -12.025um 67.075um -11.815um
paint metal2
box 66.890um -12.000um 67.050um -11.840um
paint via2
box 66.865um -12.025um 67.075um -11.815um
paint metal3
box 66.865um -12.025um 67.075um -11.815um
paint metal3
box 66.890um -12.000um 67.050um -11.840um
paint via3
box 66.865um -12.025um 67.075um -11.815um
paint metal4
box 66.890um -12.000um 70.300um -11.840um
paint metal4
box 70.115um -12.025um 70.325um -11.815um
paint metal3
box 70.140um -12.000um 70.300um -11.840um
paint via3
box 70.115um -12.025um 70.325um -11.815um
paint metal4
box 70.140um -27.080um 70.300um -11.840um
paint metal3
box 70.115um -27.105um 70.325um -26.895um
paint metal3
box 70.140um -27.080um 70.300um -26.920um
paint via3
box 70.115um -27.105um 70.325um -26.895um
paint metal4
box 64.960um -10.790um 65.120um -10.630um
paint metal1
box 64.650um -13.380um 64.810um -13.220um
paint metal1
box 64.625um -13.405um 64.835um -13.195um
paint metal1
box 64.650um -13.380um 64.810um -13.220um
paint via1
box 64.625um -13.405um 64.835um -13.195um
paint metal2
box 64.625um -13.405um 64.835um -13.195um
paint metal2
box 64.650um -13.380um 64.810um -13.220um
paint via2
box 64.625um -13.405um 64.835um -13.195um
paint metal3
box 64.625um -13.405um 64.835um -13.195um
paint metal3
box 64.650um -13.380um 64.810um -13.220um
paint via3
box 64.625um -13.405um 64.835um -13.195um
paint metal4
box 64.650um -13.380um 70.760um -13.220um
paint metal4
box 70.575um -13.405um 70.785um -13.195um
paint metal3
box 70.600um -13.380um 70.760um -13.220um
paint via3
box 70.575um -13.405um 70.785um -13.195um
paint metal4
box 70.600um -27.080um 70.760um -13.220um
paint metal3
box 70.575um -27.105um 70.785um -26.895um
paint metal3
box 70.600um -27.080um 70.760um -26.920um
paint via3
box 70.575um -27.105um 70.785um -26.895um
paint metal4
box 70.140um -27.080um 70.760um -26.920um
paint metal4
box -5.500um 12.100um 84.000um 12.900um
paint metal5
box -5.500um -19.400um 84.000um -18.600um
paint metal5
save pll_analog
puts DONE
quit -noprompt
