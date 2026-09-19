v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 0 -30 20 -30 {lab=#net1}
N 100 -30 120 -30 {lab=#net2}
N 200 -30 200 40 {lab=out}
N -80 -30 -80 40 {lab=out}
N -80 40 200 40 {lab=out}
N 200 -30 210 -30 {lab=out}
C {sg13g2_inv_1.sym} -40 -30 0 0 {name=x32 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_inv_1.sym} 60 -30 0 0 {name=x1 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_inv_1.sym} 160 -30 0 0 {name=x2 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {opin.sym} 210 -30 0 0 {name=p1 lab=out}
C {code_shown.sym} 290 -20 0 0 {name=SPICE 

value=".param pre_layout=1
.lib /foss/pdks/ihp-sg13g2/libs.tech/ngspice/models/cornerMOSlv.lib mos_tt
vvdd VDD 0 dc 1.2
vvss VSS 0 0
.control
  tran 10p 5n uic
  wrdata /tmp/ring.dat v(out) v(net1) v(net2)
  write /tmp/ring.raw v(out) v(net1) v(net2)
.endc
.ic v(net1)=1.2 v(out)=0 v(net2)=0
"}
