V4READ ;IW-KO-YS-TS,VV4,MVTS V9.10;15/6/96;PART-94
 ;COPYRIGHT MUMPS SYSTEMS LABORATORY 1994-1996
 ;
 W !!,"Tests of READ command"
 ;
V4READ1 W !!,"93---V4READ1" D ^V4READ1
V4READ2 W !!,"94---V4READ2" D ^V4READ2
V4READ3 W !!,"95---V4READ3" D ^V4READ3
V4READ4 W !!,"96---V4READ4" D ^V4READ4
END Q
 ;
SUM S SUM=0 F I=1:1 S L=$T(+I) Q:L=""  F K=1:1:$L(L) S SUM=SUM+$A(L,K)
 Q
