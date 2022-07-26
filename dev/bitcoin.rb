require 'rest-client'
require 'json'
require 'terminal-table'


dias_mostrados = (ARGV[0] && ARGV[0].include?("-d")) ? ARGV[0].split("=")[1].to_i : 7
# Estamos verificando se existe um parâmetro -d e depois estamos pegando a quantidade de dias passada
# nele (ou a padrão caso ele não exista)



end_date = Date.today.strftime("%Y-%m-%d")
start_date = (Date.today - dias_mostrados).strftime("%Y-%m-%d")

url = 'https://api.coindesk.com/v1/bpi/historical/close.json'

params = "?start=#{start_date}&end=#{end_date}"

response = RestClient.get "https://api.coindesk.com/v1/bpi/historical/close.json?start=2022-06-30&end=2022-07-10", {
  content_type: :json,  
  accept: :json 
}



bpi = JSON.parse(response.body)["bpi"] 



bpi_keys = bpi.keys




table_data = bpi.map.with_index do |(date, value), i|
  [
    Date.parse(date).strftime("%d-%m-%y"),
    "$#{value.to_f}",
    (i > 0 ? (bpi[bpi_keys[i]] > bpi[bpi_keys[i - 1]] ? "🡅" : "🡇" ) : "")

  ]
end

table = Terminal::Table.new :headings => ['Data', 'Valor do Bitcoin', '₿'], :rows => table_data

puts table