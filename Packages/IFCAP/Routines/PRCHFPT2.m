PRCHFPT2 ;WISC/RSD/RHD-CONT. OF PRINT ;5/12/99  12:22
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
PG1 S (PRCHJ,PRCH,PRCHPT,PRCHL,N)=0,PRCHP=P,P=1
 ;
PG S (PRCHL,PRCHI)=0 F I=0:0 S PRCHI=$O(^TMP($J,"P",P,PRCHI)) Q:PRCHI=""  D IT:PRCHI=+PRCHI,DIS:PRCHI="D",EST:PRCHI="E",ADC:$E(PRCHI)="F",REQ:PRCHI="X" S PRCHJ=PRCHI I PRCHI="W" S PRCHW="PRCH",PRCHL=PRCHL+1 D WP
 Q:P>1  I (PRCHP-BOCPG)>1 W !?10,"ITEMS CONTINUED ON NEXT PAGE ",! S PRCHL=PRCHL+2
 F Y=1:1:18-PRCHL W !
 W:$X>0 !
 W PRCHULN D AUTH^PRCHFPT3 G:PRCHDES'="R" PGS W "WAREHOUSE CERT. SIGN: "
 I $D(^PRC(442,D0,11,PRCHFPT,0)),$P(^(0),U,8)]"" S X=$P(^(0),U,8),P=$P(^(0),U,7) W "/ES/"_$$DECODE^PRCHES1(D0,PRCHFPT) W ?59,"DATE REC'D: " S Y=$P(^PRC(442,D0,11,PRCHFPT,0),U,1) D DT
 I  W " PARTIAL: ",PRCHFPT,$S($P(^PRC(442,D0,11,PRCHFPT,0),U,9)="F":" FINAL",1:"")
 E  W $E(PRCHULN,1,35),?59,"DATE REC'D: ",$E(PRCHULN,1,25)
 W !!,"SERVICE CERT. SIGN: ",$E(PRCHULN,1,35),?59,"DATE REC'D: ",$E(PRCHULN,1,25)
 ;
PGS W !,"90-2138-7-ADP, JAN 1984" W:PRCHDES="R" ?72,"RECEIVING REPORT COPY" W ! I PRCHP>1 F P=2:1:PRCHP S PRCHPT=0 D PGNX
 ;PRINT MULTIPLE DELIVERY SCHEDULE (IF ANY)
 I PRCHDES'="F" S PRCHQUIT=0,PRCHONL=0 D EN2^PRCHDP4
 ;
Q K DEST,PRCH0,PRCH1,PRCH12,PRCH,PRCHDES,PRCHFTYP,PRCHS,PRCHHSP,PRCHLC,PRCHST,PRCHW,PRCHSIT,PRCHSHP,PRCHINV,PRCHI,PRCHI0,PRCHI2,PRCHDA,PRCHDTA,^PRC(442,D0,15,9999999),D0,DA,DIWF,DIWL,DIWR
 K BOCPG,BOCCT,PZZBOC,FMSLN,LITEM,CHGSHP,N,COUNT,BCT,BOC22,BOC,BOLN
 K PRCHJ,PRCHJD,PRCHK,PRCHC,PRCHV,PRCHL,PRCHLC,PRCHLB,PRCHL1,PRCHLE,PRCHPT,PRCHP,PRCHD,PRCHREPR,PRCHULN,PRCHCNT,PRCHFPT,N,S,P,I,J,K,V,X,Y,Z,^TMP($J,"W"),^("PRCH"),^("P"),^UTILITY($J,"W") D:$D(ZTSK) KILL^%ZTLOAD K ZTSK
 Q
 ;
IT S:PRCHJ=PRCHI PRCHW="W" G:PRCHJ=PRCHI WP S PRCH=PRCHI Q:'$D(^PRC(442,D0,2,PRCH))  S PRCHI0=^(PRCH,0),PRCHI2=$G(^(2)),N=N+1 D ITEM^PRCHFPT3
 Q
 ;
WP F K=+^TMP($J,"P",P,PRCHI):1:$P(^TMP($J,"P",P,PRCHI),U,2) W !?8,$G(^TMP($J,PRCHW,1,K,0)) S PRCHL=PRCHL+1
 S PRCHL=PRCHL+1
 Q
 ;
PGNX I P'>(PRCHP-BOCPG) D TOP,PG,TOT
 I BOCCT>2&(P>(PRCHP-BOCPG)) D BOCTOP,MORBOC^PRCHFPT4
 Q
 ;
