--CUBE_MKT3_MONTH
----
SELECT
      O.OUTLET_PBI
    , P.NAME CABANG
    , A.TAHUN
    , A.BULAN
    , R.NAME REGION
    , A.REFEREE_ID
    , C.NAME                REFEREE
    , C.COMPANY_SUBGROUP_ID SUBGROUP_ID
    , CS.NAME               SUBGROUP
    , C.COMPANY_GROUP_ID    GROUP_ID
    , CG.NAME               COMPANY_GROUP
    , CC.CC_GROUP_ID
    , CCG.NAME CONTRACT_GROUP
    , CC.CT_GROUP_ID
    , CCT.NAME CONTRACT_TYPE
    , A.DOCTOR_ID
    , DECODE(A.DOCTOR_ID,'00000','APD-CS',D.NAME)                                                      DOCTOR
    , DECODE(A.DOCTOR_ID,'00000','N/A',D.SPECIALTY_ID)                                                    SPECIALTY
    , DECODE(A.DOCTOR_ID,'00000','N/A',D.ABBR)                                                         SPECIALTY_ABBR
    , DECODE(A.DOCTOR_ID,'00000','N/A',d.specialty_group_ID)                                                         SPECIALTY_group
    , DECODE(CC.CC_GROUP_ID,'10', DECODE(A.DOCTOR_ID, '00000','01','02'),CC.CC_GROUP_ID)               SEGMEN_ID
    , DECODE(CC.CC_GROUP_ID,'10', DECODE(D.NAME, 'APD-CS','APD-CS', '-','APD-CS', 'APD'),CCG.NAME)     SEGMEN
    , DECODE(CC.CC_GROUP_ID,'10', DECODE(D.NAME, 'APD-CS','APD-CS', '-','APD-CS', 'APD'),CCG.SEGMENT)  SEGMENTASI_MKT
    , A.PATIENT                                                                                        VISIT_PATIENT
    , A.BRUTO
    , A.DISKON
    , A.NETTO
    , A.RETUR
    , A.NETTO - A.RETUR TOTAL
    , A.OUTLET_ID
    , MO.NAME                 OUTLET
    , UPPER(IP.PROVINCE_NAME) PROVINCE_NAME
    , OL.LONGITUDE
    , OL.LATTITUDE
    , DECODE(TO_CHAR(SYSDATE,'YYYY'),A.TAHUN, A.NETTO   - A.RETUR, 0) TAHUN_0
    , DECODE(TO_CHAR(SYSDATE,'YYYY')-1,A.TAHUN, A.NETTO - A.RETUR, 0) TAHUN_1
    , DECODE(TO_CHAR(SYSDATE,'YYYY')-2,A.TAHUN, A.NETTO - A.RETUR, 0) TAHUN_2
    , DECODE(TO_CHAR(SYSDATE,'YYYY')-3,A.TAHUN, A.NETTO - A.RETUR, 0) TAHUN_3
    , DECODE(TO_CHAR(SYSDATE,'YYYY')-4,A.TAHUN, A.NETTO - A.RETUR, 0) TAHUN_4
    , DECODE(TO_CHAR(SYSDATE,'YYYY')-5,A.TAHUN, A.NETTO - A.RETUR, 0) TAHUN_5
	, DECODE(TO_CHAR(SYSDATE,'YYYY'),A.TAHUN, A.PATIENT, 0) VISIT_TAHUN_0
    , DECODE(TO_CHAR(SYSDATE,'YYYY')-1,A.TAHUN, A.PATIENT, 0) VISIT_TAHUN_1
    , DECODE(TO_CHAR(SYSDATE,'YYYY')-2,A.TAHUN, A.PATIENT, 0) VISIT_TAHUN_2
    , DECODE(TO_CHAR(SYSDATE,'YYYY')-3,A.TAHUN, A.PATIENT, 0) VISIT_TAHUN_3
    , DECODE(TO_CHAR(SYSDATE,'YYYY')-4,A.TAHUN, A.PATIENT, 0) VISIT_TAHUN_4
    , DECODE(TO_CHAR(SYSDATE,'YYYY')-5,A.TAHUN, A.PATIENT, 0) VISIT_TAHUN_5
  FROM
      SALES3MONTH_ARIS        A
    , OUTLET_PBI_DET_ARIS     O
    , OUTLET_PBI_ARIS         P
    , TBL_REGION_ERP          R
    , COMPANY                 C
    , COMPANY_SUBGROUP        CS
    , COMPANY_GROUP           CG
    , COMPANY_CONTRACT        CC
    , TBL_COMPANY_CONTRACT_GROUP  CCG
    , COMPANY_CONTRACT_TYPE   CCT
    , DOCTOR_ARIS                  D
    , OUTLET                  MO
    , TBL_OUTLET_LOCATION     OL
    , TBL_ID_PROVINCE         IP
  WHERE
      A.OUTLET_ID               = O.OUTLET_ID(+)
      AND O.OUTLET_PBI          = P.OUTLET_PBI(+)
      AND P.REGION_ID           = R.PBI_REGION_ID(+)
      AND A.REFEREE_ID          = C.COMPANY_ID(+)
      AND C.COMPANY_SUBGROUP_ID = CS.COMPANY_SUBGROUP_ID(+)
      AND C.COMPANY_GROUP_ID    = CG.COMPANY_GROUP_ID(+)
      AND A.REFEREE_ID          = CC.COMPANY_ID(+)
      AND CC.CC_GROUP_ID        = CCG.CC_GROUP_ID(+)
      AND CC.CT_GROUP_ID        = CCT.CT_GROUP_ID(+)
      AND A.DOCTOR_ID           = D.DOCTOR_ID(+)
      AND A.OUTLET_ID           = MO.OUTLET_ID(+)
      AND A.OUTLET_ID           = OL.OUTLET_ID(+)
      AND OL.PROVINCE_ID        = IP.PROVINCE_ID(+)
      AND A.TAHUN               > '2016';