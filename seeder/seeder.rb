require 'cgi'


headers = {

    'Accept' => 'application/json, text/plain, */*',
    'Accept-Encoding' => 'gzip, deflate, br',
    'Accept-Language' => 'fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,de-DE;q=0.6,de;q=0.5',
    'Connection' => 'keep-alive',
    'Cookie' => '_bb_locSrc=default; _bb_cid=1; _bb_aid="MzE2OTE4OTIzMg=="; _bb_ftvid="MjM1OTk2NDM2Ng==|Yw0MTkMBBk4vEF5VUFJSCRBRV18DQVhWWhB3LjE="; _bb_vid="MjM1OTk2NDM2Ng=="; _bb_tc=0; _client_version=2171; _bb_rdt="MzE1Mjg4NjA3OA==.0"; _bb_rd=6; sessionid=4yv2ko4jrq829uhh0znrf8f2gxqrhko5; _ga=GA1.2.376097631.1560717593; _gid=GA1.2.1048238646.1560717593; _gat=1; _gcl_au=1.1.1545706021.1560717594; _fbp=fb.1.1560717598734.1937634291; bigbasket.com=447c4a0f-6681-4173-9ffa-26618755eec6; ts="2019-06-17 02:10:23.652"',
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