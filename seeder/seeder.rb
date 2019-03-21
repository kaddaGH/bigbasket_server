require 'cgi'


headers ={

    'Accept'=> 'application/json, text/plain, */*',
    'Accept-Encoding'=> 'gzip, deflate, br',
    'Accept-Language'=> 'fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,de-DE;q=0.6,de;q=0.5',
    'Connection'=> 'keep-alive',
    'Cookie'=> '_bb_vid="MjMzNDI0MjY3NA=="; _bb_tc=0; _bb_rdt="MzE1MjUyMjgxNg==.0"; _bb_rd=6; _ga=GA1.2.1478183119.1551443169; _gcl_au=1.1.1343835051.1551443170; _fbp=fb.1.1551443171848.1216155053; cto_lwid=7bf7c1f5-07a6-4200-837d-4ca1a644d076; _vz=viz_5c79250c7a4c8; sessionid=hof2i09hx7usjwqblnk55eovtc5fjmke; _gid=GA1.2.377063592.1553167933; Nprd=5|1553254928611; _client_version=2146; _bb_cid=1; _gat=1; _fls=true; _bb_visaddr="fFZhc2FudGggTmFnYXJ8NzcuNTkyMDI5NXwxMi45OTEwODY5fDU2MDA1Mnw="; _bb_aid="MzAxNzU1NjE5Nw=="; csrftoken=JbsSuxfEchnbeVbJiVYSDlewNH2k0IoDseSg35mYlvKVdE7HSthSuQ2sMKoHg6h7; bigbasket.com=deab8deb-cf6d-4ae6-b6a3-8f618e66882d',
    'Host'=> 'www.bigbasket.com',
    'Referer'=> 'https://www.bigbasket.com/ps/?q=red%20bull',
    'User-Agent'=> 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36',
    'X-CSRFToken'=> 'JbsSuxfEchnbeVbJiVYSDlewNH2k0IoDseSg35mYlvKVdE7HSthSuQ2sMKoHg6h7',
    'X-Requested-With'=> 'XMLHttpRequest',

}


pages << {
    page_type: 'products_search',
    headers:headers,
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
      headers:headers,
      url: "https://www.bigbasket.com/product/get-products/?sid=Sij0p4yhYwGjbWF2pTMuMi4wqHNrdV9saXN0kKJhb8KidXLCoXGocmVkIGJ1bGyiYXDDomx0zQEToW-pcmVsZXZhbmNlqXNvdXJjZV9pZAGibmbDo21yaQE=&listtype=ps&filters=[]&sorted_on=popularity&slug=#{CGI.escape(search_term)}&tab_type=[%22all%22]",
      vars: {
          'input_type' => 'search',
          'search_term' => search_term,
          'page' => 1
      }


  }

end