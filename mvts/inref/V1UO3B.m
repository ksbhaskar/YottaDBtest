V1UO3B ;IW-YS-TS,V1UO,MVTS V9.10;15/6/96;UNARY OPERATOR -8-
 ;COPYRIGHT MUMPS SYSTEMS LABORATORY 1978-1996
 W !!,"28---V1UO3B: Unary operator -8-",!
8003 W !,"I-800.3  Not unary operator and a strlit"
80031 S ^ABSN="10302",^ITEM="I-800.3.1  '""+0""",^NEXT="80032^V1UO3B,V1UO3C^V1UO,V1BOA^VV1" D ^V1PRESET
 S ^VCOMP='"+0",^VCORR="1" D ^VEXAMINE
80032 S ^ABSN="10303",^ITEM="I-800.3.2  '""+1""",^NEXT="80033^V1UO3B,V1UO3C^V1UO,V1BOA^VV1" D ^V1PRESET
 S ^VCOMP='"+1",^VCORR="0" D ^VEXAMINE
80033 S ^ABSN="10304",^ITEM="I-800.3.3  'intlit",^NEXT="80034^V1UO3B,V1UO3C^V1UO,V1BOA^VV1" D ^V1PRESET
 S ^VCOMP='"'2BCDEAS43",^VCORR="1" D ^VEXAMINE
80034 S ^ABSN="10305",^ITEM="I-800.3.4  '.intlit",^NEXT="80035^V1UO3B,V1UO3C^V1UO,V1BOA^VV1" D ^V1PRESET
 S ^VCOMP='"-.2-3",^VCORR="0" D ^VEXAMINE
80035 S ^ABSN="10306",^ITEM="I-800.3.5  'intlit.intlit",^NEXT="80036^V1UO3B,V1UO3C^V1UO,V1BOA^VV1" D ^V1PRESET
 S ^VCOMP='"+2.2E-E99",^VCORR="0" D ^VEXAMINE
80036 S ^ABSN="10307",^ITEM="I-800.3.6  'mantEintlit",^NEXT="80037^V1UO3B,V1UO3C^V1UO,V1BOA^VV1" D ^V1PRESET
 S ^VCOMP='"+2.2E2+2",^VCORR="0" D ^VEXAMINE
80037 S ^ABSN="10308",^ITEM="I-800.3.7  'mantE+intlit",^NEXT="80038^V1UO3B,V1UO3C^V1UO,V1BOA^VV1" D ^V1PRESET
 S ^VCOMP='"+2.2E+2-7",^VCORR="0" D ^VEXAMINE
80038 S ^ABSN="10309",^ITEM="I-800.3.8  'mantE-intlit",^NEXT="80039^V1UO3B,V1UO3C^V1UO,V1BOA^VV1" D ^V1PRESET
 S ^VCOMP='"-2.2E-2.4",^VCORR="0" D ^VEXAMINE
80039 S ^ABSN="10310",^ITEM="I-800.3.9  '""-AB2""",^NEXT="800310^V1UO3B,V1UO3C^V1UO,V1BOA^VV1" D ^V1PRESET
 S ^VCOMP='"-AB2",^VCORR="1" D ^VEXAMINE
800310 S ^ABSN="10311",^ITEM="I-800.3.10  '""-2A2B""",^NEXT="8004^V1UO3B,V1UO3C^V1UO,V1BOA^VV1" D ^V1PRESET
 S ^VCOMP='"-2A2B",^VCORR="0" D ^VEXAMINE
 ;
8004 W !,"I-800.4  Not unary operator and a lvn"
80041 S ^ABSN="10312",^ITEM="I-800.4.1  '0",^NEXT="80042^V1UO3B,V1UO3C^V1UO,V1BOA^VV1" D ^V1PRESET
 S A=0 S ^VCOMP='A S ^VCORR="1" D ^VEXAMINE
80042 S ^ABSN="10313",^ITEM="I-800.4.2  '1",^NEXT="80043^V1UO3B,V1UO3C^V1UO,V1BOA^VV1" D ^V1PRESET
 S A=1 S ^VCOMP='A S ^VCORR="0" D ^VEXAMINE
80043 S ^ABSN="10314",^ITEM="I-800.4.3  'intlit",^NEXT="80044^V1UO3B,V1UO3C^V1UO,V1BOA^VV1" D ^V1PRESET
 S A=2 S ^VCOMP='A S ^VCORR="0" D ^VEXAMINE
80044 S ^ABSN="10315",^ITEM="I-800.4.4  '.intlit",^NEXT="80045^V1UO3B,V1UO3C^V1UO,V1BOA^VV1" D ^V1PRESET
 S A=.2 S ^VCOMP='A S ^VCORR="0" D ^VEXAMINE
80045 S ^ABSN="10316",^ITEM="I-800.4.5  'intlit.intlit",^NEXT="80046^V1UO3B,V1UO3C^V1UO,V1BOA^VV1" D ^V1PRESET
 S A=2.2 S ^VCOMP='A S ^VCORR="0" D ^VEXAMINE
80046 S ^ABSN="10317",^ITEM="I-800.4.6  'mantEintlit",^NEXT="80047^V1UO3B,V1UO3C^V1UO,V1BOA^VV1" D ^V1PRESET
 S A=2.2E2 S ^VCOMP='A S ^VCORR="0" D ^VEXAMINE
80047 S ^ABSN="10318",^ITEM="I-800.4.7  'mantE+intlit",^NEXT="80048^V1UO3B,V1UO3C^V1UO,V1BOA^VV1" D ^V1PRESET
 S A=2.2E+2 S ^VCOMP='A S ^VCORR="0" D ^VEXAMINE
80048 S ^ABSN="10319",^ITEM="I-800.4.8  'mantE-intlit",^NEXT="V1UO3C^V1UO,V1BOA^VV1" D ^V1PRESET
 S A=2.2E-2 S ^VCOMP='A S ^VCORR="0" D ^VEXAMINE
 ;
END W !!,"End of 28---V1UO3B",!
 K  Q
SUM S SUM=0 F I=1:1 S L=$T(+I) Q:L=""  F K=1:1:$L(L) S SUM=SUM+$A(L,K)
 Q
