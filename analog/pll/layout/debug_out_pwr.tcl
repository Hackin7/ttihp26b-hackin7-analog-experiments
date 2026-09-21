drc off
cd /repo/analog/pll/layout
file copy -force pll_analog_bare.mag pll_analog.mag
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
box 66.220um -12.000um 67.050um -11.840um
paint metal4
box 66.195um -12.025um 66.405um -11.815um
paint metal3
box 66.220um -12.000um 66.380um -11.840um
paint via3
box 66.195um -12.025um 66.405um -11.815um
paint metal4
box 66.220um -27.080um 66.380um -11.840um
paint metal3
box 66.195um -27.105um 66.405um -26.895um
paint metal3
box 66.220um -27.080um 66.380um -26.920um
paint via3
box 66.195um -27.105um 66.405um -26.895um
paint metal4
box 64.960um -10.790um 65.120um -10.630um
paint metal1
box 64.935um -10.815um 65.145um -10.605um
paint metal1
box 64.960um -10.790um 65.120um -10.630um
paint via1
box 64.935um -10.815um 65.145um -10.605um
paint metal2
box 64.935um -10.815um 65.145um -10.605um
paint metal2
box 64.960um -10.790um 65.120um -10.630um
paint via2
box 64.935um -10.815um 65.145um -10.605um
paint metal3
box 64.935um -10.815um 65.145um -10.605um
paint metal3
box 64.960um -10.790um 65.120um -10.630um
paint via3
box 64.935um -10.815um 65.145um -10.605um
paint metal4
box 64.320um -10.790um 65.120um -10.630um
paint metal4
box 64.295um -10.815um 64.505um -10.605um
paint metal3
box 64.320um -10.790um 64.480um -10.630um
paint via3
box 64.295um -10.815um 64.505um -10.605um
paint metal4
box 64.320um -27.080um 64.480um -10.630um
paint metal3
box 64.295um -27.105um 64.505um -26.895um
paint metal3
box 64.320um -27.080um 64.480um -26.920um
paint via3
box 64.295um -27.105um 64.505um -26.895um
paint metal4
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
box 64.020um -13.380um 64.810um -13.220um
paint metal4
box 63.995um -13.405um 64.205um -13.195um
paint metal3
box 64.020um -13.380um 64.180um -13.220um
paint via3
box 63.995um -13.405um 64.205um -13.195um
paint metal4
box 64.020um -27.080um 64.180um -13.220um
paint metal3
box 63.995um -27.105um 64.205um -26.895um
paint metal3
box 64.020um -27.080um 64.180um -26.920um
paint via3
box 63.995um -27.105um 64.205um -26.895um
paint metal4
box 64.020um -27.080um 66.380um -26.920um
paint metal4
box -5.0um 12.1um 90.0um 12.9um
paint metal5
box -5.0um -19.4um 90.0um -18.6um
paint metal5
box 65.590um -10.790um 65.750um -10.630um
paint metal1
box 65.565um -10.815um 65.775um -10.605um
paint metal1
box 65.590um -10.790um 65.750um -10.630um
paint via1
box 65.565um -10.815um 65.775um -10.605um
paint metal2
box 65.590um -10.790um 65.750um -9.930um
paint metal2
box 65.590um -10.090um 82.080um -9.930um
paint metal2
box 81.895um -10.115um 82.105um -9.905um
paint metal2
box 81.920um -10.090um 82.080um -9.930um
paint via2
box 81.895um -10.115um 82.105um -9.905um
paint metal3
box 81.895um -10.115um 82.105um -9.905um
paint metal3
box 81.920um -10.090um 82.080um -9.930um
paint via3
box 81.895um -10.115um 82.105um -9.905um
paint metal4
box 81.895um -10.115um 82.105um -9.905um
paint metal4
box 81.920um -10.090um 82.080um -9.930um
paint via4
box 81.895um -10.115um 82.105um -9.905um
paint metal5
box 81.900um -10.110um 82.100um 12.600um
paint metal5
box 65.280um -13.380um 65.440um -13.220um
paint metal1
box 65.255um -13.405um 65.465um -13.195um
paint metal1
box 65.280um -13.380um 65.440um -13.220um
paint via1
box 65.255um -13.405um 65.465um -13.195um
paint metal2
box 65.280um -14.080um 65.440um -13.220um
paint metal2
box 65.280um -14.080um 82.080um -13.920um
paint metal2
box 81.895um -14.105um 82.105um -13.895um
paint metal2
box 81.920um -14.080um 82.080um -13.920um
paint via2
box 81.895um -14.105um 82.105um -13.895um
paint metal3
box 81.895um -14.105um 82.105um -13.895um
paint metal3
box 81.920um -14.080um 82.080um -13.920um
paint via3
box 81.895um -14.105um 82.105um -13.895um
paint metal4
box 81.895um -14.105um 82.105um -13.895um
paint metal4
box 81.920um -14.080um 82.080um -13.920um
paint via4
box 81.895um -14.105um 82.105um -13.895um
paint metal5
box 81.900um -19.100um 82.100um -13.900um
paint metal5
box 20.420um 12.420um 20.580um 12.580um
paint metal1
box 20.395um 12.395um 20.605um 12.605um
paint metal1
box 20.420um 12.420um 20.580um 12.580um
paint via1
box 20.395um 12.395um 20.605um 12.605um
paint metal2
box 20.420um 11.720um 20.580um 12.580um
paint metal2
box 20.420um 11.720um 82.080um 11.880um
paint metal2
box 81.895um 11.695um 82.105um 11.905um
paint metal2
box 81.920um 11.720um 82.080um 11.880um
paint via2
box 81.895um 11.695um 82.105um 11.905um
paint metal3
box 81.895um 11.695um 82.105um 11.905um
paint metal3
box 81.920um 11.720um 82.080um 11.880um
paint via3
box 81.895um 11.695um 82.105um 11.905um
paint metal4
box 81.895um 11.695um 82.105um 11.905um
paint metal4
box 81.920um 11.720um 82.080um 11.880um
paint via4
box 81.895um 11.695um 82.105um 11.905um
paint metal5
box 81.900um 11.700um 82.100um 12.600um
paint metal5
box 20.420um -19.080um 20.580um -18.920um
paint metal1
box 20.395um -19.105um 20.605um -18.895um
paint metal1
box 20.420um -19.080um 20.580um -18.920um
paint via1
box 20.395um -19.105um 20.605um -18.895um
paint metal2
box 20.420um -19.780um 20.580um -18.920um
paint metal2
box 20.420um -19.780um 82.080um -19.620um
paint metal2
box 81.895um -19.805um 82.105um -19.595um
paint metal2
box 81.920um -19.780um 82.080um -19.620um
paint via2
box 81.895um -19.805um 82.105um -19.595um
paint metal3
box 81.895um -19.805um 82.105um -19.595um
paint metal3
box 81.920um -19.780um 82.080um -19.620um
paint via3
box 81.895um -19.805um 82.105um -19.595um
paint metal4
box 81.895um -19.805um 82.105um -19.595um
paint metal4
box 81.920um -19.780um 82.080um -19.620um
paint via4
box 81.895um -19.805um 82.105um -19.595um
paint metal5
box 81.900um -19.800um 82.100um -18.900um
paint metal5
save pll_analog
puts DONE
quit -noprompt
