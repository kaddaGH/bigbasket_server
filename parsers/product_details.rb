body = Nokogiri.HTML(content)




title = body.at_css(".sc-gJWqzi").text
availability_text=body.at_css('.sc-gPEVay .iMPxg').text rescue ''
if  availability_text=='Out of Stock'
  availability=""
else
  availability="1"
end




products_details = page['vars']['product_details']
description = body.at_css(".dRAsaj div div").text.gsub(/[\s\n,]+/, ' ')

products_details[:PRODUCT_NAME]=title
products_details[:PRODUCT_DESCRIPTION]=description
products_details[:IS_AVAILABLE]=availability


outputs<<products_details