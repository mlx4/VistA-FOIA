IBJYL2 ; List Template Exporter ; 04-JAN-1996
 ;;Version 2.0 ; INTEGRATED BILLING ;**39**; 21-MAR-94
 I VALM>0 D
 .S ^SD(409.61,VALM,0)="IBJT BILL PROCEDURES^1^^80^5^17^1^1^Bill Procedures^IBJT BILL PROCEDURES MENU^Bill Procedures^1^^1"
 .S ^SD(409.61,VALM,1)="^VALM HIDDEN ACTIONS"
 .S ^SD(409.61,VALM,"ARRAY")=" ^TMP(""IBJTBC"",$J)"
 .S ^SD(409.61,VALM,"FNL")="D EXIT^IBJTBC"
 .S ^SD(409.61,VALM,"HDR")="D HDR^IBJTBC"
 .S ^SD(409.61,VALM,"HLP")="D HELP^IBJTBC"
 .S ^SD(409.61,VALM,"INIT")="D INIT^IBJTBC"
 .S DA=VALM,DIK="^SD(409.61," D IX1^DIK K DA,DIK
 .W "Filed."
 ;
 W !,"'IBJT CLAIM INFO' List Template..."
 S DA=$O(^SD(409.61,"B","IBJT CLAIM INFO",0)),DIK="^SD(409.61," D ^DIK:DA
 K DO,DD S DIC(0)="L",DIC="^SD(409.61,",X="IBJT CLAIM INFO" D FILE^DICN S VALM=+Y
 I VALM>0 D
 .S ^SD(409.61,VALM,0)="IBJT CLAIM INFO^1^^80^4^17^1^1^Claim Information^IBJT CLAIM SCREEN MENU^Claim Information^1^^1"
 .S ^SD(409.61,VALM,1)="^VALM HIDDEN ACTIONS"
 .S ^SD(409.61,VALM,"ARRAY")=" ^TMP(""IBJTCA"",$J)"
 .S ^SD(409.61,VALM,"FNL")="D EXIT^IBJTCA"
 .S ^SD(409.61,VALM,"HDR")="D HDR^IBJTCA"
 .S ^SD(409.61,VALM,"HLP")="D HELP^IBJTCA"
 .S ^SD(409.61,VALM,"INIT")="D INIT^IBJTCA"
 .S DA=VALM,DIK="^SD(409.61," D IX1^DIK K DA,DIK
 .W "Filed."
 ;
 W !,"'IBJT CT/IR APPEALS/DENIALS' List Template..."
 S DA=$O(^SD(409.61,"B","IBJT CT/IR APPEALS/DENIALS",0)),DIK="^SD(409.61," D ^DIK:DA
 K DO,DD S DIC(0)="L",DIC="^SD(409.61,",X="IBJT CT/IR APPEALS/DENIALS" D FILE^DICN S VALM=+Y
 I VALM>0 D
 .S ^SD(409.61,VALM,0)="IBJT CT/IR APPEALS/DENIALS^1^^80^4^21^1^1^Appeal/Denial^IBJT CT/IR REVIEWS/APPEALS MENU^Expanded Appeals/Denials^1^^1"
 .S ^SD(409.61,VALM,1)="^VALM HIDDEN ACTIONS"
 .S ^SD(409.61,VALM,"ARRAY")=" ^TMP(""IBTRDD"",$J)"
 .S ^SD(409.61,VALM,"FNL")="D EXIT^IBTRDD"
 .S ^SD(409.61,VALM,"HDR")="D HDR^IBTRDD"
 .S ^SD(409.61,VALM,"HLP")="D HELP^IBTRDD"
 .S ^SD(409.61,VALM,"INIT")="D INIT^IBTRDD"
 .S DA=VALM,DIK="^SD(409.61," D IX1^DIK K DA,DIK
 .W "Filed."
 ;
 W !,"'IBJT CT/IR COMMUNICATIONS LIST' List Template..."
 S DA=$O(^SD(409.61,"B","IBJT CT/IR COMMUNICATIONS LIST",0)),DIK="^SD(409.61," D ^DIK:DA
 K DO,DD S DIC(0)="L",DIC="^SD(409.61,",X="IBJT CT/IR COMMUNICATIONS LIST" D FILE^DICN S VALM=+Y
 I VALM>0 D
 .S ^SD(409.61,VALM,0)="IBJT CT/IR COMMUNICATIONS LIST^1^^132^4^17^1^1^Review/Contact^IBJT CT/IR COMMUNICATIONS LIST MENU^Insurance Reviews/Contacts^1^^1"
 .S ^SD(409.61,VALM,1)="^VALM HIDDEN ACTIONS"
 .S ^SD(409.61,VALM,"ARRAY")=" ^TMP(""IBJTRA"",$J)"
 .S ^SD(409.61,VALM,"COL",0)="^409.621^11^11"
 .S ^SD(409.61,VALM,"COL",1,0)="NUMBER^1^4"
 .S ^SD(409.61,VALM,"COL",2,0)="DATE^5^17^Date"
 .S ^SD(409.61,VALM,"COL",3,0)="INS CO^16^18^Ins. Co.^^1"
 .S ^SD(409.61,VALM,"COL",4,0)="GROUP^140^11^Group No."
 .S ^SD(409.61,VALM,"COL",5,0)="ACTION^55^9^Action"
 .S ^SD(409.61,VALM,"COL",6,0)="PRE-CERT^65^10^Auth. No."
 .S ^SD(409.61,VALM,"COL",7,0)="DAYS^76^5^Days"
 .S ^SD(409.61,VALM,"COL",8,0)="CONTACT^81^20^Person Contacted"
 .S ^SD(409.61,VALM,"COL",9,0)="PHONE^103^14^Phone"
 .S ^SD(409.61,VALM,"COL",10,0)="REF NO^119^12^Call Ref. No"
 .S ^SD(409.61,VALM,"COL",11,0)="TYPE^36^17^Type Contact"
 .S ^SD(409.61,VALM,"COL","AIDENT",1,3)=""
 .S ^SD(409.61,VALM,"FNL")="D EXIT^IBJTRA"
 .S ^SD(409.61,VALM,"HDR")="D HDR^IBJTRA"
 .S ^SD(409.61,VALM,"HLP")="D HELP^IBJTRA"
 .S ^SD(409.61,VALM,"INIT")="D INIT^IBJTRA"
 .S DA=VALM,DIK="^SD(409.61," D IX1^DIK K DA,DIK
 .W "Filed."
 ;
 W !,"'IBJT CT/IR REVIEWS' List Template..."
 S DA=$O(^SD(409.61,"B","IBJT CT/IR REVIEWS",0)),DIK="^SD(409.61," D ^DIK:DA
 K DO,DD S DIC(0)="L",DIC="^SD(409.61,",X="IBJT CT/IR REVIEWS" D FILE^DICN S VALM=+Y
 I VALM>0 D
 .S ^SD(409.61,VALM,0)="IBJT CT/IR REVIEWS^1^^80^4^21^1^1^Review^IBJT CT/IR REVIEWS/APPEALS MENU^Expanded Insurance Reviews^1^^1"
 .S ^SD(409.61,VALM,1)="^VALM HIDDEN ACTIONS"
 .S ^SD(409.61,VALM,"ARRAY")=" ^TMP(""IBTRCD"",$J)"
 .S ^SD(409.61,VALM,"FNL")="D EXIT^IBTRCD"
 .S ^SD(409.61,VALM,"HDR")="D HDR^IBTRCD"
 .S ^SD(409.61,VALM,"HLP")="D HELP^IBTRCD"
 .S ^SD(409.61,VALM,"INIT")="D INIT^IBTRCD"
 .S DA=VALM,DIK="^SD(409.61," D IX1^DIK K DA,DIK
 .W "Filed."
 ;
 G ^IBJYL3