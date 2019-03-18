require 'cgi'
headers = {

    "Accept" => "application/json, text/plain, */*",
    "Accept-Encoding" => "gzip, deflate, br",
    "Accept-Language" => "fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,de-DE;q=0.6,de;q=0.5",
    "Connection" => "keep-alive",
    'Cookie' => '_bb_locSrc=default; _bb_vid="MjMzNDI0MjY3NA=="; _bb_tc=0; _bb_rdt="MzE1MjUyMjgxNg==.0"; _bb_rd=6; _ga=GA1.2.1478183119.1551443169; _gcl_au=1.1.1343835051.1551443170; _fbp=fb.1.1551443171848.1216155053; cto_lwid=7bf7c1f5-07a6-4200-837d-4ca1a644d076; _vz=viz_5c79250c7a4c8; csrftoken=DM7A32Sxrp9pMKLVIpLh77NUqMxfKO35ztVUpzO6PjOjKeOtAsJ4VBk0X66hUBCP; _client_version=2137; sessionid=hof2i09hx7usjwqblnk55eovtc5fjmke; _gid=GA1.2.178164703.1552902597; _bb_cid=18; _bb_aid="MzAxNzUyMjA3MQ=="; Nprd=22|1552989184749; _gat=1; bigbasket.com=3ccf3e95-1d76-4c35-b1b9-b08e6cc33532; ts="2019-03-18 19:00:21.062"',
    "Host" => "www.bigbasket.com",
    "Referer" => "https://www.bigbasket.com/ps/?q=redbull",
    "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36",
    "X-CSRFToken" => "DM7A32Sxrp9pMKLVIpLh77NUqMxfKO35ztVUpzO6PjOjKeOtAsJ4VBk0X66hUBCP",
    "X-Requested-With" => "XMLHttpRequest",


}

pages << {
    page_type: 'products_search',
    method: 'GET',
    headers:headers,
    url: 'https://www.bigbasket.com/product/get-products/?listtype=pc&filters=[]&sorted_on=popularity&slug=sports-energy-drinks&tab_type=[%22all%22]',
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