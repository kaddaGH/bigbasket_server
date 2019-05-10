html = content
data = JSON.parse(html.gsub(/<[^<>]*>/, ''))
if data.key?("json_data")
  data = data['json_data']
end


current_page = page['vars']['page']
if current_page == 1
  scrape_url_nbr_products = data['tab_info'][0]['product_info']['p_count'].to_i
  products = data['tab_info'][0]['product_info']['products']
  slug = CGI.escape(data['tab_info'][0]['q']) rescue nil
  if slug.nil?
    slug = CGI.escape(data['tab_info'][0]['header_section']['items'].last['slug']) rescue ""
  end
  session_id = data['tab_info'][0]['sid']
  products_ids = []
else
  scrape_url_nbr_products = page['vars']['scrape_url_nbr_products']
  products_ids = page['vars']['products_ids']
  products = data['tab_info']['product_map']['all']['prods']
  slug = page['vars']['slug']
  session_id = page['vars']['session_id']
end


index = 1
products.each_with_index do |product|

  if product['all_prods'].length>0
    product['all_prods'].each do |all_product|
      products_ids << {

          "product_id" => all_product['sku'].to_s,
          "product_page" => current_page,
          "product_rank" => index

      }

      index=index+1

    end



 else
  products_ids << {

      "product_id" => product['sku'].to_s,
      "product_page" => current_page,
      "product_rank" => index

  }
  index=index+1
  end

end


if current_page == 1 and scrape_url_nbr_products >  products_ids.length and scrape_url_nbr_products > 19
  nbr_products_pg1 =  products_ids.length
elsif current_page == 1 and  products_ids.length <= scrape_url_nbr_products
  nbr_products_pg1 =  products_ids.length
else
  nbr_products_pg1 = page['vars']['nbr_products_pg1']
end

headers = {

    'Host' => 'www.bigbasket.com',
    'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:66.0) Gecko/20100101 Firefox/66.0',
    'Accept' => '*/*',
    'Accept-Language' => 'fr,fr-FR;q=0.8,en-US;q=0.5,en;q=0.3',
    'Accept-Encoding' => 'gzip, deflate, br',
    'Referer' => 'https://www.bigbasket.com/pd/100012281/red-bull-energy-drink-250-ml-carton/?nc=cl-prod-list&t_pg=&t_p=&t_s=cl-prod-list&t_pos=1&t_ch=desktop',
    'Content-Type' => 'application/json',
    'Origin' => 'https://www.bigbasket.com',
    'Content-Length' => '2374',
    'Cookie' => '_bb_vid="MjMzNDI0MjY3NA=="; _bb_tc=0; _bb_rdt="MzE1MjUyMjgxNg==.0"; _bb_rd=6; _ga=GA1.2.1478183119.1551443169; _gcl_au=1.1.1343835051.1551443170; _fbp=fb.1.1551443171848.1216155053; cto_lwid=7bf7c1f5-07a6-4200-837d-4ca1a644d076; _vz=viz_5c79250c7a4c8; sessionid=hof2i09hx7usjwqblnk55eovtc5fjmke; _client_version=2146; _bb_cid=1; _bb_visaddr="fFZhc2FudGggTmFnYXJ8NzcuNTkyMDI5NXwxMi45OTEwODY5fDU2MDA1Mnw="; _bb_aid="MzAxNzU1NjE5Nw=="; csrftoken=FIwwzrSUiuu10P3ocWGkOh0Oyx1ubHEM4yRlSVxy95BtVYrmsRulR5DJdppEcgVM; _gid=GA1.2.67568501.1553610537; Nprd=3|1553696971348; bigbasket.com=05e7186c-9ece-40b5-a6ee-7a4d6caeb989; ts="2019-03-26 22:37:57.114"',

    'DNT' => '1',
    'Connection' => 'keep-alive',
    'Pragma' => 'no-cache',
    'Cache-Control' => 'no-cache',

}



# if there is next page
if scrape_url_nbr_products > products_ids.length and scrape_url_nbr_products > 19 and products.length > 19

  url =   "https://www.bigbasket.com/product/get-products/?slug=#{slug}&tab_type=[%22all%22]&sorted_on=relevance&listtype=ps"

  pages << {
      page_type: 'products_search',
      method: 'GET',
      url: url + "&page=#{current_page + 1}",
      vars: {
          'input_type' => page['vars']['input_type'],
          'search_term' => page['vars']['search_term'],
          'page' => current_page + 1,
          'nbr_products_pg1' => nbr_products_pg1,
          'scrape_url_nbr_products' => scrape_url_nbr_products,
          'products_ids' => products_ids,
          "slug" => slug,
          "session_id" => session_id

      }
  }

# if it's last page
else

    products_ids.each do |product|

      body = '{"query":"query ProductQuery(  $id: Int!) {  product(    id: $id  ) {    base_img_url                      ...productFields    children {      ...productFields    }  }}fragment productFields on Product {  id  desc  pack_desc  sp  mrp  w  images {    s    m    l    xl    xxl  }  variable_weight {    msg    link  }  discount {    type    value  }  brand {    name    slug    url  }  additional_attr {    food_type    info {      type      image      sub_type      label    }  }  tabs {    content    title  }  tags {    header    values {      display_name      dest_type      dest_slug      url    }  }  combo_info {    destination {      display_name      dest_type      dest_slug      url    }    total_saving_msg              items{      id      brand      sp      mrp      is_express      saving_msg      link      img_url      qty      wgt      p_desc    }    total_sp    total_mrp    annotation_msg  }  gift {    msg  }  sale {    type    display_message    end_time    maximum_redem_per_order    maximum_redem_per_member    show_counter    message    offers_msg  }  promo {    type    label    id    name    saving    savings_display    desc    url    desc_label  }  store_availability {    tab_type    pstat    availability_info_id    store_id  }  discounted_price {    display_name    value  }}\n    ","variables":{"id":"' + product["product_id"] + '","visitorId":"820099996","masterRi":"1","cityId":"1"}}'


      pages << {
          page_type: 'product_details',
          method: 'POST',
          headers: headers,
          url: "https://www.bigbasket.com/product/pd/v1/gql?search_term=#{page['vars']['search_term']}&page=#{product["product_page"]}&rank=#{ product["product_rank"]}",
          body: body,
          vars: {
              'input_type' => page['vars']['input_type'],
              'search_term' => page['vars']['search_term'],
              'SCRAPE_URL_NBR_PRODUCTS' => products_ids.length,
              'rank' => product["product_rank"],
              'SCRAPE_URL_NBR_PRODUCTS_PG1' => nbr_products_pg1,
              'page' => product["product_page"]
          }
      }





  end







end




