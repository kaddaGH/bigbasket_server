require 'cgi'
pages << {
    page_type: 'products_search',
    method: 'GET',
    url: 'https://www.bigbasket.com/product/get-products/?listtype=pc&filters=[]&sorted_on=pricelth&slug=sports-energy-drinks&tab_type=[%22all%22]',
    vars: {
        'input_type' => 'taxonomy',
        'search_term' => '-',
        'page' => 1
    }


}

search_terms = ['Red Bull', 'RedBull', 'Energidryck', 'Energidrycker']
search_terms.each do |search_term|
break

  pages << {
      page_type: 'products_search',
      method: 'GET',
      url: "https://www.bigbasket.com/product/get-products/?listtype=ps&filters=[]&sorted_on=popularity&slug=#{CGI.escape(search_term)}&tab_type=[%22all%22]",
      vars: {
          'input_type' => 'search',
          'search_term' => search_term,
          'page' => 1
      }


  }

end