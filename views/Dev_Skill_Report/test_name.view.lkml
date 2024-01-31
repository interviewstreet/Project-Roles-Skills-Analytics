
view: test_name {
  derived_table: {
    sql: -- ######## Tests with Specific Skills Mentioned in Names ########
                 with ever_paid_accounts as
                  (with ever_paid as
                  (

                  select distinct company_plan_changelog_company_id as company_id from hr_analytics.global.fact_recruit_company_plan_changelog
                          where company_plan_changelog_plan_name not in ('free', 'trial', 'user-freemium-interviews-v1','locked') -- # ever paid customers (This table has data only of companies created post 2018)
                  ---- ^ Above query returns ever paid customer who joined 2018 onwards
                  union
                  select distinct company_id from hr_analytics.global.dim_recruit_company rc
                    where company_stripe_plan not in ('free', 'trial','user-freemium-interviews-v1','locked')
                    and company_type not in ('free', 'trial','locked')  -- # using this logic to cover paid customers who are not covered in the above logic [company_plan_changelog table]

                    ---- ^ currently active customers being missed out on prev query (2018 onwards set)
                    )

              Select rc.*
              from
             hr_analytics.global.dim_recruit_company rc  inner join ever_paid ep on ep.company_id=rc.company_id

              inner join hr_analytics.global.dim_recruit_user ru on ru.user_id=rc.company_owner  ---- filter internal test accounts created by HR users themselves
              and lower(ru.user_email) not like '%@hackerrank.com%'
              and lower(ru.user_email) not like '%@hackerrank.net%'
              and lower(ru.user_email) not like '%@interviewstreet.com%'
              and lower(ru.user_email) not like '%sandbox17e2d93e4afe44ea889d89aadf6d413f.mailgun.org%'
              and lower(ru.user_email) not like '%strongqa.com%'

              where lower(company_name) not in ('none', ' ', 'hackerrank','interviewstreet') --- Filter internal accounts based on company names
              and lower(company_name) not like '%hackerrank%'
              and lower(company_name) not like '%hacker%rank%'
              and lower(company_name) not like '%interviewstreet%'
              and lower(company_name) not like '%interview%street%'
              and company_name not like 'Company%'

              --and rc.company_id not in (65904,107170) --- exclude tcs  lnd accounts
              --and rc.company_id not in (106529,46242) --- exclude internal test setters
              )
              select
      ra.starttime as starttime,
      rt.company_id as company_id,

             case when (lower(rt.name) like '%machine learning%'
                  or lower(rt.name) like '%data scientist%'
                  or lower(rt.name) like '%data science%'
                  or lower(rt.name) like '%deep learning%'
                  or lower(rt.name) like '%mle%'
                  or lower(rt.name) like '%ai%'
                  or lower(rt.name) like '%artificial%'
                  or lower(rt.name) like '%prompt engineer%'
                  or lower(rt.name) like '%llm%')
                  then 'machine-learning-ai-deep-learning'
           when lower(rt.name) like '%linux%' then 'linux'
           when lower(rt.name) like '%bash%' then 'bash'
           when (lower(rt.name) like '%react%native%' or lower(rt.name) like '%reactnative%')then 'react-native'
           when (lower(rt.name) like '%react%' and lower(rt.name) not like '%react%native%' and lower(rt.name) not like '%react%native%') then 'react'
           when (lower(rt.name) like '%systemdesign%'or lower(rt.name) like '%system%design%')then 'systemdesign'
           when lower(rt.name) like '%aws%' then 'AWS'
           when lower(rt.name) like '%android%' then 'android'
           when (lower(rt.name) like '%restapi%' or lower(rt.name) like '%rest%api%') then 'Rest-API'
           when (lower(rt.name) like '%nodejs%' or lower(rt.name) like '%node%js%') then 'node-js'
           when lower(rt.name) like '%cloud%computing%' then 'cloud_computing'
           when (lower(rt.name) like '%problemsolving%' or lower(rt.name) like '%problem%solving%') then 'problem-solving'
           when (lower(rt.name) like '%expressjs%' or lower(rt.name) like '%express%js%') then 'express.js'
           when lower(rt.name) like '%angular%' then 'angular'
           when (lower(rt.name) like '%data%visualization%' or lower(rt.name) like '%datavisualization%' or lower(rt.name) like '%datavisualisation%' or lower(rt.name) like '%data%visualisation%') then 'data-visualization'
           when (lower(rt.name) like '%data%modeling%' or lower(rt.name) like '%datamodeling%') then 'data-modeling'
           when (lower(rt.name) like '%data%wrangling%' or lower(rt.name) like '%datawrangling%') then 'data-wrangling'
          else 'others'
          end as language,

      count(distinct ra.id) as total_attempt_count,
      count(distinct rt.id) as active_tests,
      count(distinct ever_paid_accounts.company_id) as active_customers

      from recruit_rs_replica.recruit.recruit_tests rt
      INNER JOIN ever_paid_accounts
      ON rt.company_id = ever_paid_accounts.company_id
          and rt.state = 1   -- Considered only Live Tests (Confirm if archived adn demo are also to be included)
          and rt.draft = 0   -- Considered only published Tests
          and (
              lower(rt.name) like '%machine learning%'
               or lower(rt.name) like '%data scientist%'
               or lower(rt.name) like '%data science%'
               or lower(rt.name) like '%deep learning%'
               or lower(rt.name) like '%mle%'
               or lower(rt.name) like '%ai%'
               or lower(rt.name) like '%artificial%'
               or lower(rt.name) like '%linux%'
               or lower(rt.name) like '%bash%'
                   or lower(rt.name) like '%prompt engineer%'
                   or lower(rt.name) like '%llm%'
                  or lower(rt.name) like '%java%script%'
                  or lower(rt.name) like '%javascript%'
           or lower(rt.name) like '%react%native%'
          or lower(rt.name) like '%reactnative%'
           or lower(rt.name) like '%react%'
          or lower(rt.name)  like '%react%native%'
          or lower(rt.name)  like '%react%native%'
           or lower(rt.name) like '%systemdesign%'
          or lower(rt.name) like '%system%design%'
           or lower(rt.name) like '%aws%'
           or lower(rt.name) like '%android%'
                  or lower(rt.name) like '%restapi%'
                  or lower(rt.name) like '%rest%api%'
                  or lower(rt.name) like '%nodejs%'
                  or lower(rt.name) like '%node%js%'
                  or lower(rt.name) like '%cloud%computing%'
                  or lower(rt.name) like '%problemsolving%'
                  or lower(rt.name) like '%problem%solving%'
                  or lower(rt.name) like '%expressjs%'
                  or lower(rt.name) like '%express%js%'
                  or lower(rt.name) like '%angular%'
                  or lower(rt.name) like '%data%visualization%'
                  or lower(rt.name) like '%datavisualization%'
                  or lower(rt.name) like '%datavisualisation%'
                  or lower(rt.name) like '%data%visualisation%'
                  or lower(rt.name) like '%data%modeling%'
                  or lower(rt.name) like '%datamodeling%'
                  or lower(rt.name) like '%data%wrangling%'
                  or lower(rt.name) like '%datawrangling%'
               )
      inner join recruit_rs_replica.recruit.recruit_attempts ra
          on rt.id = ra.tid
      inner join recruit_rs_replica.recruit.recruit_solves rs
      on rs.aid = ra.id
and rs.qid in
(415716,1429532,663019,804126,127584,161103,185571,932388,1095583,1096995,1116648,1389666,1173912,1181784,307703,1269891,1275531,1288259,432110,1324804,507502,1473146,1058868,1089072,1100904,216042,533019,573615,581143,1479603,1137362,250317,433457,1429529,241340,724354,730998,1275524,999773,1249571,1244356,526858,617281,761973,919329,619917,780897,794333,763815,781931,932081,834027,1043342,1076386,204497,797864,1197793,1210345,1046611,1163414,1182098,1194966,1195354,1230182,1230754,1230818,302941,318569,320493,1321977,1326053,1335117,1338625,1387037,998334,1137693,1177849,479504,806750,800486,900026,915742,1089205,1100745,1041700,1043124,161023,1197251,968272,1201735,1201739,553141,1117060,1118536,685488,1162200,1161928,1174192,1182104,1162284,355108,373100,1305980,969907,1369736,1387036,417442,418082,132088,665777,138976,161850,1137670,222929,1275514,466965,1445841,222935,185576,1300988,795930,408423,1009993,1202344,1221288,1249344,618610,1254008,347979,1325531,1326035,1369735,1382211,645316,526850,592986,1442118,788003,614089,757889,807881,159197,803928,842965,864952,879036,995515,999755,1203061,159958,569360,1208222,1230190,1230194,685663,730991,1308429,1342297,1139221,1192753,1192777,660671,660939,884146,894638,1089089,111168,127140,127576,1112616,1182096,999752,307515,185563,1154671,1177851,1181771,1182099,900732,1196031,1196207,931544,946284,927507,984379,1387930,111730,481761,321536,343156,359532,113718,1479602,686465,724357,1089076,185558,222918,1231054,554083,1096462,222917,230625,1278301,1465425,1467185,1494601,296164,296820,451047,1201888,324199,1058953,472367,333951,1365991,1384735,338306,356642,532054,391998,561430,1405686,890473,902477,763147,1067262,1196833,1213081,1235501,777681,791413,807753,1182102,1200854,1230098,296977,312517,341725,1334969,712515,730995,1010954,1161881,1161905,1191869,1192769,463756,1436124,111173,1005176,1019776,1040888,1043064,1185711,1196511,1196883,1201143,1203791,230626,1096991,1100907,1379454,1387042,519241,527749,1140140,246731,661428,1275495,1275515,1320863,462674,992455,1469414,731001,1071552,1095584,1100816,1100932,193806,549551,1100750,1118586,246729,262381,1253861,1278653,1251014,362021,432913,1387041,718154,730994,284260,1276132,795370,463751,999757,1194328,1201628,1227504,1468911,320807,1469419,334943,359511,1321867,1324119,1386299,1400043,1043270,573182,156877,898648,1230189,898557,1182106,1192814,792293,1201734,1212994,839037,847685,569444,724359,749431,1182101,1192693,1193957,391628,477128,1444428,838246,887826,890474,894822,127473,1092693,1112613,127852,1174132,306091,1043340,684760,754152,1141071,1162215,1182107,908940,1208195,241338,1354422,1384726,1275559,1294763,321524,1467178,1384740,730537,203142,1481647,1494603,1096842,1100746,1111794,1131690,1254913,463769,265920,725750,293568,1277500,1296940,508759,1224948,1230092,1239652,1253924,318335,1243295,618466,1353339,1386311,1407183,664630,554558,616680,620840,640260,600278,982601,791415,798567,817719,835979,880763,890615,818056,843424,1201629,1201737,1202381,136582,157962,1163262,1172218,1177838,1203106,1230186,312525,314749,587908,1300029,724559,754639,1182113,1188929,432408,823322,841058,894110,1076177,1100753,1100909,997116,1019800,1162435,1162707,1203079,123263,241354,287482,311282,1089079,1105639,1361434,127858,433934,1093078,1279249,255044,463746,1255856,1275560,463754,472366,425531,425599,1463673,472211,1470786,504995,1206316,1442111,1443795,1374784,1248964,320475,1479599,1401213,519243,554079,558359,1071624,561215,1480699,1485835,589374,1235499,932257,1251555,603776,792367,818199,335450,829903,835795,890299,896287,795849,607821,887112,865844,115611,1023407,1034575,533016,1172730,1182118,1192162,1201630,1201754,281097,342545,587592,588740,1342017,670615,730443,954058,1010814,136581,418844,902478,1177836,304751,751524,1201619,1203023,931584,1209007,260722,296878,1089207,1270391,127554,528185,328576,443606,480206,1305768,685661,1083660,1239910,558451,1097074,1100874,1139206,1267290,443605,730766,220636,1255832,794694,1201620,1239879,1255828,1251551,1040889,1321847,314442,1389615,620616,553142,641924,1444486,794551,832719,622797,806745,818205,829077,884145,827372,116387,1005103,1019351,1023254,1067450,1194105,1230185,1230205,1238349,503252,1196510,1201622,294409,716263,1383725,1384733,756803,1004874,1010714,1182105,432108,1467184,607483,617315,880770,1100717,161180,1119256,1173844,1174180,1019784,1020992,1038680,1043452,314967,723576,1182095,1100963,1111787,1126891,1275231,1278299,1279255,557637,132318,325544,347672,1372264,1154654,1251693,1256029,1275533,250500,308704,685489,1387288,198652,203088,716477,1300028,1271322,417443,1201736,319971,603694,588403,1481653,1494605,622594,1332723,643142,1075512,1417309,1005013,1089208,1429553,1096992,898797,1258595,645572,645584,1459330,623265,804121,830141,833913,834152,1201625,1202469,1235469,1235493,1239365,1192778,350413,1361541,1376357,999750,1162137,612791,804130,836062,1076301,1100881,145108,159896,242239,277471,1022072,722784,754640,1151679,1162947,1190219,1202571,246726,1100859,1329486,1122867,113714,482837,1105338,1116662,222914,1269892,1277280,1277848,1467186,463595,1230914,588397,1489210,1238382,1251076,1254906,1467183,1479633,672181,1395159,667682,1400264,533802,208327,215879,573598,984781,991257,723522,730562,1235523,749426,314302,998177,1004869,1020961,610044,622296,1020985,1043321,1429546,1443782,883961,806336,848128,1043291,1076518,1078502,203089,1201637,160022,1177854,1201638,1211618,311485,1472124,1386309,1162825,1425808,621159,843154,916134,116345,1083501,1100261,1162100,1162136,1162208,1187516,1019100,1163007,1182275,898652,1191695,1203239,940203,1329446,1089215,1116675,1375294,111178,339724,403762,1321940,1324128,1467182,1369728,1471362,1480698,1494598,722813,1100748,1236854,575081,132426,589059,1134950,1154410,1249341,1277510,417441,466953,731550,295396,1266284,1222175,408479,794690,1230100,322571,617426,1043057,1255831,353083,373099,1400355,1429534,925217,804731,820075,887827,895679,645397,806741,789884,879017,886173,828460,838272,111171,1019783,1022019,1043394,1083670,1201621,1238841,1241709,1189890,1192770,1195190,1195202,595244,1306065,1321825,1326049,730771,1384725,1017206,136713,145109,1141005,1172645,1174177,1192773,463872,471944,898650,111169,1094513,1096985,1100921,1115124,1157208,242235,722840,317843,1186395,1201623,983416,932156,1091335,1300034,1320810,1334682,1122903,1324794,1394506,123494,127562,1300031,380512,1326020,1326036,1463634,1384724,681749,724561,1096984,1097500,1100752,192431,193807,1481359,686470,1117130,1162090,1290121,1461157,1463669,1256770,287480,230627,313920,754386,1211503,1277408,1230080,1001877,1002897,471387,321307,1058981,1445483,1325543,603696,334058,1463675,622264,563298,798031,616889,835915,991413,884135,884143,885635,898843,655669,798977,804125,762900,830164,838284,835964,998335,1043047,1043335,1040950,1058750,1061934,1179666,1182094,1188006,1195850,1230810,287481,322021,1329429,1369729,1163293,1190221,1463676,645911,169104,303479,1016976,1022796,1032696,923692,985271,1100755,1100995,1106495,1118695,1121543,1277691,317984,349828,451038,1382208,1480702,1486850,1494602,681645,730997,1069288,1089088,1096964,185570,185566,575121,132422,1096954,1264997,1269761,1479605,380513,1442105,724562,750142,185564,788006,1300032,1230191,1196368,1201624,1211504,397611,1251552,478879,1249803,312518,352355,317734,376467,1334631,1344315,341554,348030,348250,358118,894109,953785,801133,816565,827337,841673,884149,817692,820444,839332,852900,881944,1043206,1196821,1206413,1212993,1163366,1174186,1192774,573612,353245,1299993,1308037,684755,1182093,1182109)
group by 1,2,3 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: starttime {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.starttime ;;
  }

  dimension: language {
    type: string
    sql: ${TABLE}.language ;;
  }

  dimension: total_attempt_count {
    type: number
    sql: ${TABLE}.total_attempt_count ;;
  }

  dimension: active_tests {
    type: number
    sql: ${TABLE}.active_tests ;;
  }

  dimension: company_id {
    type: number
    sql: ${TABLE}.company_id ;;
  }

  dimension: active_customers {
    type: number
    sql: ${TABLE}.active_customers ;;
  }

  set: detail {
    fields: [
      starttime_year,
      language,
      company_id,
      total_attempt_count,
      active_tests,
      active_customers
    ]
  }
}
