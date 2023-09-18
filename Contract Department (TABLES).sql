/* Tested on HSQLDB 1.8 */

/*

********************************************************************************
********************************************************************************
**																			  **
**                    *****   *   ***   *     ****    ***                     **
**                      *    * *  *  *  *     *      *                        **
**                      *   *   * ***   *     ***     ***                     **
**                      *   ***** *   * *     *          *                    **
**                      *   *   * ****  ***** *****  ****                     **
**																			  **
********************************************************************************
********************************************************************************

*/
/* All Docs we're storing */
CREATE TABLE "tblDOCUMENTS" (
	"ID_DOC" BIGINT GENERATED BY DEFAULT AS IDENTITY,
	"DOC"    LONGVARCHAR, /* Path to a file */
	PRIMARY KEY ("ID_DOC")
)
/* Locations */
/* Creating the State's table */
CREATE TABLE "tblSTATES"(
    "ID_STATE"        INT GENERATED BY DEFAULT AS IDENTITY,
    "FULL_STATE_NAME" VARCHAR(100) NOT NULL,
    "SHORT_NAME"      VARCHAR( 50),
    PRIMARY KEY ("ID_STATE"),
    UNIQUE ("FULL_STATE_NAME"),
    UNIQUE("SHORT_NAME")
)
/* Creating Area type's names */
CREATE TABLE "tblAREA_TYPE_NAMES" (
	"ID_AREA_TYPE_NAME" INT GENERATED BY DEFAULT AS IDENTITY,
	"AREA_TYPE_NAME"    VARCHAR_IGNORECASE(50) NOT NULL,
	PRIMARY KEY ("ID_AREA_TYPE_NAME"),
	UNIQUE("AREA_TYPE_NAME")
)
/* Creating Area's names */
CREATE TABLE "tblAREAS" (
	"ID_AREA"           INT GENERATED BY DEFAULT AS IDENTITY,
	"ID_AREA_TYPE_NAME" INT NOT NULL,
	"AREA_NAME"         VARCHAR_IGNORECASE(50) NOT NULL,
	"REVERSE_ORDER"     BOOLEAN DEFAULT FALSE,
	PRIMARY KEY ("ID_AREA"),
	FOREIGN KEY ("ID_AREA_TYPE_NAME")
		REFERENCES "tblAREA_TYPE_NAMES" ("ID_AREA_TYPE_NAME")
		ON DELETE RESTRICT,
	UNIQUE ("AREA_NAME")
)
/* Creating Locality type's names */
CREATE TABLE "tblLOCALITY_TYPE_NAMES" (
	"ID_LOCALITY_TYPE_NAME" INT GENERATED BY DEFAULT AS IDENTITY,
	"LOCALITY_TYPE_NAME"    VARCHAR_IGNORECASE(50) NOT NULL,
	PRIMARY KEY ("ID_LOCALITY_TYPE_NAME"),
	UNIQUE("LOCALITY_TYPE_NAME")
)
/* Creating Locality's names */
CREATE TABLE "tblLOCALITIES" (
	"ID_LOCALITY"           INT GENERATED BY DEFAULT AS IDENTITY,
	"ID_LOCALITY_TYPE_NAME" INT NOT NULL,
	"LOCALITY_NAME"         VARCHAR_IGNORECASE(50) NOT NULL,
	PRIMARY KEY ("ID_LOCALITY"),
	FOREIGN KEY ("ID_LOCALITY_TYPE_NAME")
		REFERENCES "tblLOCALITY_TYPE_NAMES" ("ID_LOCALITY_TYPE_NAME")
		ON DELETE RESTRICT,
	UNIQUE ("LOCALITY_NAME")
)
/* Creating street types name's table */
CREATE TABLE "tblSTREET_TYPE_NAMES" (
    "ID_STREET_TYPE_NAME" INT GENERATED BY DEFAULT AS IDENTITY,
    "STREET_TYPE_NAME"    VARCHAR_IGNORECASE(50),
    PRIMARY KEY ("ID_STREET_TYPE_NAME"),
    UNIQUE ("STREET_TYPE_NAME")
)
/* Creating street name's table */
CREATE TABLE "tblSTREETS" (
    "ID_STREET"           INT GENERATED BY DEFAULT AS IDENTITY,
    "ID_STREET_TYPE_NAME" INT NOT NULL,
    "STREET_NAME"         VARCHAR_IGNORECASE(50) NOT NULL,
    "REVERSE_ORDER"       BOOLEAN DEFAULT FALSE,
    PRIMARY KEY ("ID_STREET"),
    FOREIGN KEY ("ID_STREET_TYPE_NAME")
		REFERENCES "tblSTREET_TYPE_NAMES" ("ID_STREET_TYPE_NAME")
		ON DELETE RESTRICT,
    UNIQUE ("STREET_NAME", "ID_STREET_TYPE_NAME")        
)
/* Creating Locations table */
CREATE TABLE "tblLOCATIONS" (
	"ID_LOCATION" BIGINT GENERATED BY DEFAULT AS IDENTITY,
	"ID_STATE"    INT NOT NULL,
	"ID_AREA"     INT NOT NULL,
	"ID_LOCALITY" INT NOT NULL,
	"ID_STREET"   INT,
	"POSTCODE"    VARCHAR_IGNORECASE(6),
	"NUMBER"      INT,
	"CHARACTER"   VARCHAR(1),
	"FRACTION"    TINYINT,
	"BUILDING"    VARCHAR_IGNORECASE(6),
	"HOUSE"       VARCHAR_IGNORECASE(6),
	"PO_BOX"      VARCHAR_IGNORECASE(6),
	"OFFICE"      VARCHAR_IGNORECASE(6),
	"ROOM"        VARCHAR_IGNORECASE(6),
	"FLOOR"       VARCHAR_IGNORECASE(2),
	"APARTMENT"   VARCHAR_IGNORECASE(6),
	"PARLOR"      VARCHAR_IGNORECASE(6),
	PRIMARY KEY ("ID_LOCATION"),
	FOREIGN KEY ("ID_STATE")    REFERENCES "tblSTATES"     ("ID_STATE")        
		ON DELETE RESTRICT,
	FOREIGN KEY ("ID_AREA")     REFERENCES "tblAREAS"      ("ID_AREA")          
		ON DELETE RESTRICT,
	FOREIGN KEY ("ID_LOCALITY") REFERENCES "tblLOCALITIES" ("ID_LOCALITY") 
		ON DELETE RESTRICT,
	FOREIGN KEY ("ID_STREET")   REFERENCES "tblSTREETS"    ("ID_STREET")      
		ON DELETE SET NULL,
	CONSTRAINT "WRONG_POSTCODE" CHECK (LENGTH("POSTCODE")=6)
)
/* Creating Branches table */
CREATE TABLE "tblBRANCHES" (
	"ID_BRANCH"   BIGINT,
	"BRANCH_NAME" VARCHAR_IGNORECASE(30) NOT NULL,
	"COMMENT"     LONGVARCHAR,
	PRIMARY KEY ("ID_BRANCH"),
	FOREIGN KEY ("ID_BRANCH") REFERENCES "tblLOCATIONS" ("ID_LOCATION")
		ON DELETE RESTRICT,
	UNIQUE ("ID_BRANCH"), UNIQUE("BRANCH_NAME")
)
/* Zone's Description */ 
CREATE TABLE "tblZONES_DESCRIPTION" (
	"ZONE"        TINYINT NOT NULL,
	"ID_BRANCH"   BIGINT  NOT NULL,
	"DESCRIPTION" LONGVARCHAR,
	PRIMARY KEY("ZONE", "ID_BRANCH"),
	FOREIGN KEY ("ID_BRANCH")    REFERENCES "tblBRANCHES" ("ID_BRANCH")
		ON DELETE CASCADE
)
/* Creating Zones table */
CREATE TABLE "tblZONES" (
	"ID_LOCATION" BIGINT  NOT NULL,
	"ID_BRANCH"   BIGINT  NOT NULL,
	"ZONE"        TINYINT NOT NULL,
	PRIMARY KEY("ID_LOCATION", "ID_BRANCH"),
	FOREIGN KEY ("ID_LOCATION")       REFERENCES "tblLOCATIONS" ("ID_LOCATION")
		ON DELETE RESTRICT,
	FOREIGN KEY ("ZONE", "ID_BRANCH") REFERENCES 
		"tblZONES_DESCRIPTION" ("ZONE", "ID_BRANCH") ON DELETE RESTRICT
)
/* Creating Distances table */
CREATE TABLE "tblDISTANCE" (
	"ID_LOCATION" BIGINT        NOT NULL,
	"ID_BRANCH"   BIGINT        NOT NULL,
	"DISTANCE"    DECIMAL(19,4) DEFAULT 100.0,
	"SCREEN_SHOOT" LONGVARBINARY,
	PRIMARY KEY ("ID_LOCATION", "ID_BRANCH"),
	FOREIGN KEY ("ID_LOCATION") REFERENCES "tblLOCATIONS" ("ID_LOCATION")
		ON DELETE RESTRICT,
	FOREIGN KEY ("ID_BRANCH")   REFERENCES "tblBRANCHES"  ("ID_BRANCH")
		ON DELETE RESTRICT,
	CONSTRAINT "TOO_SHORT" CHECK ("DISTANCE" > 100)
)

