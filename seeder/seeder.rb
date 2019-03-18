require 'cgi'

headers = {


    'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
    'Accept-Encoding' => 'gzip, deflate, br',
    'Accept-Language' => 'fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,de-DE;q=0.6,de;q=0.5',
    'Cache-Control' => 'max-age=0',
    'Connection' => 'keep-alive',
    'Cookie' => '_bb_locSrc=default; _bb_vid="MjMzNDI0MjY3NA=="; _bb_tc=0; _bb_rdt="MzE1MjUyMjgxNg==.0"; _bb_rd=6; _ga=GA1.2.1478183119.1551443169; _gcl_au=1.1.1343835051.1551443170; _fbp=fb.1.1551443171848.1216155053; cto_lwid=7bf7c1f5-07a6-4200-837d-4ca1a644d076; _vz=viz_5c79250c7a4c8; _client_version=2137; sessionid=hof2i09hx7usjwqblnk55eovtc5fjmke; _gid=GA1.2.178164703.1552902597; _bb_cid=18; _bb_aid="MzAxNzUyMjA3MQ=="; Nprd=28|1552989184749; csrftoken=3TQPxDDSr9mBC67NuqhHTs1tFaTKP2KR03deV62ZNZbQchGigFPfN5fo09x5swNy; bigbasket.com=ed6a4217-7309-4240-b25e-52a3fca7536c; ts="2019-03-18 23:18:16.611"',
    'Host' => 'www.bigbasket.com',
    'Upgrade-Insecure-Requests' => '1',
    'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36',

}


pages << {
    page_type: 'products_search',
    method: 'GET',
    headers:headers,
    url: 'https://www.bigbasket.com/product/get-products/?sid=xWBUI46ibmbDoWMSo21hdqUzLjIuMKJjY60zNTF8MTY5NHwxNzA5qHNrdV9saXN0kKJhb8KidXLComFww6JsdM0D6qNkc2rNHjahb6pwb3B1bGFyaXR5qXNvdXJjZV9pZAGiZHPNA4CjbXJpLA==&listtype=pc&filters=[]&sorted_on=popularity&slug=sports-energy-drinks&tab_type=[%22all%22]',
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
      url: "https://www.bigbasket.com/product/get-products/?sid=WfaAo46hYxKjbWF2pTMuMi4wom5mw6hza3VfbGlzdJCiYW_ConVywqFxrWVuZXJneSBkcmlua3OiYXDDomx0zQPqo2Rzas0eNqFvqXJlbGV2YW5jZalzb3VyY2VfaWQBomRzzQOAo21yaSw=&listtype=ps&filters=[]&sorted_on=popularity&slug=#{CGI.escape(search_term)}&tab_type=[%22all%22]",
      vars: {
          'input_type' => 'search',
          'search_term' => search_term,
          'page' => 1
      }


  }

end