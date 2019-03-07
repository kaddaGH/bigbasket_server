require 'cgi'
pages << {
    page_type: 'products_search',
    method: 'GET',
    url: 'https://www.bigbasket.com/product/get-products/?sid=MtSGZo6ibmbDoWMBo21hdqUzLjIuMKJjY60zNTF8MTY5NHwxNzA5qHNrdV9saXN0kKJhb8KidXLComFww6JsdM0BG6Nkc2pNoW-qcG9wdWxhcml0ealzb3VyY2VfaWQBomRzzQEvo21yac0OLg==&listtype=pc&filters=[]&sorted_on=pricelth&slug=sports-energy-drinks&tab_type=[%22all%22]&page=1',
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
      url: "https://www.bigbasket.com/product/get-products/?sid=EE0z4Y6hYwGjbWF2pTMuMi4wom5mw6hza3VfbGlzdJCiYW_ConVywqFxqHJlZCBidWxsomFww6JsdM0BG6Nkc2pNoW-pcmVsZXZhbmNlqXNvdXJjZV9pZAGiZHPNAS-jbXJpzQ4u&listtype=ps&filters=[]&sorted_on=popularity&slug=#{CGI.escape(search_term)}&tab_type=[%22all%22]&page=1",
      vars: {
          'input_type' => 'search',
          'search_term' => search_term,
          'page' => 1
      }


  }

end