/* Clients */
CREATE TABLE "tblCLIENT" (
	"ID_CLIENT"        BIGINT GENERATED BY DEFAULT AS IDENTITY,
	"SHORT_NAME"       VARCHAR_IGNORECASE(100) NOT NULL,
	"FULL_NAME"        VARCHAR(255)            NOT NULL,
	"NICKNAME"         VARCHAR( 50)            NOT NULL,
	"ACTUAL_ADDRESS"   BIGINT,
	"BUSINESS_ADDRESS" BIGINT,
	"POST_ADDRESS"     BIGINT,
	"OGRN"             VARCHAR_IGNORECASE(13),
	"OKFS"             VARCHAR_IGNORECASE( 2),
	"OKUD"             VARCHAR_IGNORECASE( 8),
	"OKTMO"            VARCHAR_IGNORECASE(11),
	"OKOGU"            VARCHAR_IGNORECASE( 7),
	"OKATO"            VARCHAR_IGNORECASE(11),
	"OKOPF"            VARCHAR_IGNORECASE( 5),
	"OKONH"            VARCHAR_IGNORECASE( 5),
	"M_LICENCE"        BOOLEAN DEFAULT FALSE, /* Has medical licence? */
	"S_CODE"           VARCHAR_IGNORECASE(4), /* Sibtechgaz's code */
	"ID_DOC"           BIGINT,                /* Documents. May I store more than one file? */
	PRIMARY KEY ("ID_CLIENT"),
	FOREIGN KEY("ACTUAL_ADDRESS")   REFERENCES "tblLOCATIONS" ("ID_LOCATION") 
		ON DELETE SET NULL,
	FOREIGN KEY("BUSINESS_ADDRESS") REFERENCES "tblLOCATIONS" ("ID_LOCATION")
		ON DELETE SET NULL,
	FOREIGN KEY("POST_ADDRESS")     REFERENCES "tblLOCATIONS" ("ID_LOCATION")
		ON DELETE SET NULL,
	FOREIGN KEY ("ID_DOC")          REFERENCES "tblDOCUMENTS" ("ID_DOC")
		ON DELETE SET NULL,
	CONSTRAINT "OGRN_INPUT"  CHECK (LENGTH("OGRN") =13),
	CONSTRAINT "OKFS_INPUT"  CHECK (LENGTH("OKFS") = 2),
	CONSTRAINT "OKUD_INPUT"  CHECK (LENGTH("OKUD") = 8),
	CONSTRAINT "OKTMO_INPUT" CHECK (LENGTH("OKTMO")=11),
	CONSTRAINT "OKOGU_INPUT" CHECK (LENGTH("OKOGU")= 7),
	CONSTRAINT "OKATO_INPUT" CHECK (LENGTH("OKATO")=11),
	CONSTRAINT "OKOPF_INPUT" CHECK (LENGTH("OKOPF")= 5),
	CONSTRAINT "OKONH_INPUT" CHECK (LENGTH("OKONH")= 5),
	UNIQUE("NICKNAME")
)
CREATE TABLE "tblPHONES" (
	"PHONE"     VARCHAR_IGNORECASE(10),
	"ID_CLIENT" BIGINT,
	PRIMARY KEY ("PHONE"),
	FOREIGN KEY ("ID_CLIENT") REFERENCES "tblCLIENT"
		ON DELETE SET NULL,
	CONSTRAINT "PHONE_NUMBER" CHECK (
		"PHONE" LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
	)
)
CREATE TABLE "tblEMAILS" (
	"EMAIL"     VARCHAR_IGNORECASE(50),
	"ID_CLIENT" BIGINT,
	PRIMARY KEY("EMAIL"),
	FOREIGN KEY ("ID_CLIENT") REFERENCES "tblCLIENT"
		ON DELETE SET NULL,
	CONSTRAINT "EMAIL" CHECK (
		"EMAIL" LIKE '%@%.%'
	)
)
/* Signatories for all Clients */
CREATE TABLE "tblSIGNATORIES" (
	"ID_SIGNATORY" BIGINT GENERATED BY DEFAULT AS IDENTITY,
	"ID_CLIENT"    BIGINT NOT NULL,
	"BDATE"        DATE NOT NULL,
	"EDATE"        DATE NOT NULL,
	"ID_DOC"       BIGINT,
	PRIMARY KEY ("ID_SIGNATORY"),
	FOREIGN KEY ("ID_CLIENT") REFERENCES "tblCLIENT" ("ID_CLIENT")
		ON DELETE CASCADE,
	FOREIGN KEY ("ID_DOC")    REFERENCES "tblDOCUMENTS" ("ID_DOC")
		ON DELETE SET NULL
)
/* Creating Client's tables */
/* Legal Entity */
CREATE TABLE "tblLEGAL_ENTITY" (
	"ID_CLIENT" BIGINT NOT NULL,
	"INN"       VARCHAR_IGNORECASE(10),
	"KPP"       VARCHAR_IGNORECASE( 9),
	"OKPO"      VARCHAR_IGNORECASE(10),
	PRIMARY KEY ("ID_CLIENT"),
	FOREIGN KEY ("ID_CLIENT") REFERENCES "tblCLIENT" ("ID_CLIENT")
		ON DELETE CASCADE,
	UNIQUE("INN"),
	CONSTRAINT "INN_LE"  CHECK(LENGTH("INN") =10),
	CONSTRAINT "KPP_LE"  CHECK(LENGTH("KPP") = 9),
	CONSTRAINT "OKPO_LE" CHECK(LENGTH("OKPO")=10)
)
/* Businessman or businesswoman */
CREATE TABLE "tblBUSINESSMAN" (
	"ID_CLIENT" BIGINT NOT NULL,
	"INN"       VARCHAR_IGNORECASE(12),
	"OKPO"      VARCHAR_IGNORECASE(8),
	PRIMARY KEY ("ID_CLIENT"),
	FOREIGN KEY ("ID_CLIENT") REFERENCES "tblCLIENT" ("ID_CLIENT")
		ON DELETE CASCADE,
	UNIQUE("INN"),
	CONSTRAINT "INN_BM"  CHECK(LENGTH("INN") =12),
	CONSTRAINT "OKPO_BM" CHECK(LENGTH("OKPO")= 8)
)
/* OKVED */
CREATE TABLE "tblOKVEDS" (
	"ID_OKVED" INT GENERATED BY DEFAULT AS IDENTITY,
	"CLASS"    VARCHAR_IGNORECASE(2) NOT NULL,
	"SUBCLASS" VARCHAR_IGNORECASE(1) NOT NULL,
	"GROUP"    VARCHAR_IGNORECASE(1) NOT NULL,
	"SUBGROUP" VARCHAR_IGNORECASE(1),
	"KIND"     VARCHAR_IGNORECASE(1),
	"DESCRIPTION" LONGVARCHAR,
	PRIMARY KEY ("ID_OKVED"),
	CONSTRAINT "OKVED_CLASS" CHECK(LENGTH("CLASS") = 2) /* There is ALWAYS 2-digit number! */

)
/* Relation between Clients and OKVEDS */
CREATE TABLE "tblCLIENT_OKVEDS" (
	"ID_CLIENT" BIGINT NOT NULL,
	"ID_OKVED"  INT    NOT NULL,
	PRIMARY KEY ("ID_CLIENT", "ID_OKVED"),
	FOREIGN KEY ("ID_CLIENT") REFERENCES 
		"tblCLIENT" ("ID_CLIENT") ON DELETE CASCADE,
	FOREIGN KEY ("ID_OKVED")  REFERENCES 
		"tblOKVEDS" ("ID_OKVED")  ON DELETE CASCADE,
	UNIQUE ("ID_CLIENT", "ID_OKVED")
)
/* Bank's Essential information */
CREATE TABLE "tblBANKS" (
	"BIK"          VARCHAR_IGNORECASE( 9) NOT NULL,
	"BANK_NAME"    VARCHAR(150)           NOT NULL,
	"CORR_ACCOUNT" VARCHAR_IGNORECASE(20) NOT NULL,
	PRIMARY KEY ("BIK"),
	CONSTRAINT "BIK_CHECK"    CHECK (LENGTH("BIK")=9),
	CONSTRAINT "CORR_ACCOUNT" CHECK (LENGTH("CORR_ACCOUNT")=20)
)
/* Accounts */
CREATE TABLE "tblACCOUNTS" (
	"ACCOUNT"   VARCHAR_IGNORECASE(20) NOT NULL,
	"BIK"       VARCHAR_IGNORECASE(20) NOT NULL,
	"ID_CLIENT" BIGINT                 NOT NULL,
	PRIMARY KEY ("ACCOUNT", "BIK"),
	FOREIGN KEY ("ID_CLIENT") REFERENCES "tblCLIENT" ("ID_CLIENT")
		ON DELETE RESTRICT,
	FOREIGN KEY ("BIK") REFERENCES "tblBANKS" ("BIK")
		ON DELETE RESTRICT,
	CONSTRAINT "ACCOUNT" CHECK (LENGTH("ACCOUNT")=20)
)
/* Units */
CREATE TABLE "tblUNITS" (
	"ID_UNIT" INT GENERATED BY DEFAULT AS IDENTITY,
	"UNIT"    VARCHAR(5),
	"IS_INT"  BOOLEAN DEFAULT FALSE,
	PRIMARY KEY ("ID_UNIT")
)
/*  Price-List  */
/* Good's types */
CREATE TABLE "tblGOOD_TYPES"(
	"ID_GOOD_TYPE" INT GENERATED BY DEFAULT AS IDENTITY,
	"GOOD_TYPE"    VARCHAR(50),
	PRIMARY KEY ("ID_GOOD_TYPE")
)
/* Good's names */
CREATE TABLE "tblGOOD_NAMES" (
	"ID_GOOD_NAME" INT GENERATED BY DEFAULT AS IDENTITY,
	"ID_GOOD_TYPE" INT          NOT NULL,
	"NAME_NS"      VARCHAR(150) NOT NULL,
	"NAME_GS"      VARCHAR(150) NOT NULL,
	PRIMARY KEY ("ID_GOOD_NAME"),
	FOREIGN KEY ("ID_GOOD_TYPE") REFERENCES "tblGOOD_TYPES" ("ID_GOOD_TYPE")
		ON DELETE RESTRICT
)
/* Some Goods use particular VAT */
CREATE TABLE "tblCUSTOM_VAT" (
	"ID_GOOD_NAME" INT   NOT NULL,
	"VAT"          FLOAT NOT NULL,
	PRIMARY KEY ("ID_GOOD_NAME"),
	FOREIGN KEY ("ID_GOOD_NAME") REFERENCES "tblGOOD_NAMES" ("ID_GOOD_NAME")
		ON DELETE CASCADE
)
/* Good's capacities */
CREATE TABLE "tblCAPACITIES" (
	"ID_GOOD_NAME" INT   NOT NULL,
	"CAPACITY"     FLOAT NOT NULL,
	"ID_UNIT"      INT,
	PRIMARY KEY ("ID_GOOD_NAME"),
	FOREIGN KEY ("ID_GOOD_NAME") REFERENCES "tblGOOD_NAMES" ("ID_GOOD_NAME")
		ON DELETE CASCADE,
	FOREIGN KEY ("ID_UNIT")      REFERENCES "tblUNITS" ("ID_UNIT")
		ON DELETE CASCADE
)
/* Sibtechgaz codes for goods */
CREATE TABLE "tblGOOD_CODES" (
	"ID_GOOD_NAME" INT        NOT NULL,
	"CODE"         VARCHAR(4) NOT NULL,
	PRIMARY KEY ("ID_GOOD_NAME"),
	FOREIGN KEY ("ID_GOOD_NAME") REFERENCES "tblGOOD_NAMES" ("ID_GOOD_NAME")
		ON DELETE CASCADE,
	UNIQUE ("CODE")
)
/* Price-List himself! */ 
CREATE TABLE "tblPRICE_LIST" (
	"ID_GOOD_NAME" INT           NOT NULL,
	"ID_BRANCH"    BIGINT        NOT NULL,
	"ID_UNIT"	   INT           NOT NULL,
	"PRICE"        DECIMAL(19,4) NOT NULL,
	PRIMARY KEY ("ID_GOOD_NAME", "ID_BRANCH", "ID_UNIT"),
	FOREIGN KEY ("ID_GOOD_NAME") REFERENCES "tblGOOD_NAMES" ("ID_GOOD_NAME")
		ON DELETE RESTRICT,
	FOREIGN KEY ("ID_BRANCH")    REFERENCES "tblBRANCHES"   ("ID_BRANCH")
		ON DELETE RESTRICT,
	FOREIGN KEY ("ID_UNIT")      REFERENCES "tblUNITS"      ("ID_UNIT")
		ON DELETE RESTRICT,
	UNIQUE ("ID_GOOD_NAME", "ID_BRANCH", "ID_UNIT")
)
/* Discounted goods with periods */
CREATE TABLE "tblPRICE_LIST_DISCOUNT" (
	"ID_GOOD_NAME" INT           NOT NULL,
	"ID_BRANCH"    BIGINT        NOT NULL,
	"ID_UNIT"	   INT           NOT NULL,
	"PRICE"        DECIMAL(19,4) DEFAULT 0.0,
	"BDATE"        DATE          NOT NULL,
	"EDATE"        DATE          NOT NULL,
	"COMMENT"      LONGVARCHAR,
	"ID_DOC"       BIGINT,
	PRIMARY KEY ("ID_GOOD_NAME", "ID_BRANCH", "ID_UNIT"),
	FOREIGN KEY ("ID_GOOD_NAME") REFERENCES "tblGOOD_NAMES" ("ID_GOOD_NAME")
		ON DELETE RESTRICT,
	FOREIGN KEY ("ID_BRANCH")    REFERENCES "tblBRANCHES"   ("ID_BRANCH")
		ON DELETE RESTRICT,
	FOREIGN KEY ("ID_UNIT")      REFERENCES "tblUNITS"      ("ID_UNIT")
		ON DELETE RESTRICT,
	FOREIGN KEY ("ID_DOC")       REFERENCES "tblDOCUMENTS"  ("ID_DOC")
		ON DELETE SET NULL,
	UNIQUE ("ID_GOOD_NAME", "ID_BRANCH", "ID_UNIT"),
	CONSTRAINT "DISCOUNT_GOODS" CHECK("EDATE" > "BDATE")
)

