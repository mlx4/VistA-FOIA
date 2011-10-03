OCXSEND2 ;SLC/RJS,CLA - BUILD RULE TRANSPORTER ROUTINES (File Data) ;3/21/00  07:48
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32,74,105**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
S ;
 ;
 ;
 N FILE,REC,DD,RECNAME,FNAME
 ;
 S FILE=0 F  S FILE=$O(^OCXS(FILE)) Q:'FILE  D
 .S ^TMP("OCXSEND",$J,"DATA",$$NEXT)="ROOT^OCXS("_(+FILE)_",0)^"_$P(^OCXS(FILE,0),U,1,2)
 S FILE=0 F  S FILE=$O(^OCXD(FILE)) Q:'FILE  D
 .S ^TMP("OCXSEND",$J,"DATA",$$NEXT)="ROOT^OCXD("_(+FILE)_",0)^"_$P(^OCXD(FILE,0),U,1,2)
 ;
 F FILE=38,41,40,37,39,36,35,34,32,31,33,30,9,8,6,5,4,3,2 D
 .S FILE=FILE/10+860
 .S FNAME=$P(^OCXS(FILE,0),U,1) Q:'$L(FNAME)
 .Q:'($O(^TMP("OCXSEND",$J,"LIST",FILE,0)))
 .S ^TMP("OCXSEND",$J,"DATA",$$NEXT)="SOF^"_(+$P(^OCXS(FILE,0),U,2))_"  "_$P(^OCXS(FILE,0),U,1)
 .W !!,"File: ",+FILE," ",FNAME
 .S RECNAME="" F  S RECNAME=$O(^TMP("OCXSEND",$J,"LIST",FILE,"B",RECNAME)) Q:'$L(RECNAME)  D
 ..S REC=0 F  S REC=$O(^TMP("OCXSEND",$J,"LIST",FILE,"B",RECNAME,REC)) Q:'REC  D
 ...N REM,ARRAY,DD
 ...S:(FNAME["ORDER CHECK ") FNAME=$P(FNAME,"ORDER CHECK ",2)
 ...S:(FNAME["OCX MDD ") FNAME=$P(FNAME,"OCX MDD ",2)
 ...W !,FILE,"  ",FNAME,": ",$J(REC,3)," ",$P(^OCXS(FILE,REC,0),U,1),"  "
 ...I (FILE=2),$G(^OCXS(860.2,REC,"INACT")) W !,?10,"*** Inactive rule skipped. ***" Q
 ...D GETREC("^OCXS("_FILE_",","REM(",REC,.REM)
 ...S DD=$O(REM(0))
 ...S ^TMP("OCXSEND",$J,"DATA",$$NEXT)="KEY"_U_DD_U_REM(DD,.01,"E")
 ...S ARRAY="REM(0)" F  S ARRAY=$Q(@ARRAY) Q:'$L(ARRAY)  Q:'($E(ARRAY,1,4)="REM(")  I $L(@ARRAY) D
 ....S ^TMP("OCXSEND",$J,"DATA",$$NEXT)="R"_U_$P($P(ARRAY,"(",2),")",1)
 ....S ^TMP("OCXSEND",$J,"DATA",$$NEXT)="D"_U_(@ARRAY)
 ...S ^TMP("OCXSEND",$J,"DATA",$$NEXT)="EOR^"
 .S ^TMP("OCXSEND",$J,"DATA",$$NEXT)="EOF^OCXS("_FILE_")^1"
 ;
 Q
 ;
NEXT() Q $O(^TMP("OCXSEND",$J,"DATA",""),-1)+1
 ;
GETREC(GL,PATH,D0,REM) ;
 ;
 Q:'($P($G(@(GL_"0)")),U,2))
 N S1,DATA,DD
 S DATA="" D DIQ(GL,D0,.DATA)
 S DD=$O(DATA(0)) Q:'DD  Q:$$WPFLD(DD)
 ;
 I $L($$FILE^OCXSENDD(DD,"NAME")) S PATH=PATH_""""_DD_":""" I 1
 E  I (DD["860.41") S PATH=PATH_","""_DD_":"_$G(DATA(DD,D0,.01,"E"))_U_"860.6"""
 E  S PATH=PATH_","""_DD_":"_D0_""""
 M @(PATH_")")=DATA(DD,D0)
 ;
 S S1="" F  S S1=$O(@(GL_D0_","_$$SUB(S1)_")")) Q:'$L(S1)  I ($D(@(GL_D0_","_$$SUB(S1)_")"))>3) D
 .N D1,GLREF S GLREF=GL_D0_","_$$SUB(S1)_","
 .S D1=0 F  S D1=$O(@(GLREF_D1_")")) Q:'D1  D GETREC(GLREF,PATH,D1,.REM)
 ;
 Q
 ;
SUB(X) Q:'(X=+X) """"_X_"""" Q X
 ;
DIQ(DIC,DA,OCXARY) ;
 N DR,DIQ,DD,D0,FLD
 S DR=".01:99999",DIQ="OCXARY(",DIQ(0)="IEN" D EN^DIQ1
 ;
 S DD=0 F  S DD=$O(OCXARY(DD)) Q:'DD  D
 .S D0=0 F  S D0=$O(OCXARY(DD,D0)) Q:'D0  D
 ..S FLD=0 F  S FLD=$O(OCXARY(DD,D0,FLD)) Q:'FLD  D
 ...I $L($$FIELD^OCXSENDD(DD,FLD,"POINTER")),$L($G(OCXARY(DD,D0,FLD,"E"))),$L($G(OCXARY(DD,D0,FLD,"I"))),(OCXARY(DD,D0,FLD,"E")=OCXARY(DD,D0,FLD,"I")) D  Q
 ....N OCXPNTR
 ....S OCXPNTR=$$FIELD^OCXSENDD(DD,FLD,"POINTER")
 ....I $L(OCXPNTR) S OCXPNTR="^"_OCXPNTR_"0)"
 ....I $D(@OCXPNTR) S OCXPNTR=$P(@OCXPNTR,"^",1)
 ....W !!,"Broken pointer '",OCXARY(DD,D0,FLD,"E"),"'"
 ....W " (",$$FIELD^OCXSENDD(DD,FLD,"LABEL"),") to"
 ....W " '",OCXPNTR,"' file (",DD,",",D0,",",FLD,")"
 ....W !,"  Not included."
 ....I (FLD=.01) K OCXARY(DD,D0)
 ....E  K OCXARY(DD,D0,FLD)
 ...K OCXARY(DD,D0,FLD,"I")
 ...K:'$L($G(OCXARY(DD,D0,FLD,"E"))) OCXARY(DD,D0,FLD,"E")
 ...K:$$EXFLD(DD,FLD) OCXARY(DD,D0,FLD)
 ..;
 ..I ($$FIELD^OCXSENDD(DD,.01,"LABEL")["PARAMETER"),($G(OCXARY(DD,D0,.01,"E"))="DATA TYPE"),$G(OCXARY(DD,D0,1,"E")) D
 ...I $D(^OCXS(864.1,+OCXARY(DD,D0,1,"E"),0)) S OCXARY(DD,D0,1,"E")=$P(^OCXS(864.1,+OCXARY(DD,D0,1,"E"),0),U,1)
 ..;
 ..I ($$FIELD^OCXSENDD(DD,.01,"LABEL")["PARAMETER"),($G(OCXARY(DD,D0,.01,"E"))="OCXO GENERATE CODE FUNCTION"),$G(OCXARY(DD,D0,1,"E")) D
 ...I $D(^OCXS(863.7,+OCXARY(DD,D0,1,"E"),0)) S OCXARY(DD,D0,1,"E")=$P(^OCXS(863.7,+OCXARY(DD,D0,1,"E"),0),U,1)
 ..;
 ;
 Q
EXFLD(FILE,OCXFLD) ;
 ;
 N OCXFNAM
 S OCXFNAM=$$FIELD^OCXSENDD(FILE,OCXFLD,"LABEL")
 I (OCXFNAM["UNIQUE OBJECT IDENTIFIER") Q 1
 I ($E(OCXFNAM,1)="*") Q 1
 I (FILE=860.2),(OCXFLD=.02) Q 1
 I (FILE=860.22),(OCXFLD=4) Q 1
 I (FILE=860.3),(OCXFLD=3) Q 1
 I (FILE=860.9),(OCXFLD=1) Q 1
 I (FILE=860.91) Q 1
 Q 0
 ;
WPFLD(X) Q:(X=860.801) 1 Q:(X=860.81) 1 Q:(X=861.01) 1 Q:(X=863.02) 1 Q:(X=863.54) 1
 Q:(X=863.61) 1 Q:(X=863.72) 1 Q:(X=863.81) 1
 Q 0
 ;