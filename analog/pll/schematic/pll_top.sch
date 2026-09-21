v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {Charge Pump} 220 -430 0 0 0.8 0.8 {}
T {Phase
Frequency
Detector} -150 -440 0 0 0.8 0.8 {}
T {Low Pass 
Filter} 610 -430 0 0 0.8 0.8 {}
T {Voltage Controlled Oscillator} 960 -430 0 0 0.8 0.8 {}
T {Current Mirror} -240 540 0 0 0.8 0.8 {}
N -130 -10 -130 110 {lab=#net1}
N -130 110 -100 110 {lab=#net1}
N -130 -10 -80 -10 {lab=#net1}
N -130 -80 -130 -10 {lab=#net1}
N -130 -80 -100 -80 {lab=#net1}
N -160 -120 -100 -120 {lab=clk_ref_gate}
N 80 -120 210 -120 {lab=pfd_up}
N 30 -30 80 -30 {lab=pfd_up}
N 80 -120 80 -30 {lab=pfd_up}
N 40 10 80 10 {lab=pfd_down}
N 80 10 80 70 {lab=pfd_down}
N 290 -120 340 -120 {lab=#net2}
N 380 -80 380 -60 {lab=vctrl}
N 380 -30 400 -30 {lab=#net3}
N 400 -30 400 -0 {lab=#net3}
N 380 -0 400 0 {lab=#net3}
N 380 50 400 50 {lab=VGND}
N 400 50 400 80 {lab=VGND}
N 380 80 400 80 {lab=VGND}
N 210 -30 340 -30 {lab=pfd_down}
N 210 -30 210 70 {lab=pfd_down}
N 80 70 210 70 {lab=pfd_down}
N 380 80 380 310 {lab=VGND}
N 130 310 380 310 {lab=VGND}
N 380 -180 380 -150 {lab=#net4}
N 380 0 380 20 {lab=#net3}
N 380 -300 380 -240 {lab=VPWR}
N 380 -80 700 -80 {lab=vctrl}
N 380 -90 380 -80 {lab=vctrl}
N 700 100 790 100 {lab=VGND}
N 700 -60 790 -60 {lab=vctrl}
N 700 -80 700 -60 {lab=vctrl}
N 610 -60 700 -60 {lab=vctrl}
N 610 80 610 100 {lab=VGND}
N 610 -60 610 -40 {lab=vctrl}
N 790 80 790 100 {lab=VGND}
N 700 100 700 310 {lab=VGND}
N 610 100 700 100 {lab=VGND}
N 630 310 700 310 {lab=VGND}
N 1430 90 1430 110 {lab=#net5}
N 1430 60 1450 60 {lab=#net6}
N 1430 0 1430 30 {lab=#net7}
N 1490 -0 1580 -0 {lab=#net7}
N 1430 -30 1430 0 {lab=#net7}
N 1370 -60 1390 -60 {lab=#net8}
N 1370 0 1370 60 {lab=#net8}
N 1370 60 1390 60 {lab=#net8}
N 1280 90 1280 110 {lab=#net9}
N 1280 60 1300 60 {lab=#net10}
N 1280 0 1280 30 {lab=#net8}
N 1280 0 1370 0 {lab=#net8}
N 1220 -60 1240 -60 {lab=#net11}
N 1220 0 1220 60 {lab=#net11}
N 1220 60 1240 60 {lab=#net11}
N 1140 90 1140 110 {lab=#net12}
N 1140 60 1160 60 {lab=#net13}
N 1140 0 1140 30 {lab=#net11}
N 1140 0 1220 0 {lab=#net11}
N 1140 -30 1140 0 {lab=#net11}
N 1070 -0 1070 60 {lab=#net7}
N 1370 -60 1370 0 {lab=#net8}
N 1220 -60 1220 0 {lab=#net11}
N 1640 -80 1640 -60 {lab=out}
N 1640 90 1640 310 {lab=VGND}
N 1640 60 1660 60 {lab=VGND}
N 1660 60 1660 90 {lab=VGND}
N 1640 90 1660 90 {lab=VGND}
N 1650 -60 1650 -30 {lab=out}
N 1640 -60 1650 -60 {lab=out}
N 1640 -30 1650 -30 {lab=out}
N 1640 0 1640 30 {lab=out}
N 1640 0 1860 -0 {lab=out}
N 1640 -30 1640 0 {lab=out}
N 1580 -60 1600 -60 {lab=#net7}
N 1580 -0 1580 60 {lab=#net7}
N 1580 60 1600 60 {lab=#net7}
N 1580 -60 1580 -0 {lab=#net7}
N 1140 -190 1160 -190 {lab=VPWR}
N 1160 -220 1160 -190 {lab=VPWR}
N 1140 -220 1160 -220 {lab=VPWR}
N 1280 -190 1300 -190 {lab=VPWR}
N 1300 -220 1300 -190 {lab=VPWR}
N 1280 -220 1300 -220 {lab=VPWR}
N 1430 -190 1460 -190 {lab=VPWR}
N 1460 -220 1460 -190 {lab=VPWR}
N 1430 -220 1460 -220 {lab=VPWR}
N 1430 -160 1430 -90 {lab=#net14}
N 1360 -190 1390 -190 {lab=#net15}
N 1280 -160 1280 -90 {lab=#net16}
N 1360 -190 1360 -140 {lab=#net15}
N 1220 -140 1360 -140 {lab=#net15}
N 1220 -190 1220 -140 {lab=#net15}
N 1220 -190 1240 -190 {lab=#net15}
N 1140 -160 1140 -90 {lab=#net17}
N 1080 -140 1220 -140 {lab=#net15}
N 1080 -190 1080 -140 {lab=#net15}
N 1080 -190 1100 -190 {lab=#net15}
N 1280 -30 1280 -0 {lab=#net8}
N 1140 -60 1180 -60 {lab=VPWR}
N 1430 -300 1430 -220 {lab=VPWR}
N 1640 -300 1690 -300 {lab=VPWR}
N 1280 -300 1280 -220 {lab=VPWR}
N 1140 -300 1140 -220 {lab=VPWR}
N 1320 -300 1430 -300 {lab=VPWR}
N 1180 -300 1280 -300 {lab=VPWR}
N 1180 -300 1180 -60 {lab=VPWR}
N 1140 -300 1180 -300 {lab=VPWR}
N 1280 -60 1320 -60 {lab=VPWR}
N 1320 -300 1320 -60 {lab=VPWR}
N 1280 -300 1320 -300 {lab=VPWR}
N 1430 -60 1480 -60 {lab=VPWR}
N 1480 -300 1480 -60 {lab=VPWR}
N 1430 -300 1480 -300 {lab=VPWR}
N 1640 -300 1640 -90 {lab=VPWR}
N 1480 -300 1640 -300 {lab=VPWR}
N 1430 310 1640 310 {lab=VGND}
N 1430 170 1430 310 {lab=VGND}
N 1280 310 1430 310 {lab=VGND}
N 1280 170 1280 310 {lab=VGND}
N 1140 310 1280 310 {lab=VGND}
N 1140 170 1140 310 {lab=VGND}
N 950 310 1140 310 {lab=VGND}
N 1370 140 1390 140 {lab=vctrl}
N 1370 140 1370 240 {lab=vctrl}
N 1240 240 1370 240 {lab=vctrl}
N 1100 140 1100 240 {lab=vctrl}
N 1240 140 1240 240 {lab=vctrl}
N 1100 240 1240 240 {lab=vctrl}
N 990 -190 1080 -190 {lab=#net15}
N 920 -190 950 -190 {lab=VPWR}
N 920 -230 920 -190 {lab=VPWR}
N 920 -230 950 -230 {lab=VPWR}
N 950 -230 950 -220 {lab=VPWR}
N 950 -300 950 -230 {lab=VPWR}
N 950 -300 1140 -300 {lab=VPWR}
N 950 -160 950 -30 {lab=#net18}
N 950 -0 980 -0 {lab=VGND}
N 980 -0 980 30 {lab=VGND}
N 950 30 980 30 {lab=VGND}
N 880 -0 910 0 {lab=vctrl}
N 790 -60 790 20 {lab=vctrl}
N 880 -0 880 240 {lab=vctrl}
N 880 240 1100 240 {lab=vctrl}
N 950 30 950 310 {lab=VGND}
N 700 310 950 310 {lab=VGND}
N 1490 -0 1490 200 {lab=#net7}
N 1430 0 1490 -0 {lab=#net7}
N 1040 200 1490 200 {lab=#net7}
N 1040 0 1040 200 {lab=#net7}
N 1040 0 1070 -0 {lab=#net7}
N 1070 -60 1070 -0 {lab=#net7}
N 1070 -60 1100 -60 {lab=#net7}
N 1070 60 1100 60 {lab=#net7}
N 1790 -10 1790 480 {lab=#net19}
N -250 70 -100 70 {lab=#net19}
N -250 70 -250 480 {lab=#net19}
N 380 -300 950 -300 {lab=VPWR}
N 700 -80 810 -80 {lab=vctrl}
N 810 -80 810 -0 {lab=vctrl}
N 810 0 880 -0 {lab=vctrl}
N 380 -210 400 -210 {lab=VPWR}
N 380 -240 400 -240 {lab=VPWR}
N 400 -240 400 -210 {lab=VPWR}
N 160 680 160 710 {lab=vbn}
N 200 740 290 740 {lab=vbn}
N 160 770 160 810 {lab=VGND}
N 320 810 630 810 {lab=VGND}
N 630 310 630 810 {lab=VGND}
N 380 310 630 310 {lab=VGND}
N 320 -210 340 -210 {lab=vbp}
N 320 -210 320 710 {lab=vbp}
N 290 50 340 50 {lab=vbn}
N 290 50 290 740 {lab=vbn}
N 340 710 380 710 {lab=vbp}
N 340 680 340 710 {lab=vbp}
N 380 620 380 650 {lab=VPWR}
N 160 620 380 620 {lab=VPWR}
N 380 650 400 650 {lab=VPWR}
N 400 650 400 680 {lab=VPWR}
N 380 680 400 680 {lab=VPWR}
N 320 770 320 810 {lab=VGND}
N 160 810 320 810 {lab=VGND}
N 150 740 160 740 {lab=VGND}
N 150 740 150 770 {lab=VGND}
N 150 770 160 770 {lab=VGND}
N 320 740 330 740 {lab=VGND}
N 330 740 330 770 {lab=VGND}
N 320 770 330 770 {lab=VGND}
N 200 710 200 740 {lab=vbn}
N 160 710 200 710 {lab=vbn}
N 160 -300 380 -300 {lab=VPWR}
N 160 -300 160 620 {lab=VPWR}
N 380 -120 410 -120 {lab=#net4}
N 410 -150 410 -120 {lab=#net4}
N 380 -150 410 -150 {lab=#net4}
N 320 710 340 710 {lab=vbp}
C {sg13g2_dfrbpq_1.sym} -10 -100 0 0 {name=x1 VDD=VPWR VSS=VDD prefix=sg13g2_ }
C {sg13g2_dfrbpq_1.sym} -10 90 0 0 {name=x2 VDD=VPWR VSS=VGND prefix=sg13g2_ }
C {sg13g2_and2_1.sym} -20 -10 2 0 {name=x3 VDD=VPWR VSS=VGND prefix=sg13g2_ }
C {ipin.sym} -160 -120 0 0 {name=clk_pin0 lab=clk_ref_gate}
C {ipin.sym} -260 70 0 0 {name=clk_pin1 lab=vco_out_div}
C {sg13g2_inv_1.sym} 250 -120 0 0 {name=x4 VDD=VDD VSS=VSS prefix=sg13g2_}
C {sg13g2_pr/sg13_lv_pmos.sym} 360 -210 0 0 {name=M1
l=1.0u
w=1.0u
ng=1
m=1
mm_ok=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 360 -30 0 0 {name=M2
l=0.13u
w=0.5u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 360 -120 0 0 {name=M3
l=0.13u
w=0.5u
ng=1
m=1
mm_ok=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 360 50 0 0 {name=M4
l=1.0u
w=0.5u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {iopin.sym} 130 310 2 0 {name=p4 lab=VGND}
C {sg13g2_pr/cap_cmim.sym} 610 50 0 0 {name=C1
model=cap_cmim
 w=7.0e-6
 l=7.0e-6
 m=1
  mm_ok=1
 spiceprefix=X}
C {sg13g2_pr/rppd.sym} 610 -10 0 0 {name=R1
w=0.5e-6
l=0.5e-6
model=rppd
body=sub!
spiceprefix=X
b=0
 m=1
  mm_ok=1
value="expr_eng(  ( 70.0e-6 / @w + 260.0 * ( (@b + 1)* @l + ( 1.081*( @w + 6.0e-9 ) + 0.18e-6 )*@b ) / ( @w + 6.0e-9 ) ) / @m  )"
}
C {sg13g2_pr/cap_cmim.sym} 790 50 0 0 {name=C2
model=cap_cmim
 w=7.0e-6
 l=7.0e-6
 m=1
  mm_ok=1
 spiceprefix=X}
C {sg13g2_pr/sg13_lv_pmos.sym} 1410 -60 0 0 {name=Mp2
l=1.97u
w=1.12u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 1410 60 0 0 {name=Mn2
l=1.97u
w=0.74u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {opin.sym} 1860 0 0 0 {name=p5 lab=out}
C {iopin.sym} 1690 -300 0 0 {name=p6 lab=VPWR}
C {sg13g2_pr/sg13_lv_pmos.sym} 1260 -60 0 0 {name=Mp1
l=1.97u
w=1.12u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 1260 60 0 0 {name=Mn1
l=1.97u
w=0.74u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 1120 -60 0 0 {name=Mp3
l=1.97u
w=1.12u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 1120 60 0 0 {name=Mn3
l=1.97u
w=0.74u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 1620 -60 0 0 {name=Mp4
l=1.97u
w=1.12u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 1620 60 0 0 {name=Mn4
l=1.97u
w=0.74u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 1410 -190 0 0 {name=Mp5
l=1.97u
w=1.12u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 1260 -190 0 0 {name=Mp6
l=1.97u
w=1.12u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 1120 -190 0 0 {name=Mp7
l=1.97u
w=1.12u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 1260 140 0 0 {name=Mn5
l=1.97u
w=0.74u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 1410 140 0 0 {name=Mn6
l=1.97u
w=0.74u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 1120 140 0 0 {name=Mn7
l=1.97u
w=0.74u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 970 -190 0 1 {name=Mp8
l=1.97u
w=1.12u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 930 0 0 0 {name=Mn8
l=1.97u
w=0.74u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 840 0 1 0 {name=p1 sig_type=std_logic lab=vctrl}
C {lab_pin.sym} 120 -120 1 0 {name=p2 sig_type=std_logic lab=pfd_up}
C {lab_pin.sym} 120 70 1 0 {name=p3 sig_type=std_logic lab=pfd_down}
C {sg13g2_pr/sg13_lv_nmos.sym} 300 740 0 0 {name=M5
l=1.0u
w=0.5u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 180 740 0 1 {name=M6
l=1.0u
w=0.5u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 360 680 0 0 {name=M7
l=1.0u
w=1.0u
ng=1
m=1
mm_ok=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/rhigh.sym} 160 650 0 0 {name=R2
w=0.50e-6
l=260.0e-6
model=rhigh
body=VGND
spiceprefix=X
b=0
m=1
mm_ok=1
}
C {lab_pin.sym} 250 740 0 0 {name=p7 sig_type=std_logic lab=vbn}
C {lab_pin.sym} 320 600 2 0 {name=p8 sig_type=std_logic lab=vbp}