CREATE TABLE "tblMODIFICATORS" (
	"ID_MOD"   TINYINT NOT NULL,
	"MOD_NAME" VARCHAR(100),
	"MOD"      FLOAT NOT NULL,
	PRIMARY KEY ("ID_MOD")
)
/* Prices for gas' delivery in Zone-based areas */
CREATE TABLE "tblDELIVERY_GAS_ZONES"(
	"ID_BRANCH" BIGINT        NOT NULL,
	"ZONE"      TINYINT       NOT NULL,
	"MIN_BALL"  TINYINT       NOT NULL,
	"PRICE"     DECIMAL(19,4) DEFAULT 0.0,
	PRIMARY KEY ("ID_BRANCH", "ZONE", "MIN_BALL"),
	FOREIGN KEY ("ZONE","ID_BRANCH") REFERENCES 
		"tblZONES_DESCRIPTION" ("ZONE","ID_BRANCH") ON DELETE RESTRICT,
	UNIQUE ("MIN_BALL")
)

CREATE TABLE "tblDELIVERY_GAS_ZONES_DISCOUNT" (
	"ID_BRANCH" BIGINT        NOT NULL,
	"ZONE"      TINYINT       NOT NULL,
	"MIN_BALL"  TINYINT       NOT NULL,
	"PRICE"     DECIMAL(19,4) DEFAULT 0.0,
	"BDATE"     DATE          NOT NULL,
	"EDATE"     DATE          NOT NULL,
	"COMMENT"   LONGVARCHAR,
	"ID_DOC"    BIGINT,
	PRIMARY KEY ("ID_BRANCH", "ZONE", "MIN_BALL"),
	FOREIGN KEY ("ZONE","ID_BRANCH") REFERENCES 
		"tblZONES_DESCRIPTION" ("ZONE","ID_BRANCH") ON DELETE RESTRICT,
	FOREIGN KEY ("ID_DOC")           REFERENCES "tblDOCUMENTS" ("ID_DOC")
		ON DELETE SET NULL,
	UNIQUE ("MIN_BALL")
)
CREATE TABLE "tblGAS_DISTANCE"(
	"ID_BRANCH" BIGINT        NOT NULL,
	"MIN_BALL"  TINYINT       NOT NULL,
	"PRICE"     DECIMAL(19,4) DEFAULT 0.0,
	PRIMARY KEY ("ID_BRANCH", "MIN_BALL"),
	FOREIGN KEY ("ID_BRANCH") REFERENCES "tblBRANCHES" ("ID_BRANCH")
		ON DELETE CASCADE
)
CREATE TABLE "tblDELIVERY_GAS_DISTANCE_DISCOUNT" (
	"ID_BRANCH" BIGINT        NOT NULL,
	"MIN_BALL"  TINYINT       NOT NULL,
	"PRICE"     DECIMAL(19,4) DEFAULT 0.0,
	"BDATE"     DATE          NOT NULL,
	"EDATE"     DATE          NOT NULL,
	"COMMENT"   LONGVARCHAR,
	"ID_DOC"    BIGINT,
	PRIMARY KEY ("ID_BRANCH", "MIN_BALL"),
	FOREIGN KEY ("ID_BRANCH") REFERENCES "tblBRANCHES"  ("ID_BRANCH")
		ON DELETE CASCADE,
	FOREIGN KEY ("ID_DOC")    REFERENCES "tblDOCUMENTS" ("ID_DOC")
		ON DELETE SET NULL,
	UNIQUE ("MIN_BALL")
)
CREATE TABLE "tblDELIVERY_LIQUID_ZONES" (
	"ID_BRANCH" BIGINT        NOT NULL,
	"ZONE"      TINYINT       NOT NULL,
	"PRICE"     DECIMAL(19,4) DEFAULT 0.0,
	PRIMARY KEY ("ID_BRANCH", "ZONE"),
	FOREIGN KEY ("ZONE","ID_BRANCH") REFERENCES
		"tblZONES_DESCRIPTION" ("ZONE","ID_BRANCH") ON DELETE RESTRICT
)
CREATE TABLE "tblDELIVERY_LIQUID_ZONES_DISCOUNT" (
	"ID_BRANCH" BIGINT        NOT NULL,
	"ZONE"      TINYINT       NOT NULL,
	"PRICE"     DECIMAL(19,4) DEFAULT 0.0,
	"BDATE"     DATE          NOT NULL,
	"EDATE"     DATE          NOT NULL,
	"COMMENT"   LONGVARCHAR,
	"ID_DOC"    BIGINT,
	PRIMARY KEY ("ID_BRANCH", "ZONE"),
	FOREIGN KEY ("ZONE","ID_BRANCH") REFERENCES
		"tblZONES_DESCRIPTION" ("ZONE","ID_BRANCH") ON DELETE RESTRICT,
	FOREIGN KEY ("ID_DOC")           REFERENCES "tblDOCUMENTS" ("ID_DOC")
		ON DELETE SET NULL
)
CREATE TABLE "tblDELIVERY_LIQUID_DISTANCE" (
	"ID_BRANCH" BIGINT        NOT NULL,
	"PRICE"     DECIMAL(19,4) DEFAULT 0.0,
	PRIMARY KEY ("ID_BRANCH"),
	FOREIGN KEY ("ID_BRANCH") REFERENCES "tblBRANCHES"("ID_BRANCH")
		ON DELETE CASCADE
)
CREATE TABLE "tblDELIVERY_LIQUID_DISTANCE_DICOUNT" (
	"ID_BRANCH" BIGINT        NOT NULL,
	"PRICE"     DECIMAL(19,4) DEFAULT 0.0,
	"BDATE"     DATE          NOT NULL,
	"EDATE"     DATE          NOT NULL,
	"COMMENT"   LONGVARCHAR,
	"ID_DOC"    BIGINT,
	PRIMARY KEY ("ID_BRANCH"),
	FOREIGN KEY ("ID_BRANCH") REFERENCES "tblBRANCHES"  ("ID_BRANCH")
		ON DELETE CASCADE,
	FOREIGN KEY ("ID_DOC")    REFERENCES "tblDOCUMENTS" ("ID_DOC")
		ON DELETE SET NULL
)
/* Agreements */
CREATE TABLE "tblAGREEMENT" (
	"ID_AGREEMENT" BIGINT GENERATED BY DEFAULT AS IDENTITY,
	"ID_CLIENT"    BIGINT,
	"BDATE"        DATE,
	"SDATE"        DATE,
	"EDATE"        DATE,
	"COMMENT"      LONGVARCHAR,
	PRIMARY KEY ("ID_AGREEMENT"),
	FOREIGN KEY ("ID_CLIENT") REFERENCES "tblCLIENT" ("ID_CLIENT")
		ON DELETE CASCADE
)
/* Orders in agreement - contain goods with unified delivery issues */
CREATE TABLE "tblORDERS" (
	"ID_ORDER"     BIGINT GENERATED BY DEFAULT AS IDENTITY,
	"ID_LOCATION"  BIGINT NOT NULL,
	"ID_AGREEMENT" BIGINT NOT NULL,
	PRIMARY KEY ("ID_ORDER"),
	FOREIGN KEY ("ID_AGREEMENT") REFERENCES "tblAGREEMENT" ("ID_AGREEMENT")
		ON DELETE CASCADE
)
/* A link between order and agreement */
CREATE TABLE "tblGOODS_ORDERS" (
	"ID_ORDER"     BIGINT,
	"ID_GOOD_NAME" INT           NOT NULL,
	"AMOUNT"       FLOAT         DEFAULT 0.0,
	"ID_UNIT"      INT           NOT NULL,
	"PRICE"        DECIMAL(19,4) DEFAULT 0.0,
	PRIMARY KEY ("ID_ORDER", "ID_GOOD_NAME"),
	FOREIGN KEY ("ID_ORDER")     REFERENCES "tblORDERS"     ("ID_ORDER")
		ON DELETE CASCADE,
	FOREIGN KEY ("ID_GOOD_NAME") REFERENCES "tblGOOD_NAMES" ("ID_GOOD_NAME")
		ON DELETE CASCADE
)
/* Additional agreements */
CREATE TABLE "tblADD_AGR" (
	"ID_AA"        BIGINT GENERATED BY DEFAULT AS IDENTITY,
	"ID_AGREEMENT" BIGINT NOT NULL,
	"BDATE"        DATE,
	"SDATE"        DATE,
	"EDATE"        DATE,
	PRIMARY KEY ("ID_AA"),
	FOREIGN KEY ("ID_AGREEMENT") REFERENCES 
		"tblAGREEMENT" ("ID_AGREEMENT") ON DELETE CASCADE
)
/*

********************************************************************************
********************************************************************************
**																			  **
**                          *   * ***** ****  *   *  ***                      **
**                          *   *   *   *     * * * *                         **
**                          *   *   *   ***   *****  ***                      **
**                           * *    *   *      ***      *                     **
**                            *   ***** *****  * *  ****                      **
**																			  **
********************************************************************************
********************************************************************************

*/

