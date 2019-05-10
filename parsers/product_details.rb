data = JSON.parse(content)

product=data['data']['product']




title = product['brand']['name']+' '+product['desc']+', '+product['w']+' '+product['pack_desc']

availability=(product['store_availability'][0]['pstat']=="O") ? "":"1" rescue "1"




description = ''

product['tabs'].each do |tab|

  if tab['title'].include?'About' or tab['title'].include?'Product Info'
    description=description+' '+tab['content']
  end


  
end

description=description.gsub(/[^<>]+<\/style>/,'').gsub(/<[^<>]+>/,' ').gsub(/[\s\n,]+/,' ').strip
description = description.gsub('&bull;','•')
ean = description[/(?<=EAN Code: )(\d+)/]
promotion = product['combo_info']['total_saving_msg']


price = product['sp']

brand = product['brand']['name']

size_info = title
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
    /(\d*[\.,]?\d+)\s*?([Kk][Gg])/,
    /(\d*[\.,]?\d+)\s*?([Gg][Mm])/,
    /(\d*[\.,]?\d+)\s?([Gg])/,
    /(\d*[\.,]?\d+)\s?([Ll]itre)/,
    /(\d*[\.,]?\d+)\s?([Ss]ervings)/,
    /(\d*[\.,]?\d+)\s?([Pp]acket\(?s?\)?)/,
    /(\d*[\.,]?\d+)\s?([Cc]apsules)/,
    /(\d*[\.,]?\d+)\s?([Tt]ablets)/,
    /(\d*[\.,]?\d+)\s?([Tt]ubes)/,
    /(\d*[\.,]?\d+)\s?([Ii]nch)/,

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
    /(\d+)\s?[Cc][Tt]/,
    /(\d+)[\s-]?[Pp]cs/,
    /(\d+)\s?[Pp][Kk]/
].find {|regexp| size_info =~ regexp}
in_pack = match ? $1 : '1'


image = product['base_img_url']+ product['images'][0]['m'] rescue ''

product_details = {
    # - - - - - - - - - - -
    RETAILER_ID: '132',
    RETAILER_NAME: 'bigbasket',
    GEOGRAPHY_NAME: 'IN',
    # - - - - - - - - - - -
    SCRAPE_INPUT_TYPE: page['vars']['input_type'],
    SCRAPE_INPUT_SEARCH_TERM: page['vars']['search_term'],
    SCRAPE_INPUT_CATEGORY: page['vars']['input_type'] == 'taxonomy' ? "Sports & Energy Drinks": '-',
    SCRAPE_URL_NBR_PRODUCTS: page['vars']['SCRAPE_URL_NBR_PRODUCTS'],
    # - - - - - - - - - - -
    SCRAPE_URL_NBR_PROD_PG1: page['vars']['SCRAPE_URL_NBR_PRODUCTS_PG1'],
    # - - - - - - - - - - -
    PRODUCT_BRAND: brand,
    PRODUCT_NAME: title,
    PRODUCT_DESCRIPTION: description,
    PRODUCT_RANK: page['vars']['rank'],
    PRODUCT_PAGE: page['vars']['page'],
    PRODUCT_ID: product['id'],
    PRODUCT_MAIN_IMAGE_URL: image,
    PRODUCT_ITEM_SIZE: item_size,
    PRODUCT_ITEM_SIZE_UOM: uom,
    PRODUCT_ITEM_QTY_IN_PACK: in_pack,
    SALES_PRICE: price,
    EAN: ean,
    PROMOTION_TEXT: promotion,
    IS_AVAILABLE: availability,
    EXTRACTED_ON: Time.now.to_s
}

product_details['_collection'] = 'products'

outputs << product_details





