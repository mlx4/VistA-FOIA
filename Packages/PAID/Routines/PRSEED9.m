PRSEED9 ;HISC/MD-PRSE ATTENDENCE UPDATE CON'T ;8/10/99
 ;;4.0;PAID;**5,46,50**;Sep 21, 1995
ADD ; ADD RECORD
 S PRSELCL=$P(PRSEY,U,2),PRSELOC=$P($G(^PRSE(452.8,PRDA(2),3,PRDA(1),0)),U,2),PRSEDT=$P($G(^(0)),U),PRSENTR=$P($G(^(0)),U,4),PRSEEDT=$P($G(^(0)),U,3)
 S PRSEGF=$P(PRSEY,U,4),PRSETYP=$P(PRSEY,U,5),PRSEROU=$P(PRSEY,U,6),PRSESOR=$P(PRSEY,U,7),PRSEORG=$P(PRSEY,U,8),PRSECHR=$P(PRSEY,U,9),PRSECAT=$P(PRSEY,U,10),PRSECHON=$P(PRSEY,U,11),PRSECHOF=$P(PRSEY,U,14),PRSECOD=$P(PRSEY,U,17)
 S PRSEPOS=$P(PRSEY,U,12),PRSEPURP=$P($G(^PRSE(452.51,+PRSEPOS,0)),U),PRSECEU=$P(PRSEY,U,13),PRSEDCOS=$P(PRSEY,U,19),PRSEICOS=$P(PRSEY,U,20)
 S DLAYGO=452,DIC="^PRSE(452,",DIC(0)="LQ",X=+VA200DA K DD,DO D FILE^DICN I '(+Y>0) W $C(7),"NO ENTRY ADDED TO EMPLOYEE TRACKING FILE" S POUT=1 Q
 S (DA,DA(1),PRSEDA)=+Y,DIE=DIC
 S DR=$S(PRSEPROG="":"",1:"1///"_$E(PRSEPROG,1,53)_"")_$S(PRSEDT="":"",1:";2////"_PRSEDT_"")_$S(PRSECHON="":"",1:";2.2////"_PRSECHON_"")_$S(PRSECHOF="":"",1:";2.3////"_PRSECHOF_"")_$S(PRSENTR="":"",1:";2.4////"_PRSENTR_"")
 S DR=DR_$S(PRSECAT="":"",1:";4///`"_PRSECAT_"")_$S(PRSEPURP="":"",1:";4.1///"_PRSEPURP_"")_$S(PRSETYP="":"",1:";5////"_PRSETYP_"")_$S(PRSESOR="":"",1:";6///"_PRSESOR_"")_$S(PRSEORG="":"",1:";8///`"_PRSEORG_"")
 S DR=DR_$S(PRSECHR="":"",1:";9////"_PRSECHR_"")_$S(PRSECEU="":"",1:";9.1////"_PRSECEU_"")_$S(PRSEROU="":"",1:";20////"_PRSEROU_"")
 S DR(1,452,1)=$S(PRSELEN="":"",1:"2.1////"_PRSELEN_"")_$S(PRSECOD="":"",1:";11////"_PRSECOD_"")_$S(PRSESSN="":"",1:";10////"_PRSESSN_"")_$S(PRSESVC="":"",1:";12////"_PRSESVC_"")_$S(PRSEEDT="":"",1:";13////"_PRSEEDT_"")
 S DR(1,452,1)=DR(1,452,1)_$S(PRSELOC="":"",1:";13.5////"_PRSELOC_"")_$S(PRSELCL="":"",1:";14////"_PRSELCL_"")_$S(PRSEGF="":"",1:";15////"_PRSEGF_"")_$S(PRSEDCOS="":"",1:";18////"_PRSEDCOS_"")_$S(PRSEICOS="":"",1:";19////"_PRSEICOS_"")
 D ^DIE
 ; MOVE SERVICE REASONS FOR CLASS TO TRACKING FILE
 D
 .  S:'$D(^PRSE(452,DA(1),1,0)) ^(0)="^452.033PA^^"
 .  S PRSESWP=0 F  S PRSESWP=$O(^PRSE(452.8,PRDA(2),2,PRSESWP)) Q:PRSESWP'>0  S %X="^PRSE(452.8,PRDA(2),2,PRSESWP,",%Y="^PRSE(452,DA(1),1,PRSESWP," D %XY^%RCR
 .  K ^PRSE(452,DA(1),1,"B")
 .  Q
 S DIK="^PRSE(452,DA(1),1,",DIK(1)=".01^B" D ENALL^DIK
 S DA=$O(^PRSE(452.8,PRDA(2),3,PRDA(1),1,"B",+VA200DA,0)),DA(1)=PRDA(1),DA(2)=PRDA(2),DIK="^PRSE(452.8,DA(2),3,DA(1),1," I (+DA>0) D ^DIK
 Q