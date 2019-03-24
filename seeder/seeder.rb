require 'cgi'


headers ={

    'Accept'=> 'application/json, text/plain, */*',
    'Accept-Encoding'=> 'gzip, deflate, br',
    'Accept-Language'=> 'fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,de-DE;q=0.6,de;q=0.5',
    'Connection'=> 'keep-alive',
    'Cookie'=> '_bb_vid="MjMzNDI0MjY3NA=="; _bb_tc=0; _bb_rdt="MzE1MjUyMjgxNg==.0"; _bb_rd=6; _ga=GA1.2.1478183119.1551443169; _gcl_au=1.1.1343835051.1551443170; _fbp=fb.1.1551443171848.1216155053; cto_lwid=7bf7c1f5-07a6-4200-837d-4ca1a644d076; _vz=viz_5c79250c7a4c8; sessionid=hof2i09hx7usjwqblnk55eovtc5fjmke; _gid=GA1.2.377063592.1553167933; Nprd=5|1553254928611; _client_version=2146; _bb_cid=1; _bb_visaddr="fFZhc2FudGggTmFnYXJ8NzcuNTkyMDI5NXwxMi45OTEwODY5fDU2MDA1Mnw="; _bb_aid="MzAxNzU1NjE5Nw=="; csrftoken=JbsSuxfEchnbeVbJiVYSDlewNH2k0IoDseSg35mYlvKVdE7HSthSuQ2sMKoHg6h7; ts="2019-03-21 21:17:10.059"; _gat=1; bigbasket.com=ae9a85f5-5623-4090-8f97-d9aee0e822a8',
    'Host'=> 'www.bigbasket.com',
    'User-Agent'=> 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36',
    'X-CSRFToken'=> 'JbsSuxfEchnbeVbJiVYSDlewNH2k0IoDseSg35mYlvKVdE7HSthSuQ2sMKoHg6h7',
    'X-Requested-With'=> 'XMLHttpRequest',

}


search_terms = ['Energy Drinks']
search_terms.each do |search_term|

  pages << {
      page_type: 'products_search',
      method: 'GET',
      headers:headers,
      url: "https://www.bigbasket.com/custompage/getsearchdata/?slug=#{CGI.escape(search_term)}&type=deck",
      vars: {
          'input_type' => 'search',
          'search_term' => search_term,
          'page' => 1
      }


  }

end