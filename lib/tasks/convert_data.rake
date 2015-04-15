namespace :db do
  desc "Convert current production data to new DataCommon"

  task convert: :environment do

    # Create institutions
    Institution.create_or_update( id:         1,
                                  short_name: 'Metro Boston',
                                  long_name:  'Metropolitan Boston',
                                  subdomain:  'metroboston' )

    Institution.create_or_update( id:         2,
                                  short_name: 'Central Mass',
                                  long_name:  'Cental Massachusetts',
                                  subdomain:  'metroboston')

    # Activate all topics except Geographic Boundaries
    IssueArea.unscoped.all.each {|t| t.update_attribute(:active, true) }
    IssueArea.find(14).update_attribute(:active, false)


    # Set visualizations that belong to CMRPC
    cmrpc_visuals = [
      2660,2652,2639,2623,2526,2667,2673,2674,2675,66,2550,2527,2664,
      2666,2671,2672,2676,2663,2662,2646,2681,2677,2658,2678,2679,2680
    ]

    Visualization.unscoped.find(cmrpc_visuals).each do |v|
      v.update_attributes institution_id: 2, permission: 'public'
    end


    # Set featured visualizations
    Visualization.unscoped.find(2403).update_attribute :featured, 1  # MAPC
    Visualization.unscoped.find(2673).update_attribute :featured, 1  # CMRPC

    # Update profiles and user profiles with CMRPC
    # profiles = Profile.where(organization: 'CMRPC')
    # profiles = profiles + Profile.where(organization: 'Central Massachusetts Regional Planning Commission')

    # profiles.each do |profile|
    #   profile.user.visualizations.each {|v| v.update_attribute :institution_id, 2 }
    # end

    # user  = User.where(username: 'cjryan2006').profile
    # user2 = User.where(username: 'mfranz77').profile
    # user3 = User.where(username: 'edd06001').profile
    # [user, user2, user3].each do |user|
    #   user.visualizations.each {|v| v.update_attribute :institution_id, 2 }
    # end
    

    # Create static maps
    # StaticMap.create([
    # {
    #   id: 111,
    #   year: 2014,
    #   title: "CMRPC Region: Functional Road Classification",
    #   abstract: """Roadway functional classification map. MassDOT defines functional classification in the following three general categories:

    #   Arterials: Arterials provide the highest level of mobility at the greatest vehicular speed for the longest uninterrupted distances and are not intended to provide access to specific locations. Arterials are further subdivided into Principal Arterials and Minor Arterials. Interstates are considered to be arterials but are given their own category.
       
    #   Collectors: Collectors provide some level of both mobility and access. They collect traffic from local roads and funnel it to arterials. In rural areas, collectors are further subdivided into Major Collectors and Minor Collectors.
       
    #   Local roads: Local roads provide access to abutting land with little or no emphasis on mobility. The term \"local road\" should not be confused with local jurisdiction. Most, though not all, functionally classified local roads are under city or town jurisdiction.
       
    #   This map does not include \"local roads\" for readability.""",
    #   pdf_page: 'calendar/CMRPC_FC_Final.pdf',
    #   thumbnail: 'calendar/road-map-thumb.png',
    #   month: 9,
    #   institution_id: 2
    # },
    # {
    #   id: 112,
    #   year: 2005,
    #   title: "CMRPC Region Land Use Map",
    #   abstract: "Using data from MassGIS, CMRPC developed a 2005 regional land use map showing land use categories including residential, commercial, open land, water, and others. This maps shows where concentrations of developed land are location in relation to undeveloped lands such as wetlands, forests as well as transportation facilities.",
    #   pdf_page: 'calendar/CMRPC_2005LandUse_11x17.pdf',
    #   thumbnail: 'calendar/land-use-thumb.png',
    #   month: 1,
    #   institution_id: 2
    # }])

  end
end