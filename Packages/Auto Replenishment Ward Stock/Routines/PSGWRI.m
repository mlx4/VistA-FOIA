PSGWRI ;BHAM ISC/PTD,CML-Return Items for AOU ; 29 Dec 93 / 9:16 AM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
 I '$D(PSGWSITE) D ^PSGWSET Q:'$D(PSGWSITE)  S PSGWFLG=1
AOU S PSGWV="AMIS COMPILE FLAG",PSGWCAT="R",(PSGWADT,PSGWQD)="",DIC="^PSI(58.1,",DIC(0)="QEAM" D ^DIC K DIC G:Y<0 END S PSGWAOU=+Y
 I '$D(^PSI(58.1,PSGWAOU,1,0)) S ^(0)="^58.11IP^^"
ITEM S DIC="^PSI(58.1,PSGWAOU,1,",DIC(0)="QEAOM" D ^DIC K DIC K:Y<0 PSGWAOU G:Y<0 AOU S PSGWDN=$P(Y,"^",2),PSGWDDA=+Y
 I '$D(^PSI(58.1,PSGWAOU,1,PSGWDDA,3,0)) S ^(0)="^58.15^^"
DATE S DIC="^PSI(58.1,PSGWAOU,1,PSGWDDA,3,",DIC(0)="QEAML" D ^DIC K DIC G:Y<0 END S (DA,PSGWADT)=+Y S PSGWOLD=$P(^PSI(58.1,PSGWAOU,1,PSGWDDA,3,PSGWADT,0),"^",2)
DIE S DA(2)=PSGWAOU,DA(1)=PSGWDDA,DIE="^PSI(58.1,PSGWAOU,1,PSGWDDA,3,",DR="1;S PSGWQD=X-PSGWOLD;2" D ^DIE K DIE G:$D(Y) DONE
 I $D(PSGWADT)&($P(^PSI(58.1,PSGWAOU,0),"^",3)'=1)&($P(PSGWSITE,"^",25)=1)&(PSGWQD'=0) S ^PSI(58.5,"AMIS",$H,PSGWADT,PSGWCAT,PSGWAOU,PSGWDN,PSGWQD)=""
DONE K PSGWDN,PSGWADT,PSGWQD,PSGWOLD,PSGWDDA G ITEM
 ;
END K PSGWADT,PSGWAOU,PSGWDN,PSGWQD,PSGWCAT,PSGWDDA,PSGWOLD,KEY,PSGWV,DA,DR,%,%DT,%W,C,D0,DI,DQ,Y
 K:$D(PSGWFLG) PSGWFLG,PSGWSITE Q
