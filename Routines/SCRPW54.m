SCRPW54 ;RENO/KEITH - Means Test Summary of Visits & Uniques (OP3, OP4, OP5) or (IP3, IP4, IP5) ; 5/21/01 3:32pm
 ;;5.3;Scheduling;**144,258,466**;AUG 13, 1993;Build 2
 S SDSTA=$G(SDSTA,2)
 D RQUE^SCRPW50("START^SCRPW54","Means Test Summary of Visits & Uniques "_$S(SDSTA=8:"(IP3, IP4, IP5)",1:"(OP3, OP4, OP5)"),1) Q
 ;
START ;Print report
 K ^TMP("SCRPW",$J) S (SDSTOP,SDOUT,DFN)=0
 F  S DFN=$O(^SCE("ADFN",DFN)) Q:'DFN!SDOUT  S SDT=SD("FYD") F  S SDT=$O(^SCE("ADFN",DFN,SDT)) Q:'SDT!SDOUT!(SDT>SD("EDT"))  S SDOE=0 F  S SDOE=$O(^SCE("ADFN",DFN,SDT,SDOE)) Q:'SDOE!SDOUT  D
 .S SDOE0=$$GETOE^SDOE(SDOE),SDIV=$P(SDOE0,U,11) I $$VALID() D SET(SDIV) D:SDMD SET(0)
 G:SDOUT EXIT S (SDVCT,SDIV)=""
 F  S SDIV=$O(^TMP("SCRPW",$J,SDIV)) Q:SDIV=""  D DLIST,STOP Q:SDOUT  D
 .F SDMT="N","C","G","X","AN","AS" D
 ..S DFN=0 F  S DFN=$O(^TMP("SCRPW",$J,SDIV,SDMT,DFN)) Q:'DFN  D
 ...S SDT=0 F  S SDT=$O(^TMP("SCRPW",$J,SDIV,SDMT,DFN,SDT)) Q:'SDT  S ^TMP("SCRPW",$J,SDIV,0,DFN,SDT)=SDMT
 ...Q
 ..Q
 .S DFN=0 F  S DFN=$O(^TMP("SCRPW",$J,SDIV,0,DFN)) Q:'DFN  S SDFV=1,SDT="" F  S SDT=$O(^TMP("SCRPW",$J,SDIV,0,DFN,SDT),-1) Q:SDT=""  S SDMT=^TMP("SCRPW",$J,SDIV,0,DFN,SDT) D S1(SDMT) S SDFV=0
 .S SDMT=0 F  S SDMT=$O(^TMP("SCRPW",$J,SDIV,SDMT)) Q:SDMT=""  D
 ..I '$G(^TMP("SCRPW",$J,SDIV,SDMT,"TOTAL")) S (^TMP("SCRPW",$J,SDIV,SDMT,"TOTAL"),^TMP("SCRPW",$J,SDIV,SDMT,"AVERAGE AGE"))=0 Q
 ..S ^TMP("SCRPW",$J,SDIV,SDMT,"AVERAGE AGE")=^TMP("SCRPW",$J,SDIV,SDMT,"AVERAGE AGE")\^TMP("SCRPW",$J,SDIV,SDMT,"TOTAL")
 ..Q
 .D AA(SDIV) Q
 G:SDOUT EXIT S SDLINE="",$P(SDLINE,"-",(IOM+1))="" D NOW^%DTC S Y=% X ^DD("DD") S SDPNOW=$P(Y,":",1,2),SDTIT(1)="<*>  MEANS TEST SUMMARY OF VISITS & UNIQUES "_$S(SDSTA=8:"(IP3, IP4, IP5)",1:"(OP3, OP4, OP5)")_"  <*>",SDPG=0
 D:$E(IOST)="C" DISP0^SCRPW23
 I '$D(^TMP("SCRPW",$J)) S SDPAGE=1,SDX="No activity found within report parameters." D HDR G:SDOUT EXIT W !!?(IOM-$L(SDX)\2),SDX G EXIT
 G:SDOUT EXIT S SDIVN="" F  S SDIVN=$O(SDIV(SDIVN)) Q:SDIVN=""!SDOUT  D DPRT(SDIV(SDIVN))
 G:SDOUT EXIT D:SDVCT>1 DPRT(0)
