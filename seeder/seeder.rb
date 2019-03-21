require 'cgi'




pages << {
    page_type: 'products_search',
    method: 'GET',
    url: 'https://www.bigbasket.com/product/get-products/?sid=Sij0p4yhYwGjbWF2pTMuMi4wqHNrdV9saXN0kKJhb8KidXLCoXGocmVkIGJ1bGyiYXDDomx0zQEToW-pcmVsZXZhbmNlqXNvdXJjZV9pZAGibmbDo21yaQE==&listtype=pc&filters=[]&sorted_on=popularity&slug=sports-energy-drinks&tab_type=[%22all%22]',
    vars: {
        'input_type' => 'taxonomy',
        'search_term' => '-',
        'page' => 1
    }


}
search_terms = ['Red Bull', 'RedBull', 'Energy Drink', 'Energy Drinks']
search_terms.each do |search_term|
  pages << {
      page_type: 'products_search',
      method: 'GET',
      url: "https://www.bigbasket.com/product/get-products/?sid=Sij0p4yhYwGjbWF2pTMuMi4wqHNrdV9saXN0kKJhb8KidXLCoXGocmVkIGJ1bGyiYXDDomx0zQEToW-pcmVsZXZhbmNlqXNvdXJjZV9pZAGibmbDo21yaQE=&listtype=ps&filters=[]&sorted_on=popularity&slug=#{CGI.escape(search_term)}&tab_type=[%22all%22]",
      vars: {
          'input_type' => 'search',
          'search_term' => search_term,
          'page' => 1
      }


  }

end