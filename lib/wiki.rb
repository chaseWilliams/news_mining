module Wiki
  WIKI_BASE = 'https://en.wikipedia.org/w/api.php?action=query&format=json&'
  WIKI_RAND = '&list=random&rnlimit=5'
  ARTICLE_BY_TITLE = 'prop=extracts&titles='
  ARTICLE_BY_ID = 'prop=extracts&pageids='
  def self.validate gram
    puts 'validating'
    hash = Hash.new
    gram.tagged.each do |key, value|
      str = key[0].capitalize + "_" + key[1]
      uri = WIKI_BASE + ARTICLE_BY_TITLE + "#{str}"
      result = read uri
      format result
      unless result.nil?
        puts 'adding new extract'
        hash[key] = {
            url: uri,
            extract: result.byteslice(0..1000)
        }
      end
    end
    puts JSON.pretty_generate hash
    # persist hash
  end

  def self.format str
    #format string to remove HTML elements
    begin
      while str.index('<') != nil
        if str.index('>') != nil
          str.slice! (str.index('<')..str.index('>'))
        end
      end
    rescue StandardError
      return str
    end
    return str
  end

  def self.random_article
    uri = WIKI_BASE + WIKI_RAND
    response = JSON.parse RestClient::Request.execute(:url => URI.encode(uri), :method => :get, :verify_ssl => false)
    title = ''
    while title == ''
      response['query']['random'].each {|item| if (item['title'].index ':').nil? then title = item['title'] end}
      response = JSON.parse RestClient::Request.execute(:url => URI.encode(uri), :method => :get, :verify_ssl => false)
    end
    WIKI_BASE + ARTICLE_BY_TITLE + title.gsub(' ', '_')
  end

  def self.read url
    puts 'reading page'
    response = JSON.parse RestClient::Request.execute(:url => URI.encode(url), :method => :get, :verify_ssl => false)
    begin
      hash_keys = response['query']['pages'].keys
      result = response['query']['pages'][hash_keys[0]]['extract']
    rescue NoMethodError
      puts "looks like #{uri} doesn't exist in Wikipedia"
    end
    result
  end
# persist hash to database
  def persist new_vals
    #persist the new values to db
  end
end