/* Adresses */
/* All states I use in Database */
CREATE VIEW "viewSTATES" AS
	SELECT "tblSTATES"."FULL_STATE_NAME" AS "Имя государства",
		"tblSTATES"."ID_STATE"
	FROM "tblSTATES"
/* All Areas used into database */
CREATE VIEW "viewAREAS" AS
	SELECT CASEWHEN ("tblAREAS"."REVERSE_ORDER" = FALSE,
		"AREA_NAME" || ' ' || "AREA_TYPE_NAME",
		"AREA_TYPE_NAME" || ' ' || "AREA_NAME") AS "Регион",
		"tblAREAS"."ID_AREA"
	FROM "tblAREAS"
		INNER JOIN "tblAREA_TYPE_NAMES" ON 
			"tblAREAS"."ID_AREA_TYPE_NAME" =
				"tblAREA_TYPE_NAMES"."ID_AREA_TYPE_NAME"
	ORDER BY "AREA_NAME" ASC
/* All Localities used into database */	
CREATE VIEW "viewLOCALITIES" AS
	SELECT "tblLOCALITY_TYPE_NAMES"."LOCALITY_TYPE_NAME" || ' '
		|| "tblLOCALITIES"."LOCALITY_NAME" AS "Населённый пункт",
		"tblLOCALITIES"."ID_LOCALITY"
	FROM "tblLOCALITIES"
		INNER JOIN "tblLOCALITY_TYPE_NAMES" ON
			"tblLOCALITIES"."ID_LOCALITY_TYPE_NAME" = 
				"tblLOCALITY_TYPE_NAMES"."ID_LOCALITY_TYPE_NAME"
	ORDER BY "tblLOCALITIES"."LOCALITY_NAME" ASC
