defmodule CompaShares.Links do
  ##
  # response = HTTPotion.get("https://kueski.com/careers")
  def parse_meta_tag(body) do
    [_ | last] = Regex.run(~r/\<meta name\=\"description\"\s(.*)\>/, body)
    last
     |> List.first
     |> String.replace("content=","")
     |> String.replace("\"","")
     |> String.replace("\s\/","")
  end

  def get_link_body(url) do
    response = HTTPotion.get(url)
    response.body
  end

  def parse_og_image(body) do
    [_ | last] = Regex.run(~r/\<meta property\=\"og\:image\"\s(.*)\>/, body)
    last
     |> List.first
     |> String.replace("content=","")
     |> String.replace("\"","")
     |> String.replace("\s\/","")
  end
end