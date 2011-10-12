PXIPOST1 ;ISL/dee - POST ROUTINE FOR PX PACKAGE ;8/6/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;;Aug 12, 1996
 ;
PROTOCOL ;
 N DIC,DA,MENU,NAMEIEN,X,Y,LABEL,PROTOCOL,OFFSET
 S DIC(0)="LSX"
 S DIC("P")=$P(^DD(101,10,0),"^",2)
 F LABEL="SDAMLIST","MHIDDEN","AEHIDDEN" D
 . S MENU=$P($T(@(LABEL)),";;",2) Q:MENU=""
 . D BMES^XPDUTL("Adding items to "_MENU_" protocol.")
 . S DA(1)=$O(^ORD(101,"B",MENU,0))
 . I DA(1)>0 D
 .. S DIC="^ORD(101,"_DA(1)_",10,"
 .. F OFFSET=1:1 S PROTOCOL=$P($T(@(LABEL)+OFFSET),";;",2) Q:PROTOCOL=""  D
 ... S X=$P(PROTOCOL,"~",1)
 ... S DIC("DR")=$P(PROTOCOL,"~",2)
 ... S NAMEIEN=$O(^ORD(101,"B",X,0))
 ... I NAMEIEN>0,$O(^ORD(101,DA(1),10,"B",NAMEIEN,0))'>0 D MES^XPDUTL("  "_X) D ^DIC
 K DIC,DA,X,Y
 ;
 S DIC(0)="LSX"
 S DIC("P")=$P(^DD(101,10,0),"^",2)
 F X="GMTS HS ADHOC","GMPL OE DATA ENTRY","GMRP REVIEW SCREEN" D
 . D BMES^XPDUTL("Adding item to PXCE "_X_" protocol.")
 . S DA(1)=$O(^ORD(101,"B","PXCE "_X,0))
 . I DA(1)>0 D
 .. S DIC="^ORD(101,"_DA(1)_",10,"
 .. S NAMEIEN=$O(^ORD(101,"B",X,0))
 .. I NAMEIEN>0,$O(^ORD(101,DA(1),10,"B",NAMEIEN,0))'>0 D ^DIC
 K DIC,DA,NAMEIEN,X,Y
 ;
 N DIE,DR,PROTNAME
 S DIE="^ORD(101,"
 S DR="2///@"
 D BMES^XPDUTL("Making sure that these protocols are not disabled.")
 F OFFSET=1:1 SET PROTNAME=$P($T(ENABLE+OFFSET),";;",2) Q:PROTNAME=""  D
 . D MES^XPDUTL("  "_PROTNAME)
 . S DA=$O(^ORD(101,"B",PROTNAME,0))
 . I DA>0 D ^DIE
 K DIC,DA,DIE,DR,PROTNAME
 ;
XQORM ;Recompile protocol menus
 D BMES^XPDUTL("Recompile protocol menus used by List Manager.")
 N XQORM
 F PROTNAME="PXCE MAIN MENU","PXCE MAIN HIDDEN ACTIONS","PXCE SDAM MENU","PXCE SDAM LIST MENU","PXCE ADD/EDIT MENU","PXCE ADD/EDIT HIDDEN" D
 . D MES^XPDUTL("  "_PROTNAME)
 . S XQORM=$O(^ORD(101,"B",PROTNAME,0))_";ORD(101,"
 . D XREF^XQORM
 Q
 ;