/* All streets I use in the DataBase */
CREATE VIEW "viewSTREETS" AS
	SELECT CASEWHEN ("tblSTREETS"."REVERSE_ORDER" = TRUE, 
		"tblSTREETS"."STREET_NAME" || COALESCE(' ' || "tblSTREET_TYPE_NAMES"."STREET_TYPE_NAME",''),
		COALESCE("tblSTREET_TYPE_NAMES"."STREET_TYPE_NAME" || ' ','')  || "tblSTREETS"."STREET_NAME")
		AS "Дорога",
		"tblSTREETS"."ID_STREET"
	FROM "tblSTREETS"
		INNER JOIN "tblSTREET_TYPE_NAMES" ON "tblSTREETS"."ID_STREET_TYPE_NAME" =
			"tblSTREET_TYPE_NAMES"."ID_STREET_TYPE_NAME"
	ORDER BY "tblSTREETS"."STREET_NAME" ASC
/* Short variant of addresses */
CREATE VIEW "viewSHORT_ADDRESS" AS
	SELECT "tblSTATES"."SHORT_NAME" || ', ' || "tblLOCALITIES"."LOCALITY_NAME" ||
		CONCAT(  /* For concating a null-values ALWAYS use CONCAT! */
			(CASEWHEN( "tblSTREETS"."REVERSE_ORDER" = TRUE, 
				CONCAT(', ' || "tblSTREETS"."STREET_NAME", ' ' || "tblSTREET_TYPE_NAMES"."STREET_TYPE_NAME"),
				CONCAT(', ' || "tblSTREET_TYPE_NAMES"."STREET_TYPE_NAME", ' ' || "tblSTREETS"."STREET_NAME"))),
		COALESCE(', ' || "tblLOCATIONS"."NUMBER", '') || COALESCE("tblLOCATIONS"."CHARACTER", '') ||
		COALESCE('/' || "tblLOCATIONS"."FRACTION", '') || COALESCE(', стр. ' || "tblLOCATIONS"."BUILDING", '') ||
		COALESCE(', корп. ' || "tblLOCATIONS"."HOUSE", '') || COALESCE(', а/я ' || "tblLOCATIONS"."PO_BOX", '') ||
		COALESCE(', комн. ' || "tblLOCATIONS"."PARLOR", '')|| COALESCE(', этаж ' || "tblLOCATIONS"."FLOOR", '') ||
		COALESCE(', офис ' || "tblLOCATIONS"."OFFICE", '') || COALESCE(', пом. ' || "tblLOCATIONS"."ROOM", '') ||
		COALESCE(', кв. ' || "tblLOCATIONS"."APARTMENT", '')
		) AS "Адрес краткий",
		"tblLOCATIONS"."ID_LOCATION"
	FROM "tblLOCATIONS"
		INNER JOIN "tblSTATES"              ON
			"tblLOCATIONS"."ID_STATE" = "tblSTATES"."ID_STATE"
		INNER JOIN "tblLOCALITIES"          ON
			"tblLOCALITIES"."ID_LOCALITY" = "tblLOCATIONS"."ID_LOCALITY"
		INNER JOIN "tblLOCALITY_TYPE_NAMES" ON "tblLOCALITY_TYPE_NAMES"."ID_LOCALITY_TYPE_NAME" = 
			"tblLOCALITIES"."ID_LOCALITY_TYPE_NAME"
		LEFT JOIN "tblSTREETS"              ON
			"tblSTREETS"."ID_STREET" = "tblLOCATIONS"."ID_STREET"
		LEFT JOIN "tblSTREET_TYPE_NAMES"    ON
			"tblSTREET_TYPE_NAMES"."ID_STREET_TYPE_NAME" =
			"tblSTREETS"."ID_STREET_TYPE_NAME"
		ORDER BY "tblLOCALITIES"."LOCALITY_NAME", "tblSTREETS"."STREET_NAME" ASC
