v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 340 -130 400 -130 {lab=VPWR}
N 220 30 340 30 {lab=VGND}
N 100 -130 100 -110 {lab=VPWR}
N 100 -80 120 -80 {lab=#net1}
N 100 10 100 30 {lab=VGND}
N 100 -20 120 -20 {lab=n1}
N 60 -80 60 50 {lab=out}
N 120 -50 180 -50 {lab=n1}
N 180 -50 180 -20 {lab=n1}
N 220 -130 220 -110 {lab=VPWR}
N 220 -80 240 -80 {lab=#net2}
N 220 10 220 30 {lab=VGND}
N 250 -50 300 -50 {lab=n2}
N 300 -50 300 -20 {lab=n2}
N 340 -130 340 -110 {lab=VPWR}
N 340 -80 360 -80 {lab=#net3}
N 340 10 340 30 {lab=VGND}
N 340 -20 360 -20 {lab=out}
N 360 -50 370 -50 {lab=out}
N 370 -50 370 50 {lab=out}
N 60 50 370 50 {lab=out}
N 80 -130 100 -130 {lab=VPWR}
N 80 30 100 30 {lab=VGND}
N 180 -80 180 -50 {lab=n1}
N 100 -130 220 -130 {lab=VPWR}
N 100 30 220 30 {lab=VGND}
N 300 -80 300 -50 {lab=n2}
N 220 -130 340 -130 {lab=VPWR}
N 120 -50 120 -20 {lab=n1}
N 100 -50 120 -50 {lab=n1}
N 220 -20 250 -20 {lab=n2}
N 250 -50 250 -20 {lab=n2}
N 220 -50 250 -50 {lab=n2}
N 360 -50 360 -20 {lab=out}
N 340 -50 360 -50 {lab=out}
C {sg13g2_pr/sg13_lv_pmos.sym} 80 -80 0 0 {name=Mp0
l=0.81u
w=1.12u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 80 -20 0 0 {name=Mn0
l=0.81u
w=0.74u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 200 -80 0 0 {name=Mp1
l=0.81u
w=1.12u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 200 -20 0 0 {name=Mn1
l=0.81u
w=0.74u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 320 -80 0 0 {name=Mp2
l=0.81u
w=1.12u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 320 -20 0 0 {name=Mn2
l=0.81u
w=0.74u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_wire.sym} 140 -50 0 0 {name=l1 lab=n1}
C {lab_wire.sym} 260 -50 0 0 {name=l2 lab=n2}
C {lab_wire.sym} 355 -50 0 0 {name=l3 lab=out}
C {opin.sym} 370 -50 0 0 {name=p1 lab=out}
C {iopin.sym} 400 -130 0 0 {name=p2 lab=VPWR}
C {iopin.sym} 80 30 2 0 {name=p3 lab=VGND}
C {code_shown.sym} 430 -80 0 0 {name=SPICE 

value=".param pre_layout=1
.lib /foss/pdks/ihp-sg13g2/libs.tech/ngspice/models/cornerMOSlv.lib mos_tt
vvdd VPWR 0 dc 1.2
vvss VGND 0 0
.control
  tran 10p 5n uic
  wrdata /tmp/ring.dat v(out) v(n1) v(n2)
  write /tmp/ring.raw v(out) v(n1) v(n2)
.endc
.ic v(n1)=1.2 v(out)=0 v(n2)=0
"}
