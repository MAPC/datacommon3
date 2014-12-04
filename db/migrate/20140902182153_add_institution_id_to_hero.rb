class AddInstitutionIdToHero < ActiveRecord::Migration
  def change
    add_column :mbdc_hero, :institution_id, :integer, default: 1

    # Create Central Mass heros
    heros = [
      {
        title: "Welcome to the Central Mass DataCommon",
        subtitle: "A Data Visualization Tool",
        content_markup_type: "html",
        content: "The Central Mass DataCommon, a partnership between the Central Massachusetts Planning Commission (CMRPC), the Montachusett Regional Planning Commission (MRPC), and the Metropolitan Area Planning Council (MAPC), is an important resource for those seeking to understand the people and municipalities of Central Massachusetts. An interactive data tool, it is packed with information on topics from health care and education to economic development and transportation. Residents, planners, city and town officials, educators, entrepreneurs, journalists, and others can explore data and use it to make informed decisions. We invite you to <a href=\"/layers\">explore data</a> and <a href=\"/municipalities\">community snapshots</a>, and <a href=\"/visualizations/new\">create your own visualizations</a>.",
        _content_rendered: "The Central Mass DataCommon, a partnership between the Central Massachusetts Planning Commission (CMRPC), the Montachusett Regional Planning Commission (MRPC), and the Metropolitan Area Planning Council (MAPC), is an important resource for those seeking to understand the people and municipalities of Central Massachusetts. An interactive data tool, it is packed with information on topics from health care and education to economic development and transportation. Residents, planners, city and town officials, educators, entrepreneurs, journalists, and others can explore data and use it to make informed decisions. We invite you to <a href=\"/layers\">explore data</a> and <a href=\"/municipalities\">community snapshots</a>, and <a href=\"/visualizations/new\">create your own visualizations</a>.",
        active: true,
        image: "http://upload.wikimedia.org/wikipedia/commons/f/fe/Worcester_Massachusetts.jpg",
        institution_id: 2
      },
      {
        title: "Help us improve the DataCommon!",
        subtitle: "User testing ongoing",
        content_markup_type: "html",
        content: "The Central Mass DataCommon is currently in development. Help us ensure that this resource is easy for everyone to use! Our goal is to make it easy to find data, visualize it with a map or chart, and to use that visualization to communicate findings in a website, presentation, report, or email. We are looking for residents, planners, city and town officials, educators, the business community, journalists, and others — basically anyone who is interested in data to participate in usability testing. We are not testing you or your computer, but looking for ways to improve the data portal. Email <a href=\"mailto:cryan@cmrpc.org\">Chris Ryan, CMRPC</a>, for more information and to sign up.",
        _content_rendered: "The Central Mass DataCommon is currently in development. Help us ensure that this resource is easy for everyone to use! Our goal is to make it easy to find data, visualize it with a map or chart, and to use that visualization to communicate findings in a website, presentation, report, or email. We are looking for residents, planners, city and town officials, educators, the business community, journalists, and others — basically anyone who is interested in data to participate in usability testing. We are not testing you or your computer, but looking for ways to improve the data portal. Email <a href=\"mailto:cryan@cmrpc.org\">Chris Ryan, CMRPC</a>, for more information and to sign up.",
        active: true,
        image: "http://upload.wikimedia.org/wikipedia/commons/c/c7/Union_Station,_Worcester_MA.jpg",
        institution_id: 2
      },
      {
        title: "New Data! 2013 Municipal Unemployment Rates",
        subtitle: "Unemployment data available for 1990-2013",
        content_markup_type: "html",
        content: "The Massachusetts unemployment rate has decline over the past few years, but not everywhere in the state. The Bureau of Labor Statistics recently released the 2013 Local Area Unemployment Statistics and it is now available on the DataCommon. The DataCommon now has unemployment data for 1990-2013. Find out how Central Massachusetts and your municipality are doing.",
        _content_rendered: "The Massachusetts unemployment rate has decline over the past few years, but not everywhere in the state. The Bureau of Labor Statistics recently released the 2013 Local Area Unemployment Statistics and it is now available on the DataCommon. The DataCommon now has unemployment data for 1990-2013. Find out how Central Massachusetts and your municipality are doing.",
        active: true,
        image: "http://upload.wikimedia.org/wikipedia/commons/c/c6/Greendale_Mall,_Worcester_MA.jpg",
        institution_id: 2
      }
    ]
    heros.each {|hero| Hero.create_or_update hero }
  end
end