TOP W @IOF,!?15,$S(PRCHDES="US":"          USING SERVICE COPY",1:"ORDER FOR SUPPLIES OR SERVICES"),?52,"PAGE NO.",?63,P,"  OF  ",PRCHP,"  PAGES",!?23,"(CONTINUATION)",?52,"DATE: " S Y=$P(PRCH1,U,15) D DT
 W ?70,"PO # ",$P($P(PRCH0,U,1),"-",2),!?5,"ISSUING OFFICE: DEPT. OF VETERANS AFFAIRS",?50,"VENDOR: ",$P(PRCHV,U,1),!,PRCHULN
 W !?59,"UNIT",?69,"TOTAL" W:PRCHDES="R" ?80,"QTY",?90,"AMT" W !,"ITEM",?15,"DESCRIPTION",?46,"QTY",?51,"UNIT",?59,"COST",?69,"COST" W:PRCHDES="R" ?80,"REC",?90,"REC" W !,PRCHULN
 W !!
 Q
 ;
BOCTOP W @IOF,!?15,$S(PRCHDES="US":"          USING SERVICE COPY",1:"ORDER FOR SUPPLIES OR SERVICES"),?52,"PAGE NO.",?63,P,"  OF  ",PRCHP,"  PAGES",!?23,"(CONTINUATION)",?52,"DATE: " S Y=$P(PRCH1,U,15) D DT
 W ?70,"PO # ",$P($P(PRCH0,U,1),"-",2),!?5,"ISSUING OFFICE: DEPT. OF VETERANS AFFAIRS",?50,"VENDOR: ",$P(PRCHV,U,1),!,PRCHULN,!!
 Q
 ;
DIS S PRCHD=^TMP($J,"P",P,"D") F PRCH=+PRCHD:1:$P(PRCHD,U,2) I $D(^PRC(442,D0,3,PRCH)) S PRCHI0=^(PRCH,0),N=N+1,PRCHPT=PRCHPT-$P(PRCHI0,U,3),PRCHL=PRCHL+2 W !?2,$J($P(PRCHI0,U,6),3),?7,"LESS ",$P(PRCHI0,U,2) D DIS1
 Q
 ;
DIS1 W $S($E($P(PRCHI0,U,2),1)="$":"",1:" %")," FOR ",$S($P(PRCHI0,U,1)="Q":"QUANTITY DISCOUNT",1:"ITEMS: "_$P(PRCHI0,U,1)) W ?66,$J($P(PRCHI0,U,3),8,2) W !
 Q
 ;
EST S PRCHD=^TMP($J,"P",P,"E"),N=N+1,PRCHPT=PRCHPT+$P(PRCH0,U,13),PRCHL=PRCHL+2 W !?2,$S($P(PRCH0,U,18)]"":$J($P(PRCH0,U,18),3),1:$J(N,3)),?7,"ESTIMATED SHIPPING AND/OR HANDLING",?66,$J($P(PRCH0,U,13),8,2),!
 W ?8,"BOC: ",+$P($G(^PRC(442,D0,23)),U),?22,"FMS LINE: 991",!
 Q
ADC S PRCH=$P(PRCHI,U,2) Q:'$D(^PRC(442.7,+PRCH,1,0))  S PRCHD=0,DIWR=64,DIWL=1,DIWF="",PRCHW="W" G:PRCHJ=PRCHI WP K ^UTILITY($J,"W")
 F PRCHJJ=0:0 S PRCHD=$O(^PRC(442.7,PRCH,1,PRCHD)) Q:'PRCHD  S X=^(PRCHD,0) D DIWP^PRCUTL($G(DA))
 K ^TMP($J,"W") S %X="^UTILITY($J,""W"",",%Y="^TMP($J,""W""," D %XY^%RCR
 K PRCHJJ
 G WP
 ;
REQ ; Q:$G(PRCHTYPE)'="" ; PRC*5*156 (Show txn# for all PO's)
 S PRCHD=^TMP($J,"P",P,"X")
 W !!,"V.A. TRANSACTION NUMBERS: " S PRCHL=PRCHL+2
 F PRCH=+PRCHD:0 D  Q:'PRCH
 . I $D(^PRC(442,D0,13,PRCH,0))&$D(^PRCS(410,+^(0),0)) D
 . . W !?14,$P(^PRCS(410,+^PRC(442,D0,13,PRCH,0),0),U,1) S PRCHL=PRCHL+1
 . S PRCH=$O(^PRC(442,D0,13,PRCH))
 W ! S PRCHL=PRCHL+1
 Q
 ;
TOT F Y=1:1:47-PRCHL W !
 W !?25,"TOTALS CARRIED FORWARD TO FIRST SHEET: ",?66,$J(PRCHPT,8,2),!!
 W "90-2139-ADP, MAY 1985" W:PRCHDES="R" ?72,"RECEIVING REPORT COPY"
 W !
 Q
 ;
DT W:Y Y\100#100,"/",Y#100\1,"/",Y\10000+1700
 Q