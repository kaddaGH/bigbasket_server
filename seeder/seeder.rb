require 'cgi'


headers = {

    'Accept' => 'application/json, text/plain, */*',
    'Accept-Encoding' => 'gzip, deflate, br',
    'Accept-Language' => 'fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,de-DE;q=0.6,de;q=0.5',
    'Connection' => 'keep-alive',
    'Cookie' => '_bb_cid=1; _bb_vid="MjM4MzE3NTU2MA=="; _bb_tc=0; _bb_rdt="MzE1MjgwNDUyOQ==.0"; _bb_rd=6; sessionid=hd7i1lbaqntxcdyjsb225w8spsmpmyu9; _ga=GA1.2.1253197919.1557284407; _gcl_au=1.1.1861207601.1557284412; _fbp=fb.1.1557284416495.450514309; _bb_source=pwa; _client_version=2161; _vz=viz_5cd2b8211e2e1; _gid=GA1.2.230885793.1557677793; _bb_visaddr="fFZhc2FudGggTmFnYXJ8NzcuNTkyMDI5NXwxMi45OTEwODY5fDU2MDA1Mnw="; _bb_aid="MzAxNzU1NjE5Nw=="; csrftoken=a4bIg4LAC7b6yfBuVxwSOWpHdq5k2qZjEkUiUZy0RJ4RjZOo5RvIHWpAaREImPJL; _gat=1; bigbasket.com=3f6f2ea5-edbb-41b7-9780-cb89bc1f3b45; ts="2019-05-12 22:09:08.105"',
    'Host' => 'www.bigbasket.com',
    'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36',
    'X-CSRFToken' => 'a4bIg4LAC7b6yfBuVxwSOWpHdq5k2qZjEkUiUZy0RJ4RjZOo5RvIHWpAaREImPJL',
    'X-Requested-With' => 'XMLHttpRequest',

}


pages << {
    page_type: 'products_search',
    headers: headers,
    method: 'GET',
    url: 'https://www.bigbasket.com/product/get-products/?sid=m124sI6ibmbDoWMBo21hdqUzLjIuMKJjY60zNTF8MTY5NHwxNzA5qHNrdV9saXN0kKJhb8KidXLComFww6JsdM0BG6Nkc2pNoW-qcG9wdWxhcml0eaVzcl9pZAGiZHPNAS-jbXJpzQ4u&listtype=pc&filters=[]&sorted_on=popularity&slug=sports-energy-drinks&tab_type=[%22all%22]',
    vars: {
        'input_type' => 'taxonomy',
        'search_term' => '-',
        'page' => 1
    }


}
search_terms = ['Red Bull', 'Energy Drink', 'Energy Drinks']
search_terms.each do |search_term|
  pages << {
      page_type: 'products_search',
      method: 'GET',
      headers: headers,
      url: "https://www.bigbasket.com/custompage/getsearchdata/?slug=#{CGI.escape(search_term)}&type=deck",
      vars: {
          'input_type' => 'search',
          'search_term' => search_term,
          'page' => 1
      }


  }

end