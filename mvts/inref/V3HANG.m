V3HANG ;IW-KO-TS,VV3,MVTS V9.10;15/6/96;HANG COMMAND  SUB DRIVER
 ;COPYRIGHT MUMPS SYSTEMS LABORATORY 1978-1996
V3HANG1 W !!,"23---V3HANG1" D ^V3HANG1
V3HANG2 W !!,"24---V3HANG2" D ^V3HANG2
END Q
SUM S SUM=0 F I=1:1 S L=$T(+I) Q:L=""  F K=1:1:$L(L) S SUM=SUM+$A(L,K)
 Q
