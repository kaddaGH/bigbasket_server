html = content
data = JSON.parse(html.gsub(/<[^<>]*>/, ''))
if data.key?("json_data")
  data = data['json_data']
end

current_page = page['vars']['page']
if current_page == 1
  scrape_url_nbr_products = data['tab_info'][0]['product_info']['p_count'].to_i
  products = data['tab_info'][0]['product_info']['products']
  products_ids=[]
else
  scrape_url_nbr_products = page['vars']['scrape_url_nbr_products']
  products_ids= page['vars']['products_ids']
  products = data['tab_info']['product_map']['all']['prods']
end

slug= CGI.escape(data['tab_info'][0]['q']) rescue ''
# if ot's first page , generate pagination
if current_page == 1 and scrape_url_nbr_products > products.length and scrape_url_nbr_products>19
  nbr_products_pg1 = products.length
  step_page = 1
  while step_page * products.length <= scrape_url_nbr_products

        step_page = step_page + 1
        url = "https://www.bigbasket.com/product/get-products/?sid=#{data['tab_info'][0]['sid']}&listtype=ps&filters=[]&sorted_on=popularity&slug=#{slug}&tab_type=[%22all%22]"

        pages << {
        page_type: 'products_search',
        method: 'GET',
        url: url + "&page=#{step_page}",
        vars: {
            'input_type' => page['vars']['input_type'],
            'search_term' => page['vars']['search_term'],
            'page' => step_page,
            'nbr_products_pg1' => nbr_products_pg1,
            'scrape_url_nbr_products' => scrape_url_nbr_products,
            'products_ids'=>products_ids

        }
    }


  end
elsif current_page == 1 and products.length <= scrape_url_nbr_products
  nbr_products_pg1 = products.length
else
  nbr_products_pg1 = page['vars']['nbr_products_pg1']
end


products.each_with_index do |product|
  products_ids<<product['sku'].to_s
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
    'Cookie' => '_bb_locSrc=default; _bb_cid=1; ts="2019-03-21 16:03:44.725"; _bb_aid="MzE2OTE4OTIzMg=="; _bb_vid="MjMyOTk0Njc0Mw=="; _bb_tc=0; _client_version=2145; _bb_rdt="MzE1MjE4MDQyMg==.0"; _bb_rd=6; sessionid=ty7ji0z25o232d27x09eqodmafhe31fi; bigbasket.com=b79397f6-d43a-42b3-ada0-eebf3215c4d6; _ga=GA1.2.378761513.1551956329; csrftoken=mPnduUJ5DMss8pydbizQKdLnCcas4PntGS2PNaDLhz75RhXT6pgbRobaP9FkkDNc; _gcl_au=1.1.141212324.1551972744; _vz=viz_5c813989e422f; _fbp=fb.1.1551972758522.1358811859; cto_lwid=80d974a1-6bce-4da9-a341-ed43c06f2c8a; cto_idcpy=515f857f-ea3a-447c-b666-c4c9e5f4ffcd; _gid=GA1.2.1832922611.1553163987; Nprd=2|1553250475070; _gat=1; criteo_write_test=ChUIBBINbXlHb29nbGVSdGJJZBgBIAE',

    'DNT' => '1',
    'Connection' => 'keep-alive',
    'Pragma' => 'no-cache',
    'Cache-Control' => 'no-cache',

}


if current_page * 20 > scrape_url_nbr_products
  rank = 1
  products_ids.each_with_index do |product_id|

    body = '{"query":"query ProductQuery(  $id: Int!) {  product(    id: $id  ) {    base_img_url                      ...productFields    children {      ...productFields    }  }}fragment productFields on Product {  id  desc  pack_desc  sp  mrp  w  images {    s    m    l    xl    xxl  }  variable_weight {    msg    link  }  discount {    type    value  }  brand {    name    slug    url  }  additional_attr {    food_type    info {      type      image      sub_type      label    }  }  tabs {    content    title  }  tags {    header    values {      display_name      dest_type      dest_slug      url    }  }  combo_info {    destination {      display_name      dest_type      dest_slug      url    }    total_saving_msg              items{      id      brand      sp      mrp      is_express      saving_msg      link      img_url      qty      wgt      p_desc    }    total_sp    total_mrp    annotation_msg  }  gift {    msg  }  sale {    type    display_message    end_time    maximum_redem_per_order    maximum_redem_per_member    show_counter    message    offers_msg  }  promo {    type    label    id    name    saving    savings_display    desc    url    desc_label  }  store_availability {    tab_type    pstat    availability_info_id    store_id  }  discounted_price {    display_name    value  }}\n    ","variables":{"id":"' + product_id + '","visitorId":"824190617","masterRi":"3630","cityId":"1"}}'


    pages << {
        page_type: 'product_details',
        method: 'POST',
        headers:headers,
        url: "https://www.bigbasket.com/product/pd/v2/gql?search_term=#{page['vars']['search_term']}&page=#{current_page + 1}&rank=#{ rank}",
        body: body,
        vars: {
            'input_type' => page['vars']['input_type'],
            'search_term' => page['vars']['search_term'],
            'SCRAPE_URL_NBR_PRODUCTS' => products_ids.length,
            'rank' => rank,
            'SCRAPE_URL_NBR_PRODUCTS_PG1' => nbr_products_pg1,
            'page' => current_page
        }
    }
    rank=rank+1
    if rank>20
      rank=1
    end


  end






end