ENABLE ;;
 ;;PXCA DATA EVENT
 ;;PXCE ADD/EDIT
 ;;PXCE ADD/EDIT DISPLAY BRIEF
 ;;PXCE ADD/EDIT DISPLAY DETAIL
 ;;PXCE ADD/EDIT HIDDEN
 ;;PXCE ADD/EDIT INTERVIEW
 ;;PXCE ADD/EDIT KNOWN ENCOUNTER
 ;;PXCE ADD/EDIT MENU
 ;;PXCE ADD/EDIT PATIENT CHANGE
 ;;PXCE ADD/EDIT STOP CODE
 ;;PXCE BLANK 1
 ;;PXCE BLANK 2
 ;;PXCE BLANK 3
 ;;PXCE BLANK 4
 ;;PXCE BLANK HS
 ;;PXCE BLANK PL
 ;;PXCE BLANK PN
 ;;PXCE BLANK SELECT NEW PATIENT
 ;;PXCE CHANGE CLINIC STOP
 ;;PXCE CHANGE HOSPITAL LOCATION
 ;;PXCE CPT ADD
 ;;PXCE DATE CHANGE
 ;;PXCE DELETE V-FILE
 ;;PXCE DISPLAY DETAIL
 ;;PXCE EDIT V-FILE
 ;;PXCE ENCOUNTER EDIT
 ;;PXCE ENCOUNTER LIST
 ;;PXCE EXAM ADD
 ;;PXCE GMPL OE DATA ENTRY
 ;;PXCE GMRP REVIEW SCREEN
 ;;PXCE GMTS HS ADHOC
 ;;PXCE HEALTH FACTORS ADD
 ;;PXCE HISTORICAL ENCOUNTER
 ;;PXCE HOSPITAL LOCATION VIEW
 ;;PXCE IMMUNIZATION ADD
 ;;PXCE INTERVIEW
 ;;PXCE MAIN HIDDEN ACTIONS
 ;;PXCE MAIN MENU
 ;;PXCE NEW ENCOUNTER
 ;;PXCE PATIENT CHANGE
 ;;PXCE PATIENT ED ADD
 ;;PXCE POV ADD
 ;;PXCE PROVIDER ADD
 ;;PXCE QUIT
 ;;PXCE QUIT COMPLETELY
 ;;PXCE SDAM DISPLAY DETAIL
 ;;PXCE SDAM EXPAND
 ;;PXCE SDAM INTERVIEW
 ;;PXCE SDAM LIST
 ;;PXCE SDAM LIST MENU
 ;;PXCE SDAM MENU
 ;;PXCE SDAM STANDALONE
 ;;PXCE SDAM UPDATE ENCOUNTER
 ;;PXCE SKIN TEST ADD
 ;;PXCE TREATMENT ADD
 ;;PXK CPT-SCH TO V-CPT
 ;;PXK SDAM TO V-FILES
 ;;PXK VISIT DATA EVENT
 ;;
SDAMLIST ;;PXCE SDAM LIST MENU
 ;;SDAM LIST CHECKED IN~2///CI;3///1
 ;;SDAM LIST NO SHOWS~2///NS;3///2
 ;;SDAM LIST ALL~2///TA;3///3
 ;;SDAM LIST NO ACTION~2///NA;3///4
 ;;SDAM LIST CANCELLED~2///CA;3///5
 ;;SDAM LIST FUTURE~2///FU;3///6
 ;;SDAM LIST INPATIENT~2///IP;3///7
 ;;SDAM LIST NON-COUNT~2///NC;3///8
 ;;SDAM LIST CHECKED OUT~2///CO;3///9
 ;;
MHIDDEN ;;PXCE MAIN HIDDEN ACTIONS
 ;;VALM NEXT SCREEN~2///+;3///11
 ;;VALM PREVIOUS SCREEN~2///-;3///12
 ;;VALM UP ONE LINE~2///UP;3///13
 ;;VALM DOWN A LINE~2///DN;3///14
 ;;VALM REFRESH~2///RD;3///24
 ;;VALM PRINT SCREEN~2///PS;3///25
 ;;VALM PRINT LIST~2///PL;3///26
 ;;VALM RIGHT~2///>;3///15
 ;;VALM LEFT~2///<;3///16
 ;;VALM TURN ON/OFF MENUS~2///ADPL;3///32
 ;;VALM SEARCH LIST~2///SL;3///31
 ;;VALM LAST SCREEN~2///LS;3///22
 ;;VALM FIRST SCREEN~2///FS;3///21
 ;;VALM GOTO PAGE~2///GO;3///23
 ;;VALM BLANK 2~3///34
 ;;VALM BLANK 3~3///35
 ;;VALM BLANK 4~3///36
 ;;
AEHIDDEN ;;PXCE ADD/EDIT HIDDEN
 ;;VALM NEXT SCREEN~2///+;3///11
 ;;VALM PREVIOUS SCREEN~2///-;3///12
 ;;VALM UP ONE LINE~2///UP;3///13
 ;;VALM DOWN A LINE~2///DN;3///14
 ;;VALM REFRESH~2///RD;3///24
 ;;VALM PRINT SCREEN~2///PS;3///25
 ;;VALM PRINT LIST~2///PL;3///26
 ;;VALM RIGHT~2///>;3///15
 ;;VALM LEFT~2///<;3///16
 ;;VALM TURN ON/OFF MENUS~2///ADPL;3///32
 ;;VALM SEARCH LIST~2///SL;3///31
 ;;VALM LAST SCREEN~2///LS;3///22
 ;;VALM FIRST SCREEN~2///FS;3///21
 ;;VALM GOTO PAGE~2///GO;3///23
 ;;VALM BLANK 2~2///;3///34
 ;;