/* Full version of address */
CREATE VIEW "viewFULL_ADDRESS" AS
	SELECT COALESCE("tblLOCATIONS"."POSTCODE" ||', ', '') || "tblSTATES"."FULL_STATE_NAME" || ', ' ||
		CASEWHEN("tblAREAS"."REVERSE_ORDER" = FALSE,
			"AREA_NAME" || ' ' || "AREA_TYPE_NAME",
			"AREA_TYPE_NAME" || ' ' || "AREA_NAME") || ', ' ||
		"tblLOCALITY_TYPE_NAMES"."LOCALITY_TYPE_NAME" || ' ' || "tblLOCALITIES"."LOCALITY_NAME" ||
		CONCAT( /* For concating a NULL-values ALWAYS use CONCAT! */
			CASEWHEN( "tblSTREETS"."REVERSE_ORDER" = TRUE, 
				CONCAT(', ' || "tblSTREETS"."STREET_NAME", ' ' || "tblSTREET_TYPE_NAMES"."STREET_TYPE_NAME"),
				CONCAT(', ' || "tblSTREET_TYPE_NAMES"."STREET_TYPE_NAME", ' ' || "tblSTREETS"."STREET_NAME")),
		COALESCE(', ' || "tblLOCATIONS"."NUMBER", '') || COALESCE("tblLOCATIONS"."CHARACTER", '') ||
		COALESCE('/' || "tblLOCATIONS"."FRACTION", '') || COALESCE(', стр. ' || "tblLOCATIONS"."BUILDING", '') ||
		COALESCE(', корп. ' || "tblLOCATIONS"."HOUSE", '') || COALESCE(', а/я ' || "tblLOCATIONS"."PO_BOX", '') ||
		COALESCE(', комн. ' || "tblLOCATIONS"."PARLOR", '') || COALESCE(', этаж ' || "tblLOCATIONS"."FLOOR", '') ||
		COALESCE(', офис ' || "tblLOCATIONS"."OFFICE", '') || COALESCE(', пом. ' || "tblLOCATIONS"."ROOM", '') ||
		COALESCE(', кв. ' || "tblLOCATIONS"."APARTMENT", '')
		) AS "Адрес полный",
		"tblLOCATIONS"."ID_LOCATION"
	FROM "tblLOCATIONS"
		INNER JOIN "tblSTATES"              ON 
			"tblLOCATIONS"."ID_STATE" = "tblSTATES"."ID_STATE"
		INNER JOIN "tblAREAS"               ON 
			"tblLOCATIONS"."ID_AREA" = "tblAREAS"."ID_AREA"
		INNER JOIN "tblAREA_TYPE_NAMES"     ON
			"tblAREAS"."ID_AREA_TYPE_NAME" = "tblAREA_TYPE_NAMES"."ID_AREA_TYPE_NAME"
		INNER JOIN "tblLOCALITIES"          ON 
			"tblLOCALITIES"."ID_LOCALITY" = "tblLOCATIONS"."ID_LOCALITY"
		INNER JOIN "tblLOCALITY_TYPE_NAMES" ON 
			"tblLOCALITY_TYPE_NAMES"."ID_LOCALITY_TYPE_NAME" = 
			"tblLOCALITIES"."ID_LOCALITY_TYPE_NAME"
		LEFT JOIN "tblSTREETS"              ON 
			"tblSTREETS"."ID_STREET" = "tblLOCATIONS"."ID_STREET"
		LEFT JOIN "tblSTREET_TYPE_NAMES"    ON
			"tblSTREET_TYPE_NAMES"."ID_STREET_TYPE_NAME" =
			"tblSTREETS"."ID_STREET_TYPE_NAME"
		ORDER BY "tblLOCALITIES"."LOCALITY_NAME" ASC, "tblSTREETS"."STREET_NAME" ASC
