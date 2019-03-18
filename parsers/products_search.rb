data = JSON.parse(content)

scrape_url_nbr_products = data['tab_info'][0]['product_info']['p_count'].to_i

current_page = page['vars']['page']
products = data['tab_info'][0]['product_info']['products']

# if ot's first page , generate pagination
if current_page == 1 and scrape_url_nbr_products > products.length and 2<1
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


products.each_with_index do |product, i|



discount= product['dis_val'].to_i  rescue 0
promotion=''
if discount>0
  if product['dis_t']=='A'
    promotion= "SAVE Rs "+product['dis_val']
  else
    promotion= "Get "+product['dis_val']+"% off"
  end


end




price = product['sp']

brand = product['p_brand']

size_info = product['w']
[
    /(\d*[\.,]?\d+)\s?([Ff][Ll]\.?\s?[Oo][Zz])/,
    /(\d*[\.,]?\d+)\s?([Oo][Zz])/,
    /(\d*[\.,]?\d+)\s?([Ff][Oo])/,
    /(\d*[\.,]?\d+)\s?([Ee][Aa])/,
    /(\d*[\.,]?\d+)\s?([Ff][Zz])/,
    /(\d*[\.,]?\d+)\s?(Fluid Ounces?)/,
    /(\d*[\.,]?\d+)\s?([Oo]unce)/,
    /(\d*[\.,]?\d+)\s?([Mm][Ll])/,
    /(\d*[\.,]?\d+)\s?([Ll])/,
    /(\d*[\.,]?\d+)\s?([Kk][Gg])/,
    /(\d*[\.,]?\d+)\s?([Gg])/,
    /(\d*[\.,]?\d+)\s?([Ll]itre)/,
    /(\d*[\.,]?\d+)\s?([Ss]ervings)/,
    /(\d*[\.,]?\d+)\s?([Pp]acket\(?s?\)?)/,
    /(\d*[\.,]?\d+)\s?([Cc]apsules)/,
    /(\d*[\.,]?\d+)\s?([Tt]ablets)/,
    /(\d*[\.,]?\d+)\s?([Tt]ubes)/,
    /(\d*[\.,]?\d+)\s?([Cc]hews)/


].find {|regexp| size_info =~ regexp}
uom = $2
item_size = $1

match = [
    /(\d+)\s?[xX]/,
    /Pack of (\d+)/,
    /Box of (\d+)/,
    /Case of (\d+)/,
    /(\d+)\s?[Cc]ount/,
    /(\d+)\s?[Cc][Tt]/,
    /(\d+)[\s-]?[Pp]ack($|[^e])/,
    /(\d+)\s?[Pp][Kk]/
].find {|regexp| size_info  =~ regexp}
in_pack = match ? $1 : '1'


is_available = "1"
image = "https:"+product['p_img_url'] rescue ''

product_details = {
    # - - - - - - - - - - -
    RETAILER_ID: '132',
    RETAILER_NAME: 'bigbasket',
    GEOGRAPHY_NAME: 'IN',
    # - - - - - - - - - - -
    SCRAPE_INPUT_TYPE: page['vars']['input_type'],
    SCRAPE_INPUT_SEARCH_TERM: page['vars']['search_term'],
    SCRAPE_INPUT_CATEGORY: page['vars']['input_type'] == 'taxonomy' ? 'Sports & Energy Drinks' : '-',
    SCRAPE_URL_NBR_PRODUCTS: scrape_url_nbr_products,
    # - - - - - - - - - - -
    SCRAPE_URL_NBR_PROD_PG1: nbr_products_pg1,
    # - - - - - - - - - - -
    PRODUCT_BRAND: brand,
    PRODUCT_RANK: i+1,
    PRODUCT_PAGE: page['vars']['page'],
    PRODUCT_ID: product['sku'],
    PRODUCT_MAIN_IMAGE_URL:image,
    PRODUCT_ITEM_SIZE: item_size,
    PRODUCT_ITEM_SIZE_UOM: uom,
    PRODUCT_ITEM_QTY_IN_PACK: in_pack,
    SALES_PRICE: price,
    IS_AVAILABLE: is_available,
    PROMOTION_TEXT: promotion,
    EXTRACTED_ON: Time.now.to_s
}

product_details['_collection'] = 'products'






pages << {
      page_type: 'product_details',
      method: 'POST',
      url: "https://www.bigbasket.com/pd/#{product['sku'].to_s}/product/?search_term=#{page['vars']['search_term']}&page=#{current_page + 1}&rank=#{ i + 1}",
      fetch_type:"fullbrowser",
      vars: {

              'product_details' => product_details

      }
  }


end

