v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 340 -130 480 -130 {lab=VPWR}
N 220 30 340 30 {lab=VGND}
N 100 -130 100 -110 {lab=VPWR}
N 100 -80 120 -80 {lab=VPWR}
N 100 10 100 30 {lab=VGND}
N 100 -20 120 -20 {lab=VGND}
N 60 -80 60 50 {lab=out}
N 180 -50 180 -20 {lab=n1}
N 220 -130 220 -110 {lab=VPWR}
N 220 -80 240 -80 {lab=VPWR}
N 220 10 220 30 {lab=VGND}
N 300 -50 300 -20 {lab=n2}
N 340 -130 340 -110 {lab=VPWR}
N 340 -80 360 -80 {lab=VPWR}
N 340 10 340 30 {lab=VGND}
N 340 -20 360 -20 {lab=VGND}
N 60 50 660 50 {lab=out}
N 80 -130 100 -130 {lab=VPWR}
N 80 30 100 30 {lab=VGND}
N 180 -80 180 -50 {lab=n1}
N 100 -130 220 -130 {lab=VPWR}
N 100 30 220 30 {lab=VGND}
N 300 -80 300 -50 {lab=n2}
N 220 -130 340 -130 {lab=VPWR}
N 100 -50 180 -50 {lab=n1}
N 220 -20 250 -20 {lab=VGND}
N 220 -50 300 -50 {lab=n2}
N 250 -20 250 10 {lab=VGND}
N 220 10 250 10 {lab=VGND}
N 120 -20 120 10 {lab=VGND}
N 100 10 120 10 {lab=VGND}
N 360 -20 360 10 {lab=VGND}
N 340 10 360 10 {lab=VGND}
N 360 -110 360 -80 {lab=VPWR}
N 340 -110 360 -110 {lab=VPWR}
N 240 -110 240 -80 {lab=VPWR}
N 220 -110 240 -110 {lab=VPWR}
N 120 -110 120 -80 {lab=VPWR}
N 100 -110 120 -110 {lab=VPWR}
N 440 -50 440 -20 {lab=n3}
N 480 -130 480 -110 {lab=VPWR}
N 480 -80 500 -80 {lab=VPWR}
N 480 10 480 30 {lab=VGND}
N 480 -20 500 -20 {lab=VGND}
N 440 -80 440 -50 {lab=n3}
N 480 -50 560 -50 {lab=n4}
N 500 -20 500 10 {lab=VGND}
N 480 10 500 10 {lab=VGND}
N 500 -110 500 -80 {lab=VPWR}
N 480 -110 500 -110 {lab=VPWR}
N 340 -50 440 -50 {lab=n3}
N 600 -130 710 -130 {lab=VPWR}
N 560 -50 560 -20 {lab=n4}
N 600 -130 600 -110 {lab=VPWR}
N 600 -80 620 -80 {lab=VPWR}
N 600 10 600 30 {lab=VGND}
N 600 -20 620 -20 {lab=VGND}
N 560 -80 560 -50 {lab=n4}
N 660 -50 700 -50 {lab=out}
N 620 -20 620 10 {lab=VGND}
N 600 10 620 10 {lab=VGND}
N 620 -110 620 -80 {lab=VPWR}
N 600 -110 620 -110 {lab=VPWR}
N 480 -130 600 -130 {lab=VPWR}
N 480 30 600 30 {lab=VGND}
N 340 30 480 30 {lab=VGND}
N 660 -50 660 50 {lab=out}
N 600 -50 660 -50 {lab=out}
C {sg13g2_pr/sg13_lv_pmos.sym} 80 -80 0 0 {name=Mp0
l=0.555u
w=1.12u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 80 -20 0 0 {name=Mn0
l=0.555u
w=0.74u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 200 -80 0 0 {name=Mp1
l=0.555u
w=1.12u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 200 -20 0 0 {name=Mn1
l=0.555u
w=0.74u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 320 -80 0 0 {name=Mp2
l=0.555u
w=1.12u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 320 -20 0 0 {name=Mn2
l=0.555u
w=0.74u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_wire.sym} 140 -50 0 0 {name=l1 lab=n1}
C {lab_wire.sym} 260 -50 0 0 {name=l2 lab=n2}
C {lab_wire.sym} 355 -50 0 0 {name=l3 lab=n3}
C {iopin.sym} 710 -130 0 0 {name=p2 lab=VPWR}
C {iopin.sym} 80 30 2 0 {name=p3 lab=VGND}
C {code_shown.sym} 0 190 0 0 {name=SPICE 

value=".param pre_layout=1
.lib /foss/pdks/ihp-sg13g2/libs.tech/ngspice/models/cornerMOSlv.lib mos_tt
vvdd VPWR 0 dc 1.2
vvss VGND 0 0
.control
  tran 10p 50n uic
  wrdata /tmp/ring.dat v(out) v(n1) v(n2)
  write /tmp/ring.raw v(out) v(n1) v(n2)
.endc
.ic v(n1)=1.2 v(out)=0 v(n2)=0 v(n3)=0 v(n4)=0
"}
C {opin.sym} 700 -50 0 0 {name=p1 lab=out}
C {sg13g2_pr/sg13_lv_pmos.sym} 460 -80 0 0 {name=Mp3
l=0.555u
w=1.12u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 460 -20 0 0 {name=Mn3
l=0.555u
w=0.74u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_wire.sym} 495 -50 0 0 {name=l4 lab=n4}
C {sg13g2_pr/sg13_lv_pmos.sym} 580 -80 0 0 {name=Mp4
l=0.555u
w=1.12u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 580 -20 0 0 {name=Mn4
l=0.555u
w=0.74u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_wire.sym} 615 -50 0 0 {name=l5 lab=out}
