<cfcomponent hint="B2B operasyonlari">
<cfset dsn = application.systemParam.params().dsn>

    <cffunction  name="getCats"  access="remote" returntype="any" returnFormat="json" httpMethod="POST" description="Kategorileri Getirir" output="no">
    <cfargument  name="catId" default="0" type="numeric">
    <cfargument  name="hiearchy" default="" type="string">
    <cfargument  name="type" default="1">
            <cfquery name="getCat" datasource="#dsn#_product">               
            SELECT PRODUCT_CATID,HIERARCHY,PRODUCT_CAT,IMAGE_CAT,IS_SHOW_MAIN_PAGE,DETAIL FROM PRODUCT_CAT WHERE 1=1 <cfif len(arguments.catId) and arguments.catId neq 0> and PRODUCT_CATID in(#arguments.catId#) </cfif>
            <cfif len(arguments.hiearchy)> and HIERARCHY LIKE '#arguments.hiearchy#%' </cfif> AND IS_PUBLIC=1
            ORDER BY HIERARCHY
        </cfquery>
        <cfset RetArr = arrayNew(1)>
        <cfloop query="getCat">
            <cfscript>
                item=structNew();
                item.PRODUCT_CATID=PRODUCT_CATID;
                item.HIERARCHY=HIERARCHY;
                item.PRODUCT_CAT=PRODUCT_CAT;
                item.IMAGE=IMAGE_CAT;
                item.IS_SHOW_MAIN_PAGE=IS_SHOW_MAIN_PAGE;
                item.DETAIL=DETAIL;
                arrayAppend(RetArr, item);
            </cfscript>
        </cfloop>
    <cfif arguments.type eq 1>
    <cfreturn Replace(SerializeJSON(RetArr),'//','')>
    <cfelse>
    <cfreturn Replace(SerializeJSON(getCat),'//','')>
    </cfif>
    </cffunction>
        <cffunction  name="getMainMenu"  access="remote" returntype="any" returnFormat="json" httpMethod="POST">
            <cfargument  name="type" default="1">
            <cfquery name="getCat" datasource="#dsn#_product">               
            SELECT PRODUCT_CATID,HIERARCHY,PRODUCT_CAT,IMAGE_CAT,DETAIL FROM PRODUCT_CAT WHERE 1=1  AND IS_PUBLIC=1 AND IS_SHOW_MAIN_PAGE =1
            ORDER BY HIERARCHY
        </cfquery>
        <cfset RetArr = arrayNew(1)>
        <cfloop query="getCat">
            <cfscript>
                item=structNew();
                item.PRODUCT_CATID=PRODUCT_CATID;
                item.HIERARCHY=HIERARCHY;
                item.PRODUCT_CAT=PRODUCT_CAT;
                item.IMAGE=IMAGE_CAT;
                item.DETAIL=DETAIL;
                arrayAppend(RetArr, item);
            </cfscript>
        </cfloop>
    <cfif arguments.type eq 1>
    <cfreturn Replace(SerializeJSON(RetArr),'//','')>
    <cfelse>
    <cfreturn Replace(SerializeJSON(getCat),'//','')>
    </cfif>
    </cffunction>
    <cffunction  name="loginControl"  access="remote" returntype="any" returnFormat="json" httpMethod="POST">
        <cfargument  name="username" required="true">
        <cfargument  name="password" required="true">
        <cfargument  name="companycode" required="true">
        <cfquery name="GET_LIST" datasource="#dsn#">
            SELECT
                C.NICKNAME,
                C.FULLNAME,
                C.COMPANY_ID,
                CP.PARTNER_ID, 
                MSP.TIME_ZONE,
                MSP.LANGUAGE_ID,
                MSP.LOGIN_TIME,
                MSP.MAXROWS,
                MSP.TIMEOUT_LIMIT,
                CP.COMPANY_PARTNER_NAME,
                CP.COMPANY_PARTNER_SURNAME,
                CP.COMPANY_PARTNER_USERNAME,
                CP.COMPANY_PARTNER_PASSWORD,
                SP.PERIOD_ID,
                SP.PERIOD_YEAR,
                SP.OUR_COMPANY_ID,
                SP.OTHER_MONEY,
                SP.STANDART_PROCESS_MONEY,
                OC.COMPANY_NAME,
                OC.EMAIL,
                OC.NICK_NAME,
                OCI.SPECT_TYPE,
                OCI.IS_USE_IFRS,
                OCI.RATE_ROUND_NUM,
                ISNULL((SELECT TOP 1 WRK_MESSAGE.RECEIVER_ID FROM WRK_MESSAGE WHERE WRK_MESSAGE.RECEIVER_ID = CP.PARTNER_ID AND WRK_MESSAGE.RECEIVER_TYPE = 1),0) AS CONTROL_MESSAGE,
                SM.MONEY,
                ISNULL(CP2.PERIOD_DATE,ISNULL(SP.PERIOD_DATE,SP.START_DATE)) AS PERIOD_DATE,
                CP.COMPANY_PARTNER_EMAIL,
                CC.MONEY AS CALISILAN_PARA              
            FROM 
                COMPANY_PARTNER AS CP
                LEFT JOIN COMPANY AS C ON C.COMPANY_ID = CP.COMPANY_ID
                LEFT JOIN COMPANY_PERIOD AS CP2 ON CP2.COMPANY_ID = C.COMPANY_ID
                LEFT JOIN MY_SETTINGS_P AS MSP ON MSP.PARTNER_ID = CP.PARTNER_ID
                LEFT JOIN SETUP_PERIOD AS SP ON SP.PERIOD_ID = CP2.PERIOD_ID
                LEFT JOIN SETUP_MONEY AS SM ON SM.PERIOD_ID = SP.PERIOD_ID
                LEFT JOIN OUR_COMPANY AS OC ON OC.COMP_ID = SP.OUR_COMPANY_ID
                LEFT JOIN OUR_COMPANY_INFO AS OCI ON OCI.COMP_ID = OC.COMP_ID
                LEFT JOIN COMPANY_CREDIT AS CC ON CC.COMPANY_ID=C.COMPANY_ID
            WHERE
                CP.COMPANY_PARTNER_USERNAME = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.username#"> AND
                CP.COMPANY_PARTNER_PASSWORD = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.password#"> AND
                CP.COMPANY_PARTNER_STATUS = 1 AND
                C.COMPANY_STATUS = 1 AND
                C.ISPOTANTIAL = 0 AND
                C.MEMBER_CODE = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.companycode#"> AND
                SP.OUR_COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="1"> AND
                
                SM.RATE1 = SM.RATE2
                order by sp.PERIOD_YEAR desc
        </cfquery>
        <cfscript>
         employee=structNew();
        if(GET_LIST.recordcount){
           employee.LoginStatus=1;
            employee.NAME=GET_LIST.COMPANY_PARTNER_NAME;
            employee.SURNAME=GET_LIST.COMPANY_PARTNER_SURNAME;
            employee.COMPANY_ID=GET_LIST.COMPANY_ID;
            employee.PARTNER_ID=GET_LIST.PARTNER_ID;
            employee.EMAIL=GET_LIST.COMPANY_PARTNER_EMAIL;
            employee.COMPANY_NICKNAME=GET_LIST.NICKNAME;
            employee.COMPANY_FULLNAME=GET_LIST.FULLNAME;
            employee.CALISILAN_PARA=GET_LIST.CALISILAN_PARA;
            }else{
                employee.LoginStatus=0;
            }
        </cfscript>
        <cfreturn Replace(SerializeJSON(employee),'//','')>
    </cffunction>
    <cffunction  name="getProducts" access="remote" returntype="any" returnFormat="json" httpMethod="POST" hint="Ürünleri Getirir">
        <cfargument  name="catId" default="" hint="Kategori id" >
        <cfargument  name="hiearchy" default="">
        <cfargument  name="product_id" default="">
        <cfargument  name="keyword" default="">
        <cfargument  name="brand_ids" default="">
        <cfargument  name="company_id" default="">
        <cfargument  name="start_row" default="1">
        <cfargument  name="end_row" default="20">
        <cfquery name="getProducts" datasource="#dsn#_product">
           WITH CTE1 AS ( SELECT * FROM PRODUCT WHERE 1=1 <cfif len(arguments.catId)>AND PRODUCT_CATID=#arguments.catid#</cfif>
            <cfif len(arguments.hiearchy)> AND PRODUCT_CODE LIKE '#arguments.hiearchy#%'</cfif>
            <cfif len(arguments.product_id)>AND PRODUCT_ID=#arguments.product_id#</cfif> 
            <cfif len(arguments.keyword)>AND (
                PRODUCT_CODE LIKE '%#arguments.keyword#%' or
                PRODUCT_NAME LIKE '%#arguments.keyword#%')
            </cfif> 
            AND IS_INTERNET=1
            <cfif len(arguments.brand_ids)>AND BRAND_ID IN(#arguments.brand_ids#)</cfif>
              ),
           CTE2 AS (
				SELECT
					CTE1.*,
					ROW_NUMBER() OVER(ORDER BY		PRODUCT_ID					) AS RowNum,(SELECT COUNT(*) FROM CTE1) AS QUERY_COUNT
				FROM
					CTE1
			)
			SELECT
				CTE2.*
			FROM
				CTE2
			WHERE
				RowNum BETWEEN #arguments.start_row# and #arguments.end_row#
        </cfquery>
        <cfset returnValue=structNew()>
        <cfset returnValue.total_records=getProducts.QUERY_COUNT>
        <cfset returnValue.start_row=arguments.start_row>
        <cfset returnValue.end_row=arguments.end_row>
        <cfif len(arguments.company_id)>
        <cfquery name="isHvPriceList" datasource="#dsn#_1">
            SELECT PRICE_CATID FROM PRICE_CAT_EXCEPTIONS WHERE COMPANY_ID=#arguments.company_id# AND IS_DEFAULT=1 AND PURCHASE_SALES=1 
        </cfquery>
        <cfset priceLists=valueList(isHvPriceList.PRICE_CATID)>
        <cfelse>
         <cfset priceLists="0">
         </cfif>
         <cfset productArr=arrayNew(1)>
        <cfloop query="getProducts">
        <cfquery name="getStokinf" datasource=#dsn#>
        select * from catalystTest_#year(now())#_1.GET_PRODUCT_STOCK where PRODUCT_ID=#getProducts.PRODUCT_ID#
        </cfquery>

        <cfset product = structNew()>
            <cfquery name="getProduct_images" datasource="#dsn#_product">
                SELECT * FROM PRODUCT_IMAGES WHERE PRODUCT_ID=#getProducts.PRODUCT_ID# AND IS_INTERNET=1
            </cfquery>
            <cfset PRODUCT.IMAGE_COUNT =getProduct_images.RECORDCOUNT>
            <cfset imgArr=arrayNew(1)>
            <cfloop query="getProduct_images">
                <cfset img=structNew()>
                <cfset img.PATH=getProduct_images.PATH>
                <cfset img.NAME=getProduct_images.PRD_IMG_NAME>
                <cfset img.SIZE=getProduct_images.IMAGE_SIZE>
                <cfscript>
                arrayAppend(imgArr, img);
                </cfscript>
            </cfloop>
            <cfif priceLists neq 0 and listlen(priceLists)>
            <cfquery name="getproductPrice" datasource="#dsn#_1">
                SELECT PRICE,PRICE_KDV,IS_KDV,PRODUCT_ID,MONEY FROM catalystTest_1.PRICE WHERE PRICE_CATID IN(#priceLists#) and PRODUCT_ID =#getProducts.PRODUCT_ID#
            </cfquery>
            <cfelse>
            <cfquery name="getproductPrice" datasource="#dsn#_product">
                SELECT PRICE,PRICE_KDV,MONEY FROM PRICE_STANDART WHERE PURCHASESALES=1 and PRODUCT_ID =#getProducts.PRODUCT_ID#
            </cfquery>
            </cfif>           

            <cfscript>
                PR_PRODUCT=structNew();
                PR_PRODUCT.PRICE=getproductPrice.PRICE;
                PR_PRODUCT.PRICE_KDV=getproductPrice.PRICE_KDV;
                PR_PRODUCT.MONEY=getproductPrice.MONEY;
                PRODUCT.PRODUCT_PRICE=PR_PRODUCT;
                PRODUCT.BRAND_ID=getProducts.BRAND_ID;
                PRODUCT.CAS_NO=PRODUCT_DETAIL;
                PRODUCT.MANUFACT_CODE=MANUFACT_CODE;
                PRODUCT.STOCK_COUNT=getStokinf.PRODUCT_TOTAL_STOCK;
                PRODUCT.PRODUCT_NAME=getProducts.PRODUCT_NAME;
                PRODUCT.PRODUCT_CODE=getProducts.PRODUCT_CODE;
                PRODUCT.PRODUCT_CODE_2=getProducts.PRODUCT_CODE_2;
                PRODUCT.PRODUCT_ID=getProducts.PRODUCT_ID;
                PRODUCT.PRODUCT_CATID=getProducts.PRODUCT_CATID;
                PRODUCT.IMAGES=imgArr;
                arrayAppend(productArr, PRODUCT);
            </cfscript>
        </cfloop>
        <cfset returnValue.PRODUCT_LIST=productArr>
        <cfreturn Replace(SerializeJSON(returnValue),'//','')>
    </cffunction>
    <cffunction  name="getOrders" access="remote" returntype="any" returnFormat="json" httpMethod="POST">
        <cfargument  name="company_id" >
        <cfargument  name="start_row" default="1">
        <cfargument  name="end_row" default="20">
        <cfquery name="getOrders" datasource="#dsn#_1">
            SELECT ORDER_HEAD,
                SHIP_ADDRESS,
                GROSSTOTAL,
                TAXTOTAL,
                OTHER_MONEY,
                OTHER_MONEY_VALUE,
                ORDER_DETAIL,
                ORDER_ID,
                ORDER_DATE,
                NETTOTAL,
                ORDER_CURRENCY,
                CITY.CITY_NAME,
                COUNTY.COUNTY_NAME,
                COUNTRY.COUNTRY_NAME ,
                CP.COMPANY_PARTNER_NAME,
                CP.COMPANY_PARTNER_SURNAME,
                PTR.STAGE
                FROM catalystTest_1.ORDERS AS O
                LEFT JOIN catalystTest.SETUP_CITY AS CITY ON CITY.CITY_ID=O.CITY_ID
                LEFT JOIN catalystTest.SETUP_COUNTY AS COUNTY ON COUNTY.COUNTY_ID=O.COUNTY_ID
                LEFT JOIN catalystTest.SETUP_COUNTRY AS COUNTRY ON COUNTRY.COUNTRY_ID=O.COUNTRY_ID
                LEFT JOIN catalystTest.COMPANY_PARTNER AS  CP ON CP.PARTNER_ID=O.PARTNER_ID
                LEFT JOIN catalystTest.PROCESS_TYPE_ROWS AS PTR ON PTR.PROCESS_ROW_ID=O.ORDER_STAGE
            WHERE O.COMPANY_ID =#arguments.company_id#
        </cfquery>
        <cfset orderArr=arrayNew(1)>
        <cfloop query="getOrders">
            <cfset item=structNew()>
            <cfset item.ORDER_HEAD=ORDER_HEAD><!----Ok---->
            <cfset item.SHIP_ADDRESS=SHIP_ADDRESS><!----Ok---->
            <cfset item.GROSSTOTAL=GROSSTOTAL><!----Ok---->
            <cfset item.TAXTOTAL=TAXTOTAL><!----Ok---->
            <cfset item.OTHER_MONEY=OTHER_MONEY><!----Ok---->
            <cfset item.OTHER_MONEY_VALUE=OTHER_MONEY_VALUE><!----Ok---->
            <cfset item.ORDER_DETAIL=ORDER_DETAIL><!----Ok---->
            <cfset item.ORDER_ID=ORDER_ID><!----Ok---->
            <cfset item.ORDER_DATE=ORDER_DATE>
            <cfset item.NETTOTAL=NETTOTAL>
            <cfset item.ORDER_CURRENCY=ORDER_CURRENCY>
            <cfset item.CITY_NAME=CITY_NAME>
            <cfset item.COUNTY_NAME=COUNTY_NAME>
            <cfset item.COUNTRY_NAME=COUNTRY_NAME>
            <cfset item.COMPANY_PARTNER_NAME=COMPANY_PARTNER_NAME>
            <cfset item.COMPANY_PARTNER_SURNAME=COMPANY_PARTNER_SURNAME>
            <cfset item.STAGE=STAGE>
           <cfscript>
           arrayAppend(orderArr, item);
           </cfscript>
        </cfloop>
        <cfreturn Replace(SerializeJSON(orderArr),'//','')>
    </cffunction>
    <cffunction  name="getOrderrows" access="remote" returntype="any" returnFormat="json" httpMethod="POST">
     <cfargument  name="order_id" >
     <cfquery name="getOrderRow" datasource="#dsn#_1">
        SELECT P.PRODUCT_NAME,
            ORDR.QUANTITY,
            ORDR.PRICE,
            ORDR.PRICE_OTHER,
            ORDR.UNIT,
            ORDR.TAX,
            ORDR.NETTOTAL,
            ORDR.OTHER_MONEY,
            ORDR.OTHER_MONEY_VALUE,
            CASE 
                WHEN ORDER_ROW_CURRENCY = - 1
                    THEN 'AÇIK'
                WHEN ORDER_ROW_CURRENCY = - 2
                    THEN 'TEDARİK'
                WHEN ORDER_ROW_CURRENCY = - 3
                    THEN 'KAPATILDI'
                WHEN ORDER_ROW_CURRENCY = - 4
                    THEN 'KISMİ ÜRETİM'
                WHEN ORDER_ROW_CURRENCY = - 5
                    THEN 'ÜRETİM'
                WHEN ORDER_ROW_CURRENCY = - 6
                    THEN 'SEVK'
                WHEN ORDER_ROW_CURRENCY = - 7
                    THEN 'EKSİK TESLİMAT'
                WHEN ORDER_ROW_CURRENCY = - 8
                    THEN 'FAZLA TESLİMAT'
                WHEN ORDER_ROW_CURRENCY = - 9
                    THEN 'İPTAL'
                WHEN ORDER_ROW_CURRENCY = - 10
                    THEN 'KAPATILDI (MANUEL)'
                END AS DURUM
        FROM catalystTest_1.ORDER_ROW ORDR
        LEFT JOIN catalystTest_product.PRODUCT AS P ON P.PRODUCT_ID = ORDR.PRODUCT_ID     
        WHERE ORDR.ORDER_ID=#arguments.ORDER_ID#       
     </cfquery>
      <cfset orderArr=arrayNew(1)>
        <cfloop query="getOrderRow">
             <cfset item=structNew()>
             <cfset item.PRODUCT_NAME=PRODUCT_NAME>
             <cfset item.QUANTITY=QUANTITY>
             <cfset item.PRICE=PRICE>
             <cfset item.PRICE_OTHER=PRICE_OTHER>
             <cfset item.UNIT=UNIT>
             <cfset item.TAX=TAX>
             <cfset item.NETTOTAL=NETTOTAL>
             <cfset item.OTHER_MONEY=OTHER_MONEY>
             <cfset item.OTHER_MONEY_VALUE=OTHER_MONEY_VALUE>
             <cfset item.DURUM=DURUM>
             <cfscript>
                arrayAppend(orderArr, item);
             </cfscript>
        </cfloop>
        <cfreturn Replace(SerializeJSON(orderArr),'//','')>
    </cffunction>
    <cffunction  name="get_product_content" access="remote" returntype="any" returnFormat="json" httpMethod="POST">
    <cfargument    name="chapter_id" default="" >
    <cfargument  name="product_id">
    <cfquery name="get_content" datasource="#dsn#">
        SELECT C.CHAPTER_ID,CONT_HEAD,CONT_BODY,CONT_SUMMARY 
        FROM catalystTest.CONTENT_RELATION AS CR,catalystTest.CONTENT AS C 
        WHERE C.CONTENT_ID=CR.CONTENT_ID AND CR.ACTION_TYPE_ID=#arguments.product_id# AND ACTION_TYPE='PRODUCT_ID'
        <cfif len(arguments.chapter_id)>
            AND C.CHAPTER_ID=#arguments.CHAPTER_ID #
        </cfif>        
    </cfquery>
    <cfset retArr=arrayNew(1)>
    <cfloop query="get_content">
        <cfscript>
            item=structNew();
            item.CHAPTER_ID=get_content.CHAPTER_ID;
            item.CONT_HEAD=get_content.CONT_HEAD;
            item.CONT_BODY=get_content.CONT_BODY;
            item.CONT_SUMMARY=get_content.CONT_SUMMARY;
            arrayAppend(retArr, item);
        </cfscript>
    </cfloop>
    <cfreturn Replace(SerializeJSON(retArr),'//','')>
    </cffunction>
    <cffunction  name="get_chapters" access="remote" returntype="any" returnFormat="json" httpMethod="POST">
        <cfquery name="get_chapterss" datasource="#dsn#">
            SELECT CHAPTER_ID,CHAPTER FROM catalystTest.CONTENT_CHAPTER WHERE CONTENTCAT_ID=6
        </cfquery>
        <cfset retArr=arrayNew(1)>
        <cfloop query="get_chapterss">
        <cfscript>
        item=structNew();
        item.CHAPTER_ID=CHAPTER_ID;
        item.CHAPTER=CHAPTER;
        arrayAppend(retArr, item);
        </cfscript>
        </cfloop>
        <cfreturn Replace(SerializeJSON(retArr),'//','')>
    </cffunction>
    <cffunction  name="get_assets" access="remote" returntype="any" returnFormat="json" httpMethod="POST">
        <cfargument  name="product_id">
        <cfquery name="get_p_assets" datasource="#dsn#">
            SELECT ASSET_FILE_NAME,
                ACTION_ID,
                ASSET_NAME,
                PROPERTY_ID,
                PRODUCT_ID,
                A.ASSETCAT_ID,
                AC.ASSETCAT_PATH,
                AC.ASSETCAT,
                AC.ASSETCAT_PATH + '/' + A.ASSET_FILE_NAME AS FULL_PATH
            FROM catalystTest.ASSET AS A
            LEFT JOIN catalystTest.ASSET_CAT AS AC ON A.ASSETCAT_ID = AC.ASSETCAT_ID
            WHERE MODULE_ID = 5
                AND A.ASSETCAT_ID = A.ASSETCAT_ID
                AND A.IS_INTERNET = 1
                AND IS_ACTIVE = 1
                AND ACTION_ID=#arguments.product_id#            
        </cfquery>
        <cfset retArr=arrayNew(1)>
        <cfloop query="get_p_assets">
            <cfscript>
                item=structNew();
                item.ASSET_FILE_NAME=ASSET_FILE_NAME;
                item.ASSET_NAME=ASSET_NAME;
                item.PROPERTY_ID=PROPERTY_ID;
                item.ASSETCAT_ID=ASSETCAT_ID;
                item.FULL_PATH=FULL_PATH;
                arrayAppend(retArr, item);
            </cfscript>
        </cfloop>
        <cfreturn Replace(SerializeJSON(retArr),'//','')>
    </cffunction>
    <cffunction  name="get_asset_cats" access="remote" returntype="any" returnFormat="json" httpMethod="POST">    
        <cfargument  name="asset_cat_id" default="">
        <cfquery name="get_cats" datasource="#dsn#">
            select ASSETCAT,ASSETCAT_ID from catalystTest.ASSET_CAT where 1=1 <cfif len(arguments.asset_cat_id)>and ASSETCAT_ID=#arguments.asset_cat_id#></cfif>
        </cfquery>
        <cfset retArr=arrayNew(1)>
        <cfloop query="get_cats">
            <cfscript>
                item=structNew();
                item.ASSETCAT=ASSETCAT;
                item.ASSETCAT_ID=ASSETCAT_ID;
                arrayAppend(retArr, item);
            </cfscript>
        </cfloop>
        <cfreturn Replace(SerializeJSON(retArr),'//','')>
    </cffunction>
    <cffunction  name="get_product_with_id" access="remote" returntype="any" returnFormat="json" httpMethod="POST">    
        <cfargument  name="product_id" default="">
        <cfargument  name="company_id" default="">
        <cfargument name="chart_partner_id">
            <cfquery name="get_product" datasource="#dsn#_product">
                SELECT * FROM PRODUCT WHERE 1=1 <cfif len(arguments.product_id)> PRODUCT_ID=#arguments.product_id#</cfif>
            </cfquery>
              <cfset returnValue=structNew()>
        
        
        <cfif len(arguments.company_id)>
        <cfquery name="isHvPriceList" datasource="#dsn#_1">
            SELECT PRICE_CATID FROM PRICE_CAT_EXCEPTIONS WHERE COMPANY_ID=#arguments.company_id# AND IS_DEFAULT=1 AND PURCHASE_SALES=1 
        </cfquery>
        <cfset priceLists=valueList(isHvPriceList.PRICE_CATID)>
        <cfelse>
         <cfset priceLists="0">
         </cfif>
         <cfset productArr=arrayNew(1)>
        <cfloop query="get_product">
        <cfset product = structNew()>
        <cfquery name="getProduct_images" datasource="#dsn#_product">
            SELECT * FROM PRODUCT_IMAGES WHERE PRODUCT_ID=#get_product.PRODUCT_ID# AND IS_INTERNET=1
        </cfquery>
        <cfset PRODUCT.IMAGE_COUNT =getProduct_images.RECORDCOUNT>
        <cfset imgArr=arrayNew(1)>
            <cfloop query="getProduct_images">
                <cfset img=structNew()>
                <cfset img.PATH=getProduct_images.PATH>
                <cfset img.NAME=getProduct_images.PRD_IMG_NAME>
                <cfset img.SIZE=getProduct_images.IMAGE_SIZE>
                <cfscript>
                arrayAppend(imgArr, img);
                </cfscript>
            </cfloop>
            <cfif priceLists neq 0 and listlen(priceLists)>
            <cfquery name="getproductPrice" datasource="#dsn#_1">
                SELECT PRICE,PRICE_KDV,IS_KDV,PRODUCT_ID,MONEY FROM catalystTest_1.PRICE WHERE PRICE_CATID IN(#priceLists#) and PRODUCT_ID =#get_product.PRODUCT_ID#
            </cfquery>
            <cfelse>
            <cfquery name="getproductPrice" datasource="#dsn#_product">
                SELECT PRICE,PRICE_KDV,MONEY FROM PRICE_STANDART WHERE PURCHASESALES=1 and PRODUCT_ID =#get_product.PRODUCT_ID#
            </cfquery>
            </cfif>           

            <cfscript>
                PR_PRODUCT=structNew();
                PR_PRODUCT.PRICE=getproductPrice.PRICE;
                PR_PRODUCT.PRICE_KDV=getproductPrice.PRICE_KDV;
                PR_PRODUCT.MONEY=getproductPrice.MONEY;
                PRODUCT.PRODUCT_PRICE=PR_PRODUCT;
                PRODUCT.PRODUCT_NAME=get_product.PRODUCT_NAME;
                PRODUCT.PRODUCT_CODE=get_product.PRODUCT_CODE;
                PRODUCT.PRODUCT_CODE_2=get_product.PRODUCT_CODE_2;
                PRODUCT.PRODUCT_ID=get_product.PRODUCT_ID;
                PRODUCT.PRODUCT_CATID=get_product.PRODUCT_CATID;
                PRODUCT.IMAGES=imgArr;
                arrayAppend(productArr, PRODUCT);
            </cfscript>
        </cfloop>
        <cfset returnValue.PRODUCT_LIST=productArr>
        <cfreturn Replace(SerializeJSON(returnValue),'//','')>
    </cffunction>
    <cffunction  name="get_cari_extre"access="remote" returntype="any" returnFormat="json" httpMethod="POST">    
    <cfargument  name="start_date">
    <cfargument  name="company_id"> 
        <cfquery name="get_devir" datasource="#dsn#">
        SELECT ACTION_NAME,ACTION_VALUE,ACTION_CURRENCY_ID,ACTION_DATE,FROM_CMP_ID,TO_CMP_ID 
        FROM catalystTest_#year(now())#_1.CARI_ROWS 
        where 1=1 and ( FROM_CMP_ID=#arguments.company_id# or TO_CMP_ID=#arguments.company_id#) AND ACTION_DATE<'#arguments.start_date#' ORDER BY ACTION_DATE
    </cfquery>
    <cfset devir_borc=0>
    <cfset devir_alacak=0>
    <cfset devir_bakiye=0>
    <cfset bakiye=0>
    <cfset borc=0>
    <cfset alacak=0>
    <cfloop query="get_devir">
        <cfif len(FROM_CMP_ID)>
            <cfset devir_alacak=devir_alacak+ACTION_VALUE>
        </cfif>
        <cfif len(TO_CMP_ID)>
            <cfset devir_borc=devir_borc+ACTION_VALUE>
        </cfif>
    </cfloop>
    <cfquery name="get_extre" datasource="#dsn#">
        SELECT ACTION_NAME,ACTION_VALUE,ACTION_CURRENCY_ID,ACTION_DATE,FROM_CMP_ID,TO_CMP_ID 
        FROM catalystTest_#year(now())#_1.CARI_ROWS where 1=1 and ( FROM_CMP_ID=#arguments.company_id# or TO_CMP_ID=#arguments.company_id#) and ACTION_DATE >='#arguments.start_date#'  ORDER BY ACTION_DATE
    </cfquery>
    <cfscript>
    item=structNew();
    item.devir_borc=NumberFormat(devir_borc,"0.00");
    item.devir_alacak=NumberFormat(devir_alacak,"0.00");
    devir_bakiye=devir_borc-devir_alacak;
    
    
    if(devir_bakiye<0){
        item.devir_durum="ALACAKLI";
        item.devir_bakiye=NumberFormat(devir_bakiye*-1,"0.00");}
    if(devir_bakiye>0){
        item.devir_durum="BORÇLU";
        item.devir_bakiye=NumberFormat(devir_bakiye,"0.00");
    }    
    </cfscript>
    <cfset arr=arrayNew(1)>
    <cfset bakiye=devir_bakiye>
    <cfset borc=devir_borc>
    <cfset alacak=devir_alacak>
    <cfif bakiye lt 0 >
   <cfset  bakiye=bakiye*-1>
    </cfif>
    <cfloop query="get_extre">
        <cfscript>
            bitem=structNew();
            bitem.ACTION_NAME=ACTION_NAME;
            bitem.ACTION_DATE=dateformat(ACTION_DATE,"dd/mm/yyyy");
            if(len(FROM_CMP_ID)){
                bitem.rborc=0;
                bitem.ralacak=NumberFormat(ACTION_VALUE,"0.00");
                //bakiye=bakiye-ACTION_VALUE;
                alacak=alacak+ACTION_VALUE;
                //bitem.rbakiye=bakiye-bitem.ralacak;
                bakiye=bakiye+bitem.ralacak;
                bitem.rbakiye=NumberFormat(bakiye,"0.00");
            }   
            if(len(TO_CMP_ID)){
                bitem.ralacak=0;
                bitem.rborc=NumberFormat(ACTION_VALUE,"0.00");
               // bakiye=bakiye+ACTION_VALUE;
                //bitem.rbakiye=bakiye-ACTION_VALUE;
                borc=borc+ACTION_VALUE;
                bakiye=bakiye-bitem.rborc;
                bitem.rbakiye=NumberFormat(bakiye,"0.00");
            }
            arrayAppend(arr, bitem);
        </cfscript>
        
    </cfloop>

    <cfset item.ACTION_LIST=arr>
        <cfscript>
        item.borc=NumberFormat(borc,"0.00");
        item.alacak=NumberFormat(alacak,"0.00");
        item.bakiye=NumberFormat(borc-alacak,"0.00");
        
        if(item.bakiye<0){
        item.durum="BORCLU";
        item.bakiye=NumberFormat(item.bakiye*-1,"0.00");}
        if(item.bakiye>0){
        item.durum="ALACAKLI";
        item.bakiye=NumberFormat(item.bakiye,"0.00");
    } 
</cfscript>
    <cfreturn Replace(SerializeJSON(item),'//','')>
    </cffunction>
    <cffunction  name="get_active_sepet" access="remote" returntype="any" returnFormat="json" httpMethod="POST">
        <cfargument  name="company_id">
        <cfargument  name="partner_id">
        <cfquery name="getSepet" datasource="#dsn#">
            SELECT CSB.*,P.PRODUCT_NAME,P.PRODUCT_CODE_2,PU.MAIN_UNIT FROM COMPANY_SEPET_B2B AS CSB,
            #dsn#_product.PRODUCT AS P,
            #dsn#_product.PRODUCT_UNIT AS PU
             WHERE CSB.COMPANY_ID=#arguments.company_id# and CSB.IS_ACTIVE=1 AND P.PRODUCT_ID=CSB.PRODUCT_ID and PU.PRODUCT_ID=CSB.PRODUCT_ID and CSB.PARTNER_ID=#arguments.partner_id#
        </cfquery>
        <cfset sepet = structNew()>
        <cfset sepet.recordcount=getSepet.recordcount>
        <cfset arr=arrayNew(1)>        
        <cfloop query="getSepet">
        <cfquery name="getImages" datasource="#dsn#_product">
            SELECT * FROM PRODUCT_IMAGES WHERE PRODUCT_ID=#getSepet.PRODUCT_ID# AND IS_INTERNET=1
        </cfquery>
        <cfset imgArr= arrayNew(1)>
        <cfloop query="getImages">
            <cfscript>
                resitem=structNew();
                resitem.PATH=getImages.PATH;
                  resitem.NAME=getImages.PRD_IMG_NAME;
                 resitem.SIZE=getImages.IMAGE_SIZE;
                 arrayAppend(imgArr, resitem);
            </cfscript>
        </cfloop>
            <cfscript>
                item=structNew();
                item.image_count=getImages.recordcount;
                item.PRODUCT_ID=PRODUCT_ID;
                item.AMOUNT=AMOUNT;
                item.PRICE=PRICE;
                item.UNIT=UNIT;
                item.ROW_ID=ID;
                item.PRODUCT_NAME=PRODUCT_NAME;
                item.PRODUCT_CODE_2=PRODUCT_CODE_2;
                item.UNIT=MAIN_UNIT;
                item.images=imgArr;
                arrayAppend(arr, item);
            </cfscript>
        </cfloop>
        <cfset sepet.sepetim=arr>
        <cfreturn Replace(SerializeJSON(sepet),'//','')>
    </cffunction>
    <cffunction  name="sepete_ekle" access="remote" returntype="numeric"  httpMethod="POST" returnFormat="json">
        <cfargument  name="product_id">
        <cfargument  name="company_id">
        <cfargument  name="partner_id">
        <cfargument  name="amount">
        <cfargument  name="price">
        <cfargument  name="unit" default="">
        <cfquery name="insert_sepet" datasource="#dsn#" result="res">
            INSERT INTO COMPANY_SEPET_B2B(COMPANY_ID,PRODUCT_ID,AMOUNT,PRICE,UNIT,IS_ACTIVE,RECORD_DATE,PARTNER_ID)
            VALUES(#arguments.company_id#,#arguments.product_id#,#arguments.amount#,#arguments.price#,'#arguments.unit#',1,#now()#,#arguments.partner_id#)
        </cfquery>
        <cfreturn Replace(SerializeJSON(res.IDENTITYCOL),'//','') >
    </cffunction>
        <cffunction  name="sepet_satir_guncelle" access="remote" returntype="any" returnFormat="json" httpMethod="POST">
            <cfargument  name="row_id">
            <cfargument  name="amount" required="false">
            <cfargument  name="option" default="1">
            <cfset say=0>
            <cfif option eq 1>
                <cfquery name="updSepetRow" datasource="#dsn#" result="res">
                    UPDATE COMPANY_SEPET_B2B SET AMOUNT=#arguments.amount# where ID=#arguments.row_id#
                </cfquery>
                <cfset say=res.RECORDCOUNT>
            </cfif>
            <cfif option eq 0>
                <cfquery name="updSepetRow" datasource="#dsn#" result="res">
                    DELETE FROM COMPANY_SEPET_B2B where ID=#arguments.row_id#
                </cfquery>
                <cfset say=res.RECORDCOUNT>
            </cfif>
            <cfreturn Replace(SerializeJSON(say),'//','') >
            
        </cffunction>
        <cffunction  name="get_brand_with_cat" access="remote" returntype="any" returnFormat="json" httpMethod="POST">
            <cfargument  name="catid">
            <cfquery name="getBrands" datasource="#dsn#">
                SELECT DISTINCT PB.BRAND_NAME,PB.BRAND_ID FROM catalystTest_product.PRODUCT_BRANDS AS PB,catalystTest_product.PRODUCT AS P WHERE PB.BRAND_ID=P.BRAND_ID AND P.PRODUCT_CATID=#arguments.catid#
            </cfquery>
            <cfset arr=arrayNew(1)>     
            <cfloop query="getBrands">
                <cfscript>
                    item=structNew();
                    item.BRAND_ID=BRAND_ID;
                    item.BRAND_NAME=BRAND_NAME;
                    arrayAppend(arr, item);
                </cfscript>
            </cfloop>
            <cfreturn Replace(SerializeJSON(arr),'//','')>
        </cffunction>
        <cffunction  name="get_active_chart" access="remote" returntype="any" returnFormat="json" httpMethod="POST">    
        
        <cfargument  name="company_id" default="">
        <cfargument name="partner_id">
            <cfquery name="get_product" datasource="#dsn#_product">
                SELECT * FROM PRODUCT WHERE 1=1 and PRODUCT_ID IN (SELECT PRODUCT_ID FROM #DSN#.COMPANY_SEPET_B2B WHERE PARTNER_ID =#arguments.partner_id# and IS_ACTIVE=1 )
            </cfquery>
              <cfset returnValue=structNew()>
        
        
        <cfif len(arguments.company_id)>
        <cfquery name="isHvPriceList" datasource="#dsn#_1">
            SELECT PRICE_CATID FROM PRICE_CAT_EXCEPTIONS WHERE COMPANY_ID=#arguments.company_id# AND IS_DEFAULT=1 AND PURCHASE_SALES=1 
        </cfquery>
        <cfset priceLists=valueList(isHvPriceList.PRICE_CATID)>
        <cfelse>
         <cfset priceLists="0">
         </cfif>
         <cfset productArr=arrayNew(1)>
        <cfloop query="get_product">
        <cfset product = structNew()>
        <cfquery name="getProduct_images" datasource="#dsn#_product">
            SELECT * FROM PRODUCT_IMAGES WHERE PRODUCT_ID=#get_product.PRODUCT_ID# AND IS_INTERNET=1
        </cfquery>
        <cfset PRODUCT.IMAGE_COUNT =getProduct_images.RECORDCOUNT>
        <cfset imgArr=arrayNew(1)>
            <cfloop query="getProduct_images">
                <cfset img=structNew()>
                <cfset img.PATH=getProduct_images.PATH>
                <cfset img.NAME=getProduct_images.PRD_IMG_NAME>
                <cfset img.SIZE=getProduct_images.IMAGE_SIZE>
                <cfscript>
                arrayAppend(imgArr, img);
                </cfscript>
            </cfloop>
            <cfif priceLists neq 0 and listlen(priceLists)>
            <cfquery name="getproductPrice" datasource="#dsn#_1">
                SELECT PRICE,PRICE_KDV,IS_KDV,PRODUCT_ID,MONEY FROM catalystTest_1.PRICE WHERE PRICE_CATID IN(#priceLists#) and PRODUCT_ID =#get_product.PRODUCT_ID#
            </cfquery>
            <cfelse>
            <cfquery name="getproductPrice" datasource="#dsn#_product">
                SELECT PRICE,PRICE_KDV,MONEY FROM PRICE_STANDART WHERE PURCHASESALES=1 and PRODUCT_ID =#get_product.PRODUCT_ID#
            </cfquery>
            </cfif>           

            <cfscript>
                PR_PRODUCT=structNew();
                PR_PRODUCT.PRICE=getproductPrice.PRICE;
                PR_PRODUCT.PRICE_KDV=getproductPrice.PRICE_KDV;
                PR_PRODUCT.MONEY=getproductPrice.MONEY;
                PRODUCT.PRODUCT_PRICE=PR_PRODUCT;
                PRODUCT.PRODUCT_NAME=get_product.PRODUCT_NAME;
                PRODUCT.PRODUCT_CODE=get_product.PRODUCT_CODE;
                PRODUCT.PRODUCT_CODE_2=get_product.PRODUCT_CODE_2;
                PRODUCT.PRODUCT_ID=get_product.PRODUCT_ID;
                PRODUCT.PRODUCT_CATID=get_product.PRODUCT_CATID;
                PRODUCT.IMAGES=imgArr;
                arrayAppend(productArr, PRODUCT);
            </cfscript>
        </cfloop>
        <cfset returnValue.PRODUCT_LIST=productArr>
        <cfreturn Replace(SerializeJSON(returnValue),'//','')>
    </cffunction>
    <cffunction  name="get_vision_types" access="remote" returntype="any" returnFormat="json" httpMethod="POST"> 
        <cfquery name="getVisions" datasource="#dsn#">
            select VISION_TYPE_ID,VISION_TYPE_NAME from catalystTest.SETUP_VISION_TYPE
        </cfquery>
        <cfset arr=arrayNew(1)>
        <cfloop query="getVisions">
            <cfscript>
                item=structNew();
                item.VISION_TYPE_ID=VISION_TYPE_ID;
                item.VISION_TYPE_NAME=VISION_TYPE_NAME;
                arrayAppend(arr, item);
            </cfscript>
        </cfloop>
        <cfreturn Replace(SerializeJSON(arr),'//','')>
    </cffunction>
    <cffunction  name="get_product_vision" access="remote" returntype="any" returnFormat="json" httpMethod="POST"> 
        <cfargument  name="vison_type_id">
        
         <cfargument  name="company_id" default="">
        <cfargument name="partner_id">
            <cfquery name="get_product" datasource="#dsn#_product">
                SELECT * FROM PRODUCT WHERE 1=1 and PRODUCT_ID IN (SELECT PRODUCT_ID FROM catalystTest_1.PRODUCT_VISION where VISION_TYPE LIKE '%#arguments.vison_type_id#%' )
            </cfquery>
              <cfset returnValue=structNew()>
        
        
        <cfif len(arguments.company_id)>
        <cfquery name="isHvPriceList" datasource="#dsn#_1">
            SELECT PRICE_CATID FROM PRICE_CAT_EXCEPTIONS WHERE COMPANY_ID=#arguments.company_id# AND IS_DEFAULT=1 AND PURCHASE_SALES=1 
        </cfquery>
        <cfset priceLists=valueList(isHvPriceList.PRICE_CATID)>
        <cfelse>
         <cfset priceLists="0">
         </cfif>
         <cfset productArr=arrayNew(1)>
        <cfloop query="get_product">
        <cfset product = structNew()>
        <cfquery name="getProduct_images" datasource="#dsn#_product">
            SELECT * FROM PRODUCT_IMAGES WHERE PRODUCT_ID=#get_product.PRODUCT_ID# AND IS_INTERNET=1
        </cfquery>
        <cfset PRODUCT.IMAGE_COUNT =getProduct_images.RECORDCOUNT>
        <cfset imgArr=arrayNew(1)>
            <cfloop query="getProduct_images">
                <cfset img=structNew()>
                <cfset img.PATH=getProduct_images.PATH>
                <cfset img.NAME=getProduct_images.PRD_IMG_NAME>
                <cfset img.SIZE=getProduct_images.IMAGE_SIZE>
                <cfscript>
                arrayAppend(imgArr, img);
                </cfscript>
            </cfloop>
            <cfif priceLists neq 0 and listlen(priceLists)>
            <cfquery name="getproductPrice" datasource="#dsn#_1">
                SELECT PRICE,PRICE_KDV,IS_KDV,PRODUCT_ID,MONEY FROM catalystTest_1.PRICE WHERE PRICE_CATID IN(#priceLists#) and PRODUCT_ID =#get_product.PRODUCT_ID#
            </cfquery>
            <cfelse>
            <cfquery name="getproductPrice" datasource="#dsn#_product">
                SELECT PRICE,PRICE_KDV,MONEY FROM PRICE_STANDART WHERE PURCHASESALES=1 and PRODUCT_ID =#get_product.PRODUCT_ID#
            </cfquery>
            </cfif>           

            <cfscript>
                PR_PRODUCT=structNew();
                PR_PRODUCT.PRICE=getproductPrice.PRICE;
                PR_PRODUCT.PRICE_KDV=getproductPrice.PRICE_KDV;
                PR_PRODUCT.MONEY=getproductPrice.MONEY;
                PRODUCT.PRODUCT_PRICE=PR_PRODUCT;
                PRODUCT.PRODUCT_NAME=get_product.PRODUCT_NAME;
                PRODUCT.PRODUCT_CODE=get_product.PRODUCT_CODE;
                PRODUCT.PRODUCT_CODE_2=get_product.PRODUCT_CODE_2;
                PRODUCT.PRODUCT_ID=get_product.PRODUCT_ID;
                PRODUCT.PRODUCT_CATID=get_product.PRODUCT_CATID;
                PRODUCT.IMAGES=imgArr;
                arrayAppend(productArr, PRODUCT);
            </cfscript>
        </cfloop>
        <cfset returnValue.PRODUCT_LIST=productArr>
        <cfreturn Replace(SerializeJSON(returnValue),'//','')>
    </cffunction>
</cfcomponent>