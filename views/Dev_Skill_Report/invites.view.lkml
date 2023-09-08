
view: invites {
  derived_table: {
    sql: WITH ever_paid_companies_inc_tcs AS (---- Ever Paid Customers | TCS LND/ Internal accounts Excluded
          with ever_paid as
          (

            select distinct company_plan_changelog_company_id as company_id from global.fact_recruit_company_plan_changelog
            where company_plan_changelog_plan_name not in ('free', 'trial', 'user-freemium-interviews-v1','locked') -- # ever paid customers (This table has data only of companies created post 2018)
            ---- ^ Above query returns ever paid customer who joined 2018 onwards
            union
            select distinct company_id from global.dim_recruit_company rc
            where company_stripe_plan not in ('free', 'trial','user-freemium-interviews-v1','locked')
            and company_type not in ('free', 'trial','locked')  -- # using this logic to cover paid customers who are not covered in the above logic [company_plan_changelog table]

            ---- ^ currently active customers being missed out on prev query (2018 onwards set)
            )

            Select rc.*
            from
            global.dim_recruit_company rc  inner join ever_paid ep on ep.company_id=rc.company_id

            inner join global.dim_recruit_user ru on ru.user_id=rc.company_owner  ---- filter internal test accounts created by HR users themselves
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

            and rc.company_id not in (106529,46242) --- exclude internal test setters
            )
      SELECT
          recruit_test_candidates.created_at,
          recruit_tests.company_id,
          sa.region_c,
          case
when industry = 'Technology'then'Information Technology'
when industry = 'Information Technology and Services'then'Information Technology'
when industry = 'Computer & Network Security'then'Information Technology'
when industry = 'Information & Document Management'then'Information Technology'
when industry = 'Multimedia, Games & Graphics Software'then'Information Technology'
when industry = 'Supply Chain Management (SCM) Software'then'Information Technology'
when industry = 'Information Technology'then'Information Technology'
when industry = 'Human Resources Software'then'Information Technology'
when industry = 'Software'then'Information Technology'
when industry = 'IT/ITes'then'Information Technology'
when industry = 'Computer Services'then'Information Technology'
when industry = 'Technology, Information and Internet'then'Information Technology'
when industry = 'Business Intelligence (BI) Software'then'Information Technology'
when industry = 'Mobile App Development'then'Information Technology'
when industry = 'Computers and Technology - Information Technology/Services'then'Information Technology'
when industry = 'Engineering Software'then'Information Technology'
when industry = 'Database & File Management Software'then'Information Technology'

when industry = 'Programming and Data Processing Services'then'Information Technology'

when industry = 'Program Development'then'Information Technology'

when industry = 'Telecoms, Technology, Internet, and Electronics'then'Information Technology'

when industry = 'Education and Training Software'then'Information Technology'

when industry = 'Computer Networking'then'Information Technology'

when industry = 'Electronics'then'Information Technology'

when industry = 'Financial Software'then'Information Technology'

when industry = 'Game Software'then'Information Technology'

when industry = 'SaaS'then'Information Technology'


when industry = 'Computer Hardware'then'Information Technology'

when industry = 'IT'then'Information Technology'

when industry = 'Computer Equipment & Peripherals'then'Information Technology'

when industry = 'Gaming Software/Systems'then'Information Technology'

when industry = 'IT Services'then'Information Technology'

when industry = 'Security Software'then'Information Technology'

when industry = 'Internet Software & Services'then'Information Technology'

when industry = 'IT Services and IT Consulting'then'Information Technology'

when industry = 'Software Development & Design'then'Information Technology'

when industry = 'Software / SaaS Provider'then'Information Technology'

when industry = 'Enterprise Resource Planning (ERP) Software'then'Information Technology'

when industry = 'Custom Software & IT Services'then'Information Technology'

when industry = 'Semiconductors'then'Information Technology'

when industry = 'Information Services'then'Information Technology'

when industry = 'Internet Software and Services'then'Information Technology'

when industry = 'Software Development'then'Information Technology'

when industry = 'Computer Software'then'Information Technology'

when industry = 'Software & Technology'then'Information Technology'

when industry = 'IT Infrastructure / Networking / Telecom'then'Information Technology'

when industry = 'Content & Collaboration Software'then'Information Technology'

when industry = 'Customer Relationship Management (CRM) Software'then'Information Technology'

when industry = 'Data Collection & Internet Portals'then'Information Technology'

when industry = 'Computer/Telecom'then'Information Technology'

when industry = 'Staffing'then'Business Services'
when industry = 'Manufacturing - Durables'then'Industrials'
when industry = 'Staffing and Recruiting'then'Business Services'
when industry = 'Consumer Services'then'Consumer Discretionary'
when industry = 'Department Stores, Shopping Centers & Superstores'then'Consumer Discretionary'
when industry = 'Non-Profit Organization Management'then'Government'
when industry = 'Consumer Electronics'then'Consumer Discretionary'
when industry = 'Market Research'then'Business Services'
when industry = 'Transportation and Logistics'then'Industrials'
when industry = 'Mining, Oil and Gas'then'Energy'
when industry = 'Architecture, Engineering & Design'then'Business Services'
when industry = 'Plastics Manufacturing'then'Materials'
when industry = 'Media & Entertainment'then'Communication Services'
when industry = 'Consulting'then'Business Services'
when industry = 'Apparel & Accessories Retail'then'Consumer Discretionary'
when industry = 'eCommerce'then'Consumer Discretionary'
when industry = 'Wholesale Trade'then'Consumer Staples'
when industry = 'Securities Brokers and Traders'then'Financials'
when industry = 'Outsourcing and Offshoring Consulting'then'Business Services'
when industry = 'Non-Profit & Charitable Organizations'then'Government'
when industry = 'International Trade and Development'then'Business Services'
when industry = 'Dairy'then'Consumer Staples'
when industry = 'Movies & Entertainment'then'Communication Services'
when industry = 'Hospitals and Healthcare'then'Health Care'
when industry = 'Advertising Services'then'Communication Services'
when industry = 'Accounting'then'Financials'
when industry = 'Hospital & Health Care'then'Health Care'
when industry = 'Leisure, Travel & Tourism'then'Consumer Discretionary'
when industry = 'Aviation and Aerospace'then'Industrials'
when industry = 'Gambling & Casinos'then'Consumer Discretionary'
when industry = 'Government Relations'then'Government'
when industry = 'Computer Games'then'Communication Services'
when industry = 'Food & Beverage'then'Consumer Staples'
when industry = 'Communications'then'Communication Services'
when industry = 'Print & Digital Media'then'Communication Services'
when industry = 'Grocery Retail'then'Consumer Staples'
when industry = 'Business Supplies and Equipment'then'Industrials'
when industry = 'Consumer Goods & Services'then'Consumer Discretionary'
when industry = 'Brokerage'then'Financials'
when industry = 'Internet'then'Communication Services'
when industry = 'Education'then'Consumer Discretionary'
when industry = 'Manufacturing - Non-Durables'then'Industrials'
when industry = 'Education Management'then'Consumer Discretionary'
when industry = 'Higher Education'then'Consumer Discretionary'
when industry = 'Real Estate'then'Real Estate'
when industry = 'Cryptocurrency'then'Financials'
when industry = 'Healthcare & Medical'then'Health Care'
when industry = 'Capital Markets'then'Financials'
when industry = 'E-Learning'then'Consumer Discretionary'
when industry = 'Environmental Services'then'Utilities'
when industry = 'Import and Export'then'Industrials'
when industry = 'Asset Management'then'Financials'
when industry = 'Corporate Services - Corporate Services (General)'then'Business Services'
when industry = 'School Districts'then'Consumer Discretionary'
when industry = 'Textiles'then'Consumer Discretionary'
when industry = 'Law Firms & Legal Services'then'Business Services'
when industry = 'Test & Measurement Equipment'then'Industrials'
when industry = 'Government / Non-Profit'then'Government'
when industry = 'Energy'then'Energy'
when industry = 'Business Consulting and Services'then'Business Services'
when industry = 'Security and Investigations'then'Industrials'
when industry = 'Professional Services'then'Business Services'
when industry = 'Sports Teams & Leagues'then'Consumer Discretionary'
when industry = 'Industrial Automation'then'Industrials'
when industry = 'Logistics and Supply Chain'then'Industrials'
when industry = 'Construction and Building Materials'then'Industrials'
when industry = 'Research'then'Business Services'
when industry = 'Elderly Care Services'then'Health Care'
when industry = 'Media & Internet'then'Communication Services'
when industry = 'Credit Cards & Transaction Processing'then'Financials'
when industry = 'HR & Staffing'then'Business Services'
when industry = 'Real Estate Services'then'Real Estate'
when industry = 'Hospitals / Health Care'then'Health Care'
when industry = 'Lending & Brokerage'then'Financials'
when industry = 'Human Resources & Staffing'then'Business Services'
when industry = 'Healthcare and Pharmaceuticals'then'Health Care'
when industry = 'Holding Companies'then'Financials'
when industry = 'Health, Wellness and Fitness'then'Health Care'
when industry = 'Food & Beverages'then'Consumer Staples'
when industry = 'Airlines/Aviation'then'Industrials'
when industry = 'Printing & Publishing'then'Consumer Discretionary'
when industry = 'Services'then'Business Services'
when industry = 'Recreational Facilities and Services'then'Consumer Discretionary'
when industry = 'Manufacturing/Industrial'then'Industrials'
when industry = 'Consumer Products'then'Consumer Discretionary'
when industry = 'Furniture'then'Consumer Discretionary'
when industry = 'Broadcast Media'then'Communication Services'
when industry = 'Civic & Social Organization'then'Government'
when industry = 'Motor Vehicles'then'Consumer Discretionary'
when industry = 'Medical & Surgical Hospitals'then'Health Care'
when industry = 'Primary/Secondary Education'then'Consumer Discretionary'
when industry = 'Barber Shops & Beauty Salons'then'Consumer Discretionary'
when industry = 'Civil Engineering'then'Industrials'
when industry = 'Recruiting'then'Business Services'
when industry = 'Finance'then'Financials'
when industry = 'Financial Services'then'Financials'
when industry = 'Apparel'then'Consumer Discretionary'
when industry = 'Unclassified'then'Other'
when industry = 'Media Production'then'Communication Services'
when industry = 'Venture Capital & Private Equity'then'Financials'
when industry = 'Hospitality'then'Consumer Discretionary'
when industry = 'Apparel & Fashion'then'Consumer Discretionary'
when industry = 'Media and Telecommunications'then'Communication Services'
when industry = 'Luxury Goods & Jewelry'then'Consumer Discretionary'
when industry = 'Online Media'then'Communication Services'
when industry = 'Chemicals'then'Materials'
when industry = 'Outsourcing/Offshoring'then'Industrials'
when industry = 'Hospitality & Travel'then'Consumer Discretionary'
when industry = 'Law Practice'then'Business Services'
when industry = 'Media'then'Communication Services'
when industry = 'Design'then'Consumer Discretionary'
when industry = 'Veterinary'then'Health Care'
when industry = 'Automotive Service & Collision Repair'then'Consumer Discretionary'
when industry = 'Maritime'then'Industrials'
when industry = 'Education Administration Programs'then'Consumer Discretionary'
when industry = 'Utilities'then'Utilities'
when industry = 'Government'then'Government'
when industry = 'Mechanical or Industrial Engineering'then'Industrials'
when industry = 'Restaurants'then'Consumer Discretionary'
when industry = 'Energy & Utilities'then'Utilities'
when industry = 'Energy, Utilities & Waste Treatment'then'Utilities'
when industry = 'Entertainment'then'Communication Services'
when industry = 'Newspapers'then'Communication Services'
when industry = 'Technology, Media, and Telecom'then'Communication Services'
when industry = 'Internet Service Providers, Website Hosting & Internet-related Services'then'Communication Services'
when industry = 'Industrial Machinery & Equipment'then'Industrials'
when industry = 'Waste Treatment, Environmental Services & Recycling'then'Utilities'
when industry = 'Architecture & Planning'then'Industrials'
when industry = 'Music'then'Communication Services'
when industry = 'Medical Specialists'then'Health Care'
when industry = 'Accounting Services'then'Financials'
when industry = 'Pharmaceuticals'then'Health Care'
when industry = 'Telecommunications'then'Communication Services'
when industry = 'Oil & Energy'then'Energy'
when industry = 'Wireless'then'Communication Services'
when industry = 'Marketing and Advertising'then'Communication Services'
when industry = 'Transportation/Trucking/Railroad'then'Industrials'
when industry = 'Wholesale'then'Consumer Discretionary'
when industry = 'Human Resources'then'Business Services'
when industry = 'Recreation'then'Consumer Discretionary'
when industry = 'Holding Companies & Conglomerates'then'Financials'
when industry = 'Package/Freight Delivery'then'Industrials'
when industry = 'Investment Banking'then'Financials'
when industry = 'Defense & Aerospace'then'Industrials'
when industry = 'Hospitals & Physicians Clinics'then'Health Care'
when industry = 'Nanotechnology'then'Health Care'
when industry = 'Security Products & Services'then'Industrials'
when industry = 'Facilities Services'then'Real Estate'
when industry = 'Professional Sports'then'Consumer Discretionary'
when industry = 'Wellness and Fitness Services'then'Health Care'
when industry = 'Engineering'then'Industrials'
when industry = 'Logistics / Transportation'then'Industrials'
when industry = 'Museums and Institutions'then'Consumer Discretionary'
when industry = 'Consumer Goods'then'Consumer Discretionary'
when industry = 'Biotech'then'Health Care'
when industry = 'Agriculture'then'Consumer Staples'
when industry = 'Digital Native'then'Communication Services'
when industry = 'Public Relations and Communications'then'Communication Services'
when industry = 'Architecture and Planning'then'Industrials'
when industry = 'Fin Tech'then'Financials'
when industry = 'Advertising & Marketing'then'Communication Services'
when industry = 'Publishing'then'Communication Services'
when industry = 'Chemicals & Related Products'then'Materials'
when industry = 'Medical Devices & Equipment'then'Health Care'
when industry = 'Political Organization'then'Government'
when industry = 'Public Safety'then'Government'
when industry = 'Fund-Raising'then'Financials'
when industry = 'Associations'then'Government'
when industry = 'Cable & Satellite'then'Communication Services'
when industry = 'Advertising / Marketing'then'Communication Services'
when industry = 'Leisure'then'Consumer Discretionary'
when industry = 'Diversified Lending'then'Financials'
when industry = 'Business Services'then'Professional Services'
when industry = 'Defense & Space'then'Industrials'
when industry = 'Electrical/Electronic Manufacturing'then'Industrials'
when industry = 'Transportation'then'Industrials'
when industry = 'Legal Services'then'Professional Services'
when industry = 'Renewables & Environment'then'Utilities'
when industry = 'Government Administration'then'Government'
when industry = 'Sports'then'Consumer Discretionary'
when industry = 'Other'then'Other'
when industry = 'Staffing & Recruiting'then'Business Services'
when industry = 'Mining & Metals'then'Materials'
when industry = 'Consumer Services,Media,Retail'then'Consumer Discretionary'
when industry = 'Aerospace & Defense'then'Industrials'
when industry = 'Healthcare Software'then'Health Care'
when industry = 'Department Stores'then'Consumer Discretionary'
when industry = 'Finance / Venture Capital'then'Financials'
when industry = 'Utilities / Transportation / Agriculture / Oil / Gas'then'Utilities'
when industry = 'Training'then'Consumer Discretionary'
when industry = 'Mining'then'Materials'
when industry = 'Medical Practice'then'Health Care'
when industry = 'Retail Groceries'then'Consumer Staples'
when industry = 'Thrifts and Mortgage Finance'then'Financials'
when industry = 'Electricity, Oil & Gas'then'Utilities'
when industry = 'Retail'then'Consumer Discretionary'
when industry = 'Insurance'then'Financials'
when industry = 'Printing'then'Industrials'
when industry = 'Machinery'then'Industrials'
when industry = 'Non-Profit'then'Government'
when industry = 'Farming'then'Materials'
when industry = 'Retail & Distribution'then'Consumer Discretionary'
when industry = 'Holding Company'then'Financials'
when industry = 'Aviation & Aerospace'then'Industrials'
when industry = 'Cosmetics'then'Consumer Staples'
when industry = 'Animation'then'Communication Services'
when industry = 'Telecom / Communication Services'then'Communication Services'
when industry = 'Local'then'Real Estate'
when industry = 'Hospitals and Health Care'then'Health Care'
when industry = 'Retail Apparel and Fashion'then'Consumer Discretionary'
when industry = 'Philanthropy'then'Government'
when industry = 'Automotive'then'Consumer Discretionary'
when industry = 'Management Consulting'then'Professional Services'
when industry = 'Manufacturing'then'Industrials'
when industry = 'Healthcare'then'Health Care'
when industry = 'Investment Management'then'Financials'
when industry = 'Construction'then'Industrials'
when industry = 'Banking'then'Financials'
when industry = 'Biotechnology'then'Health Care'
when industry = 'Food Production'then'Consumer Staples'
when industry = 'FMCG'then'Consumer Staples'
when industry = 'Marketing & Advertising'then'Business Services'
when industry = 'Medical Devices'then'Health Care'
when industry = 'Energy / Utilities'then'Utilities'
when industry = 'Energy, Utilities & Waste'then'Utilities'
when industry = 'Corporate Services'then'Business Services'
when industry = 'Investment Advice'then'Financials'
when industry = 'Advertising / Media / Marketing'then'Business Services'
when industry = 'Building Materials'then'Materials'
when industry = 'Transportation & Logistics'then'Industrials'
when industry = 'Professional Training & Coaching'then'Business Services'
when industry = 'Sporting Goods'then'Consumer Discretionary'
when industry = 'Manufacturing / Retail / Wholesale / Distribution'then'Industrials'
when industry = 'Plastics'then'Materials'
when industry = 'Federal'then'Government'
else 'Other' end as industry_high_level,
          COUNT(DISTINCT recruit_test_candidates.id) AS "invites",
                    COUNT(DISTINCT recruit_test_candidates.attempt_id) AS "attempts"

      FROM ever_paid_companies_inc_tcs
      INNER JOIN recruit.recruit_tests  AS recruit_tests ON ever_paid_companies_inc_tcs.company_id = abs(recruit_tests.company_id)
      LEFT JOIN recruit.recruit_test_candidates  AS recruit_test_candidates ON recruit_test_candidates.test_id = recruit_tests.id
            and recruit_tests.draft = 0
            and recruit_tests.state <> 3
      left join mails_rs_replica.mail.aws_ses_mail aws
            -- left join recruit_rs_replica.recruit.recruit_test_candidates rtc
            on aws.entity_id = recruit_test_candidates.test_user_id
            -- where entity_id = 43938431
            and
            aws."tag" = 'hrw-test-invite'
            and entity_type = 'Recruit::TestUser'
      left join hr_analytics.salesforce.accounts sa
      on sa.hrid_c = recruit_tests.company_id
      group by 1,2,3,4
;;  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }


  dimension_group: created_at {
    type: time
    timeframes: [raw,time,date,month,quarter,year]

    sql: ${TABLE}.created_at ;;
  }

  dimension: company_id {
    type: number
    sql: ${TABLE}.company_id ;;
  }

  dimension: region_c {
    type: string
    sql: ${TABLE}.region_c ;;
  }

  dimension: industry_high_level {
    type: string
    sql: ${TABLE}.industry_high_level ;;
  }

  dimension: invites {
    type: number
    sql: ${TABLE}.invites ;;
  }

  dimension: attempts {
    type: number
    sql: ${TABLE}.attempts ;;
  }


  set: detail {
    fields: [
      created_at_year,
      company_id,
      invites,
      attempts,
      region_c,
      industry_high_level
    ]
  }
}