/* OKVEDS */
CREATE VIEW "viewOKVED" AS
		SELECT CONCAT("tblOKVEDS"."CLASS" || '.' || "tblOKVEDS"."SUBCLASS" || "tblOKVEDS"."GROUP",
			CONCAT('.' ||"tblOKVEDS"."SUBGROUP", "tblOKVEDS"."KIND")) AS "ОКВЭД", 
			"tblOKVEDS"."DESCRIPTION" AS "Описание"
		FROM "tblOKVEDS"
/* Goods I'm using in Contract Department */
CREATE VIEW "viewGOOD_NAMES" AS
	SELECT "tblGOOD_NAMES"."NAME_NS" AS "Товар",
		   "tblGOOD_NAMES"."ID_GOOD_NAME"
	FROM   "tblGOOD_NAMES"
/* Good's types I'm using in Contract Department */
CREATE VIEW "viewGOOD_TYPES" AS
	SELECT "tblGOOD_TYPES"."GOOD_TYPE"    AS "Тип Товара"
		   "tblGOOD_TYPES"."ID_GOOD_TYPE" 
	FROM   "tblGOOD_TYPES"
/* Everything about Goods */
CREATE VIEW "viewGOODS" AS
	SELECT "GC"."CODE"      AS "Код",
		   "GN"."NAME_NS"   AS "Товар",
		   "TT"."GOOD_TYPE" AS "Тип Товара",
		   "CV"."VAT"       AS "Особый НДС",
		   "TC"."CAPACITY"  AS "Ёмкость"
	FROM "tblGOOD_NAMES" AS "GN"
		LEFT JOIN "tblGOOD_CODES" AS "GC" ON 
			"GC"."ID_GOOD_NAME" = "GN"."ID_GOOD_NAME"
		LEFT JOIN "tblGOOD_TYPES" AS "TT" ON 
			"TT"."ID_GOOD_TYPE" = "GN"."ID_GOOD_TYPE"
		LEFT JOIN "tblCUSTOM_VAT" AS "CV" ON
			"CV"."ID_GOOD_NAME" = "GN"."ID_GOOD_NAME"
		LEFT JOIN "tblCAPACITIES" AS "TC" ON
			"TC"."ID_GOOD_NAME" = "GN"."ID_GOOD_NAME"
