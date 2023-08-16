view: salesforce_accounts {
  derived_table: {
    sql: select hrid_c, max(region_c) as region_c, max(number_of_employees) as number_of_employees,max(arr_c::decimal) as arr,
    zen_desk_account_owner_c as owner,csm_cs_specialist_c as csm, industry as industry,
case
when industry = 'Staffing'then'Business Services'
when industry = 'Technology'then'Information Technology'
when industry = 'Manufacturing - Durables'then'Industrials'
when industry = 'Information Technology and Services'then'Information Technology'
when industry = 'Staffing and Recruiting'then'Business Services'
when industry = 'Consumer Services'then'Consumer Discretionary'
when industry = 'Department Stores, Shopping Centers & Superstores'then'Consumer Discretionary'
when industry = 'Non-Profit Organization Management'then'Government'
when industry = 'Consumer Electronics'then'Consumer Discretionary'
when industry = 'Market Research'then'Business Services'
when industry = 'Computer & Network Security'then'Information Technology'
when industry = 'Transportation and Logistics'then'Industrials'
when industry = 'Mining, Oil and Gas'then'Energy'
when industry = 'Architecture, Engineering & Design'then'Business Services'
when industry = 'Plastics Manufacturing'then'Materials'
when industry = 'Media & Entertainment'then'Communication Services'
when industry = 'Consulting'then'Business Services'
when industry = 'Information & Document Management'then'Information Technology'
when industry = 'Apparel & Accessories Retail'then'Consumer Discretionary'
when industry = 'eCommerce'then'Consumer Discretionary'
when industry = 'Wholesale Trade'then'Consumer Staples'
when industry = 'Securities Brokers and Traders'then'Financials'
when industry = 'Outsourcing and Offshoring Consulting'then'Business Services'
when industry = 'Non-Profit & Charitable Organizations'then'Government'
when industry = 'Multimedia, Games & Graphics Software'then'Information Technology'
when industry = 'International Trade and Development'then'Business Services'
when industry = 'Dairy'then'Consumer Staples'
when industry = 'Supply Chain Management (SCM) Software'then'Information Technology'
when industry = 'Movies & Entertainment'then'Communication Services'
when industry = 'Hospitals and Healthcare'then'Health Care'
when industry = 'Advertising Services'then'Communication Services'
when industry = 'Information Technology'then'Information Technology'
when industry = 'Accounting'then'Financials'
when industry = 'Hospital & Health Care'then'Health Care'
when industry = 'Leisure, Travel & Tourism'then'Consumer Discretionary'
when industry = 'Aviation and Aerospace'then'Industrials'
when industry = 'Gambling & Casinos'then'Consumer Discretionary'
when industry = 'Government Relations'then'Government'
when industry = 'Computer Games'then'Communication Services'
when industry = 'Software'then'Information Technology'
when industry = 'IT/ITes'then'Information Technology'
when industry = 'Human Resources Software'then'Information Technology'
when industry = 'Food & Beverage'then'Consumer Staples'
when industry = 'Communications'then'Communication Services'
when industry = 'Print & Digital Media'then'Communication Services'
when industry = 'Grocery Retail'then'Consumer Staples'
when industry = 'Business Supplies and Equipment'then'Industrials'
when industry = 'Consumer Goods & Services'then'Consumer Discretionary'
when industry = 'Computer Services'then'Information Technology'
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
when industry = 'Technology, Information and Internet'then'Information Technology'
when industry = 'Asset Management'then'Financials'
when industry = 'Corporate Services - Corporate Services (General)'then'Business Services'
when industry = 'Business Intelligence (BI) Software'then'Information Technology'
when industry = 'Mobile App Development'then'Information Technology'
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
when industry = 'Computers and Technology - Information Technology/Services'then'Information Technology'
when industry = 'Engineering Software'then'Information Technology'
when industry = 'Lending & Brokerage'then'Financials'
when industry = 'Database & File Management Software'then'Information Technology'
when industry = 'Human Resources & Staffing'then'Business Services'
when industry = 'Programming and Data Processing Services'then'Information Technology'
when industry = 'Healthcare and Pharmaceuticals'then'Health Care'
when industry = 'Holding Companies'then'Financials'
when industry = 'Program Development'then'Information Technology'
when industry = 'Health, Wellness and Fitness'then'Health Care'
when industry = 'Food & Beverages'then'Consumer Staples'
when industry = 'Airlines/Aviation'then'Industrials'
when industry = 'Printing & Publishing'then'Consumer Discretionary'
when industry = 'Services'then'Business Services'
when industry = 'Recreational Facilities and Services'then'Consumer Discretionary'
when industry = 'Manufacturing/Industrial'then'Industrials'
when industry = 'Telecoms, Technology, Internet, and Electronics'then'Information Technology'
when industry = 'Consumer Products'then'Consumer Discretionary'
when industry = 'Furniture'then'Consumer Discretionary'
when industry = 'Broadcast Media'then'Communication Services'
when industry = 'Civic & Social Organization'then'Government'
when industry = 'Motor Vehicles'then'Consumer Discretionary'
when industry = 'Medical & Surgical Hospitals'then'Health Care'
when industry = 'Primary/Secondary Education'then'Consumer Discretionary'
when industry = 'Barber Shops & Beauty Salons'then'Consumer Discretionary'
when industry = 'Education and Training Software'then'Information Technology'
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
when industry = 'Computer Networking'then'Information Technology'
when industry = 'Online Media'then'Communication Services'
when industry = 'Chemicals'then'Materials'
when industry = 'Outsourcing/Offshoring'then'Industrials'
when industry = 'Electronics'then'Information Technology'
when industry = 'Hospitality & Travel'then'Consumer Discretionary'
when industry = 'Law Practice'then'Business Services'
when industry = 'Media'then'Communication Services'
when industry = 'Design'then'Consumer Discretionary'
when industry = 'Veterinary'then'Health Care'
when industry = 'Automotive Service & Collision Repair'then'Consumer Discretionary'
when industry = 'Maritime'then'Industrials'
when industry = 'Financial Software'then'Information Technology'
when industry = 'Game Software'then'Information Technology'
when industry = 'SaaS'then'Information Technology'
when industry = 'Education Administration Programs'then'Consumer Discretionary'
when industry = 'Computer Hardware'then'Information Technology'
when industry = 'IT'then'Information Technology'
when industry = 'Utilities'then'Utilities'
when industry = 'Government'then'Government'
when industry = 'Mechanical or Industrial Engineering'then'Industrials'
when industry = 'Restaurants'then'Consumer Discretionary'
when industry = 'Energy & Utilities'then'Utilities'
when industry = 'Energy, Utilities & Waste Treatment'then'Utilities'
when industry = 'Entertainment'then'Communication Services'
when industry = 'Computer Equipment & Peripherals'then'Information Technology'
when industry = 'Newspapers'then'Communication Services'
when industry = 'Technology, Media, and Telecom'then'Communication Services'
when industry = 'Internet Service Providers, Website Hosting & Internet-related Services'then'Communication Services'
when industry = 'Industrial Machinery & Equipment'then'Industrials'
when industry = 'Waste Treatment, Environmental Services & Recycling'then'Utilities'
when industry = 'Architecture & Planning'then'Industrials'
when industry = 'Gaming Software/Systems'then'Information Technology'
when industry = 'Music'then'Communication Services'
when industry = 'Medical Specialists'then'Health Care'
when industry = 'Accounting Services'then'Financials'
when industry = 'IT Services'then'Information Technology'
when industry = 'Pharmaceuticals'then'Health Care'
when industry = 'Telecommunications'then'Communication Services'
when industry = 'Oil & Energy'then'Energy'
when industry = 'Wireless'then'Communications'
when industry = 'Marketing and Advertising'then'Communication Services'
when industry = 'Transportation/Trucking/Railroad'then'Industrials'
when industry = 'Wholesale'then'Consumer Discretionary'
when industry = 'Human Resources'then'Business Services'
when industry = 'Recreation'then'Consumer Discretionary'
when industry = 'Holding Companies & Conglomerates'then'Financials'
when industry = 'Security Software'then'Information Technology'
when industry = 'Package/Freight Delivery'then'Industrials'
when industry = 'Investment Banking'then'Financials'
when industry = 'Defense & Aerospace'then'Industrials'
when industry = 'Hospitals & Physicians Clinics'then'Health Care'
when industry = 'Internet Software & Services'then'Information Technology'
when industry = 'Nanotechnology'then'Health Care'
when industry = 'IT Services and IT Consulting'then'Information Technology'
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
when industry = 'Software Development & Design'then'Information Technology'
when industry = 'Fund-Raising'then'Financials'
when industry = 'Software / SaaS Provider'then'Information Technology'
when industry = 'Associations'then'Government'
when industry = 'Cable & Satellite'then'Communication Services'
when industry = 'Advertising / Marketing'then'Communication Services'
when industry = 'Enterprise Resource Planning (ERP) Software'then'Information Technology'
when industry = 'Leisure'then'Consumer Discretionary'
when industry = 'Diversified Lending'then'Financials'
when industry = 'Business Services'then'Professional Services'
when industry = 'Defense & Space'then'Industrials'
when industry = 'Electrical/Electronic Manufacturing'then'Industrials'
when industry = 'Custom Software & IT Services'then'Information Technology'
when industry = 'Transportation'then'Industrials'
when industry = 'Legal Services'then'Professional Services'
when industry = 'Renewables & Environment'then'Utilities'
when industry = 'Government Administration'then'Government'
when industry = 'Sports'then'Consumer Discretionary'
when industry = 'Semiconductors'then'Information Technology'
when industry = 'Other'then'Other'
when industry = 'Staffing & Recruiting'then'Business Services'
when industry = 'Mining & Metals'then'Materials'
when industry = 'Information Services'then'Information Technology'
when industry = 'Consumer Services,Media,Retail'then'Consumer Discretionary'
when industry = 'Aerospace & Defense'then'Industrials'
when industry = 'Internet Software and Services'then'Information Technology'
when industry = 'Healthcare Software'then'Health Care'
when industry = 'Department Stores'then'Consumer Discretionary'
when industry = 'Finance / Venture Capital'then'Financials'
when industry = 'Utilities / Transportation / Agriculture / Oil / Gas'then'Utilities'
when industry = 'Training'then'Consumer Discretionary'
when industry = 'Mining'then'Materials'
when industry = 'Medical Practice'then'Health Care'
when industry = 'Software Development'then'Information Technology'
when industry = 'Retail Groceries'then'Consumer Staples'
when industry = 'Thrifts and Mortgage Finance'then'Financials'
when industry = 'Electricity, Oil & Gas'then'Utilities'
when industry = 'Computer Software'then'Information Technology'
when industry = 'Retail'then'Consumer Discretionary'
when industry = 'Insurance'then'Financials'
when industry = 'Software & Technology'then'Information Technology'
when industry = 'Printing'then'Industrials'
when industry = 'Machinery'then'Industrials'
when industry = 'Non-Profit'then'Government'
when industry = 'Farming'then'Materials'
when industry = 'Retail & Distribution'then'Consumer Discretionary'
when industry = 'Holding Company'then'Financials'
when industry = 'IT Infrastructure / Networking / Telecom'then'Information Technology'
when industry = 'Aviation & Aerospace'then'Industrials'
when industry = 'Cosmetics'then'Consumer Staples'
when industry = 'Animation'then'Communication Services'
when industry = 'Telecom / Communication Services'then'Communication Services'
when industry = 'Local'then'Real Estate'
when industry = 'Hospitals and Health Care'then'Health Care'
when industry = 'Retail Apparel and Fashion'then'Consumer Discretionary'
when industry = 'Content & Collaboration Software'then'Information Technology'
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
when industry = 'Customer Relationship Management (CRM) Software'then'Information Technology'
when industry = 'Data Collection & Internet Portals'then'Information Technology'
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
when industry = 'Computer/Telecom'then'Information Technology'
else 'Other' end as industry_high_level


              from hr_analytics.salesforce.accounts
              where hrid_c is not null
              group by 1,5,6,7,8 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: hrid_c {
    type: string
    sql: ${TABLE}.hrid_c ;;
  }

  dimension: region_c {
    type: string
    sql: ${TABLE}.region_c ;;
  }

  dimension: number_of_employees {
    type: number
    sql: ${TABLE}.number_of_employees ;;
  }

  dimension: arr {
    type: number
    sql: ${TABLE}.arr ;;
  }

  dimension: owner {
    type: string
    sql: ${TABLE}.owner ;;
  }

  dimension: csm {
    type: string
    sql: ${TABLE}.csm ;;
  }

  dimension: industry {
    type: string
    sql: ${TABLE}.industry ;;
  }

  dimension: industry_high_level {
    type: string
    sql: ${TABLE}.industry_high_level ;;
  }
  set: detail {
    fields: [
      hrid_c,
      region_c,
      number_of_employees,
      arr,
      owner,
      csm,
      industry,
      industry_high_level
    ]
  }
}
