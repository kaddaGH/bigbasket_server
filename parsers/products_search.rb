data = JSON.parse(content)

scrape_url_nbr_products = data['tab_info'][0]['product_info']['p_count'].to_i
current_page = page['vars']['page']
products = data['tab_info'][0]['product_info']['products']

# if ot's first page , generate pagination
if current_page == 1 and scrape_url_nbr_products > products.length
  nbr_products_pg1 = products.length
  step_page = 1
  while step_page * products.length <= scrape_url_nbr_products and 2 > 4
    step_page = 2
    pages << {
        page_type: 'products_search',
        method: 'GET',
        url: page['url'] + "&page=#{step_page}",
        vars: {
            'input_type' => page['vars']['input_type'],
            'search_term' => page['vars']['search_term'],
            'page' => step_page,
            'nbr_products_pg1' => nbr_products_pg1
        }
    }

    step_page = step_page + 1


  end
elsif current_page == 1 and products.length <= scrape_url_nbr_products
  nbr_products_pg1 = products.length
else
  nbr_products_pg1 = page['vars']['nbr_products_pg1']
end


headers = {
    
    'Accept' => '*/*',
    'Accept-Encoding' => 'gzip, deflate, br',
    'Accept-Language' => 'fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,de-DE;q=0.6,de;q=0.5',
    'Connection' => 'keep-alive',
    'Content-Type' => 'application/json',
    'Host' => 'www.bigbasket.com',
    'Origin' => 'https://www.bigbasket.com',
    'Referer' => 'https://www.bigbasket.com/pd/100012281/red-bull-energy-drink-250-ml-carton/?nc=l3category&t_pg=L3Categories&t_p=l3category&t_s=l3category&t_pos=3&t_ch=desktop',
    'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36',


}


products.each_with_index do |product, i|

  query = '{"query":"\n      query ProductQuery(\n        $id: Int!\n      ) {\n        product(\n          id: $id\n        ) {\n          base_img_url                  \n          ...productFields\n          children {\n            ...productFields\n          }\n        }\n      }\n      fragment productFields on Product {\n        id\n        desc\n        pack_desc\n        sp\n        mrp\n        w\n        images {\n          s\n          m\n          l\n          xl\n          xxl\n        }\n        variable_weight {\n          msg\n          link\n        }\n        discount {\n          type\n          value\n        }\n        brand {\n          name\n          slug\n          url\n        }\n        additional_attr {\n          food_type\n          info {\n            type\n            image\n            sub_type\n            label\n          }\n        }\n        tabs {\n          content\n          title\n        }\n        tags {\n          header\n          values {\n            display_name\n            dest_type\n            dest_slug\n            url\n          }\n        }\n        combo_info {\n          destination {\n            display_name\n            dest_type\n            dest_slug\n            url\n          }\n          total_saving_msg          \n          items{\n            id\n            brand\n            sp\n            mrp\n            is_express\n            saving_msg\n            link\n            img_url\n            qty\n            wgt\n            p_desc\n          }\n          total_sp\n          total_mrp\n          annotation_msg\n        }\n        gift {\n          msg\n        }\n        sale {\n          type\n          display_message\n          end_time\n          maximum_redem_per_order\n          maximum_redem_per_member\n          show_counter\n          message\n          offers_msg\n        }\n        promo {\n          type\n          label\n          id\n          name\n          saving\n          savings_display\n          desc\n          url\n          desc_label\n        }\n        store_availability {\n          tab_type\n          pstat\n          availability_info_id\n          store_id\n        }\n        discounted_price {\n          display_name\n          value\n        }\n      }\n    ","variables":{"id":"product_id","visitorId":"824190617","masterRi":"3630","cityId":"1"}}'


  pages << {
      page_type: 'product_details',
      method: 'POST',
      url: "https://www.bigbasket.com/product/pd/v1/gql?search_term=#{page['vars']['search_term']}&page=#{current_page + 1}&rank=#{ i + 1}",
      body: query.gsub(/product_id/, product['sku'].to_s),
      headers:headers,
      vars: {
          'input_type' => page['vars']['input_type'],
          'search_term' => page['vars']['search_term'],
          'product_rank' => i + 1,
          'page' => current_page,
          'nbr_products_pg1' => nbr_products_pg1,
          'scrape_url_nbr_products' => scrape_url_nbr_products

      }
  }


end