/* Price List standard units */
CREATE VIEW "viewPRICE_LIST" AS
	SELECT "tblGOOD_NAMES"."NAME_NS"   AS "Наименование Продукции",
		   "tblBRANCHES"."BRANCH_NAME" AS "Филиал",
		   "tblUNITS"."UNIT"           AS "ед.изм.",
		   "tblPRICE_LIST"."PRICE"     AS "Цена"
	FROM "tblPRICE_LIST"
		INNER JOIN "tblGOOD_NAMES" ON 
			"tblGOOD_NAMES"."ID_GOOD_NAME" = 
			"tblPRICE_LIST"."ID_GOOD_NAME"
		INNER JOIN "tblBRANCHES"   ON
			"tblBRANCHES"."ID_BRANCH" = "tblPRICE_LIST"."ID_BRANCH"
		INNER JOIN "tblUNITS"      ON "tblUNITS"."ID_UNIT" = 
			"tblPRICE_LIST"."ID_UNIT"
	ORDER BY "tblPRICE_LIST"."ID_BRANCH" ASC
/* Price List in ballons */
CREATE VIEW "viewPRICE_LIST_BALLONS" AS
	SELECT "tblGOOD_NAMES"."NAME_NS"   AS "Наименование Продукции",
		   "tblBRANCHES"."BRANCH_NAME" AS "Филиал",
		   CAST(CASEWHEN(LOWER("tblUNITS"."UNIT") = 'бал.', 
				"tblPRICE_LIST"."PRICE",
				"tblPRICE_LIST"."PRICE" * "tblCAPACITIES"."CAPACITY" ) 
				AS DECIMAL(19,4)) AS "Цена"
	FROM "tblPRICE_LIST"
		INNER JOIN "tblGOOD_NAMES" ON 
			"tblGOOD_NAMES"."ID_GOOD_NAME" = "tblPRICE_LIST"."ID_GOOD_NAME"
		INNER JOIN "tblBRANCHES"   ON
			"tblBRANCHES"."ID_BRANCH" = "tblPRICE_LIST"."ID_BRANCH"
		INNER JOIN "tblCAPACITIES" ON "tblCAPACITIES"."ID_GOOD_NAME" = 
			"tblPRICE_LIST"."ID_GOOD_NAME"
		INNER JOIN "tblUNITS"      ON "tblUNITS"."ID_UNIT" = 
			"tblPRICE_LIST"."ID_UNIT"
	ORDER BY "tblPRICE_LIST"."ID_BRANCH" ASC,"tblGOOD_NAMES"."NAME_NS" ASC