EXIT I $E(IOST)="C",'SDOUT N DIR S DIR(0)="E" D ^DIR
 K ^TMP("SCRPW",$J),%,%H,%I,DFN,DIR,SD,SDAGE,SDDIV,SDFAA,SDFTOT,SDFV,SDH,SDI,SDIV,SDIVN,SDLAB,SDLINE,SDLT,SDMD,SDMO,SDMOTO,SDMT,SDOE,SDOE0,SDSTA
 K SDPAGE,SDOUT,SDPATE,SDPG,SDPNOW,SDPT0,SDR,SDSC,SDSTOP,SDT,SDTIT,SDTOT,SDV,SDVCT,SDX,SDYR,SDYRTO,X,Y Q
 ;
AA(SDIV) ;Average age
 I '$G(SDFTOT(SDIV)) S (SDFAA(SDIV),SDFTOT(SDIV))=0 Q
 S SDFAA(SDIV)=SDFAA(SDIV)\SDFTOT(SDIV) Q
 ;
DPRT(SDV) ;Print division
 ;Required input: SDV=division ifn or '0' for combined divisions
 I SDV S SDTIT(2)="For "_$S(SDDIV["DIVISIONS":"division",1:"facility")_": "_SDIVN
 I 'SDV S SDTIT(2)="Report for: "_$P(SDDIV,U,2) D
 .S SDI=2,SDIVN="" F  S SDIVN=$O(SDIV(SDIVN)) Q:SDIVN=""  S SDI=SDI+1,SDTIT(SDI)=$J("Division: ",$L(SDIVN))_SDIVN
 .Q
 S SDPAGE=1 D HDR,HD1(1) Q:SDOUT  S SDSC=0 D PLINE1(1) Q:SDOUT
 W ! D:$Y>(IOSL-8) HDR Q:SDOUT  D HD1(2) D PLINE1(2) Q:SDOUT
 W ! D:$Y>(IOSL-8) HDR Q:SDOUT  D HD2
 F SDLT="MALE","FEMALE","TOTAL","POW STATUS","AVERAGE AGE","UNDER 24","25 - 34","35 - 44","45 - 54","55 - 64","65 - 74","75 - 84","85 - 94","95 & ABOVE" D PLINE2(SDLT) Q:SDOUT
 Q
 ;
PLINE1(SDH) ;Print output line
 ;Required input: SDH=subheader number
 S (SDMOTO,SDYRTO)=0
 ;D PL("CATEGORY A SERVICE CONNECTED","AS") Q:SDOUT
 D PL("SC - MT COPAY EXEMPT","AS") Q:SDOUT
 ;D PL("CATEGORY A NON-SERVICE CONNECTED","AN") Q:SDOUT
 D PL("NSC - MT COPAY EXEMPT","AN") Q:SDOUT
 ;D PL("TOTAL CATEGORY A MEANS TEST","TA") Q:SDOUT
 D PL("TOTAL MT COPAY EXEMPT","TA") Q:SDOUT
 ;D PL("CATEGORY C","C") Q:SDOUT
 D PL("MT COPAY REQUIRED","C") Q:SDOUT
 D PL("GMT COPAY REQUIRED","G") Q:SDOUT
 D PL("NON VETERAN","N") Q:SDOUT
 D PL("NON APPLICABLE","X") Q:SDOUT
 S SDX="CURRENT MONTH % OF YEAR TO DATE TOTALS: "_$S('SDYRTO:0,1:SDMOTO*100\SDYRTO)_"%" W !!?(132-$L(SDX)\2),SDX
 Q
 ;
PL(SDLAB,SDMT) ;Print line
 I $Y>(IOSL-4) D HDR Q:SDOUT  D HD1(SDH)
 S SDMO=+$G(^TMP("SCRPW",$J,SDV,SDMT,$S(SDH=1:"MOVIS",1:"MOTOT")))
 S SDYR=+$G(^TMP("SCRPW",$J,SDV,SDMT,$S(SDH=1:"VIS",1:"TOTAL")))
 S SDMOTO=SDMOTO+SDMO,SDYRTO=SDYRTO+SDYR
 W !?18,$J(SDLAB_":",33),?54,$J(SDMO,9,0),?69,$J(SDLAB_":",33),?105,$J(SDYR,9,0)
 Q
 ;
PLINE2(SDLT) ;Print output line
 ;Required input: SDLT=output line tag
 I $Y>(IOSL-4) D HDR Q:SDOUT  D HD2
 W !?6,$J(SDLT_":",12) S (SDTOT,SDI)=0 F SDMT="AS","AN","TA","C","G","N","X" S SDX=+$G(^TMP("SCRPW",$J,SDV,SDMT,SDLT)) W ?(20+(12*SDI)),$J(SDX,10,0) S SDI=SDI+1 S:SDI'=3 SDTOT=SDTOT+SDX
 S:SDLT="AVERAGE AGE" SDTOT=SDFAA(SDV) W ?104,$J(SDTOT,10,0) Q
 ;
HDR ;Print header
 I $E(IOST)="C",SDPG N DIR S DIR(0)="E" W ! D ^DIR S SDOUT=Y'=1 Q:SDOUT
 D STOP Q:SDOUT  W:SDPG!($E(IOST)="C") $$XY^SCRPW50(IOF,1,0) W:$X $$XY^SCRPW50("",0,0)
 N SDI S SDI=0 W SDLINE F  S SDI=$O(SDTIT(SDI)) Q:'SDI  W !?(IOM-$L(SDTIT(SDI))\2),SDTIT(SDI)
 W !,SDLINE,!,"For Fiscal Year activity through ",SD("PEDT"),!,"Date printed: ",SDPNOW,?(IOM-6-$L(SDPAGE)),"Page: ",SDPAGE,!,SDLINE S SDPAGE=SDPAGE+1,SDPG=1 Q
 ;
HD1(SDR) ;Print subheader
 Q:SDOUT  S SDX="**** MEANS TEST VISIT SUMMARY"_$S(SDR=2:" (UNIQUE SSNS BASED ON LATEST VISIT)",1:"")_" ****" W !!?(132-$L(SDX)\2),$E(SDLINE,1,$L(SDX)),!?(132-$L(SDX)\2),SDX,!?(132-$L(SDX)\2),$E(SDLINE,1,$L(SDX))
 S SDX="CURRENT MONTH MEANS TEST "_$S(SDR=1:"VISITS",1:"UNIQUES") W !!?18,$J(SDX_":",33),?58,"TOTAL"
 S SDX="YEAR TO DATE MEANS TEST "_$S(SDR=1:"VISITS",1:"UNIQUES") W ?69,$J(SDX_":",33),?109,"TOTAL",!?18,$E(SDLINE,1,45),?69,$E(SDLINE,1,45)
 Q
 ;
HD2 ;Print subheader
 Q:SDOUT  S SDX="**** MEANS TEST UNIQUES BY GENDER, POW STATUS AND AGE ****" W !!?(132-$L(SDX)\2),$E(SDLINE,1,$L(SDX)),!?(132-$L(SDX)\2),SDX,!?(132-$L(SDX)\2),$E(SDLINE,1,$L(SDX))
 W !?24,"SC",?35,"NSC",?45,"TOTAL"
 W !?20,"MT COPAY",?32,"MT COPAY",?44,"MT COPAY",?56,"MT COPAY",?68,"GMT COPAY",?87,"NON",?99,"NOT",?109,"GRAND"
 W !?10,"UNIQUES:",?21,"EXEMPT",?33,"EXEMPT",?45,"EXEMPT",?56,"REQUIRED",?68,"REQUIRED",?83,"VETERAN",?92,"APPLICABLE",?109,"TOTAL"
 W !?6,$E(SDLINE,1,12) F SDI=0:1:7 W ?(20+(12*SDI)),$E(SDLINE,1,10)
 Q
 ;
DLIST ;Create alphabetic list of divisions found
 Q:'SDIV  S SDX=$P($G(^DG(40.8,SDIV,0)),U) S:'$L(SDX) SDX="**** UNKNOWN ****" S SDIV(SDX)=SDIV,SDVCT=SDVCT+1 Q
 ;
VALID() ;Check encounter record
 I $P(SDOE0,U,4),$P($G(^SC($P(SDOE0,U,4),0)),U,17)="Y" Q 0
 I SDIV,$$DIV(),$P(SDOE0,U),$P(SDOE0,U,2),'$P(SDOE0,U,6),$P(SDOE0,U,7),$P(SDOE0,U,12)=SDSTA,$P(SDOE0,U,10),$P(SDOE0,U,13) Q 1
 Q 0
 ;
DIV() ;Check division
 Q:'SDDIV 1  Q $D(SDDIV(SDIV))
 ;
STOP ;Check for stop task request
 S:$D(ZTQUEUED) (SDOUT,ZTSTOP)=$S($$S^%ZTLOAD:1,1:0) Q
 ;
SET(SDIV) ;Set division lists
 ;Required input: SDIV=division ifn or '0' for summary
 S SDSTOP=SDSTOP+1 I SDSTOP#3000=0 D STOP^SCRPW40 Q:SDOUT
 S SDMT=$$MTI^SCDXUTL0(DFN,$P(SDOE0,U),$P(SDOE0,U,13),$P(SDOE0,U,10),SDOE) Q:SDMT="U"  S ^TMP("SCRPW",$J,SDIV,SDMT,DFN,$P(SDT,"."))=""
 Q
 ;
S1(SDMT) S ^TMP("SCRPW",$J,SDIV,SDMT,"VIS")=$G(^TMP("SCRPW",$J,SDIV,SDMT,"VIS"))+1
 S:SDT>SD("MOD") ^TMP("SCRPW",$J,SDIV,SDMT,"MOVIS")=$G(^TMP("SCRPW",$J,SDIV,SDMT,"MOVIS"))+1
 D:(SDMT="AN"!(SDMT="AS")) S1("TA") Q:'SDFV
 S SDPT0=$G(^DPT(DFN,0)) S SDX=$$SEX()_U_"TOTAL"_U_$$AGE()_$$POW()_$$MOT()
 F SDI=1:1:$L(SDX,U) S ^TMP("SCRPW",$J,SDIV,SDMT,$P(SDX,U,SDI))=$G(^TMP("SCRPW",$J,SDIV,SDMT,$P(SDX,U,SDI)))+1
 Q
 ;
MOT() Q $S(SDT>SD("MOD"):"^MOTOT",1:"")
 ;
SEX() Q $S($P(SDPT0,U,2)="M":"MALE",1:"FEMALE")
 ;
POW() Q $S($P($G(^DPT(DFN,.52)),U,5)="Y":"^POW STATUS",1:"")
 ;
AGE() S SDAGE=$P(SDPT0,U,3),SDAGE=$E(SDT,1,3)-$E(SDAGE,1,3)-($E(SDT,4,7)<$E(SDAGE,4,7)),^TMP("SCRPW",$J,SDIV,SDMT,"AVERAGE AGE")=$G(^TMP("SCRPW",$J,SDIV,SDMT,"AVERAGE AGE"))+SDAGE
 I SDMT'="TA" S SDFAA(SDIV)=$G(SDFAA(SDIV))+SDAGE,SDFTOT(SDIV)=$G(SDFTOT(SDIV))+1
 Q $S(SDAGE<25:"UNDER 24",SDAGE<35:"25 - 34",SDAGE<45:"35 - 44",SDAGE<55:"45 - 54",SDAGE<65:"55 - 64",SDAGE<75:"65 - 74",SDAGE<85:"75 - 84",SDAGE<95:"85 - 94",1:"95 & ABOVE")