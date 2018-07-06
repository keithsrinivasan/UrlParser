class UrlParser 
    attr_reader :scheme, :domain, :path, :fragment_id

    def initialize(url)
        @url = url
        @scheme = @url.split('/')[0].split(':')[0]
        @domain = @url.split('/')[2].split(':')[0] 
        if @url.split('/')[2].include? ':' 
            @port = @url.split('/')[2].split(':')[1]
        else 
            @port = nil 
        end
        @path = @url.split('/')[3].split('?')[0]
        @querystring = {}
    end

    def query_string
        qs = @url.split('/')[3].split('?')[1].split('#')[0].split('&')
        qs.each do |item|
            param = item.split('=')
            @querystring[param[0]] = param[1]
        end 
        @querystring
    end

    def path 
        if @path == "" 
            @path = nil
        end 
        @path
    end

    def port 
        if (@port == "" || @port == nil) && scheme == "https"
            @port = 443.to_s
        elsif (@port == "" || @port == nil) && scheme == "http"
            @port = 80.to_s
        end 
        @port
    end

    def fragment_id
        @fragment_id = @url.split('/')[3].split('?')[1].split('#')[1]
    end
end

require_relative "../url_parser" 

describe UrlParser do
  context 'with all parts' do
    before(:each) do
      @new_url = UrlParser.new "http://www.google.com:60/search?q=cat&name=Larry#img=FunnyCat"
    end

    it 'when instantiated should be a member of the UrlParser class' do
      expect(@new_url).to be_a UrlParser
    end

    it 'should have a scheme attribute' do
      expect(@new_url.scheme).to eq("http")
    end

    it 'should have a domain attribute' do
      expect(@new_url.domain).to eq("www.google.com")
    end

    it 'should have a port attribute with the given port number' do
      expect(@new_url.port).to eq("60")
    end

    it 'should have a path attribute' do
      expect(@new_url.path).to eq("search")
    end

    it 'should have a query string attribute that should return a hash of query params' do
      expect(@new_url.query_string).to be_a(Hash)
      expect(@new_url.query_string).to eq({"q" => "cat", "name" => "Larry"})
    end

    it 'should have a fragment id attribute' do
      expect(@new_url.fragment_id).to eq("img=FunnyCat")
    end
  end

  context 'with no path' do
    before(:each) do
      @new_url = UrlParser.new "https://www.google.com/?q=cat#img=FunnyCat"
    end

    it 'should return a nil path' do
      expect(@new_url.path).to be(NIL)
    end

    it 'should be able to have a query string at the root path' do
      expect(@new_url.query_string).to eq({"q" => "cat"})
    end

    it 'should be able to have a fragment id at the root path' do
      expect(@new_url.fragment_id).to eq("img=FunnyCat")
    end
  end

  context 'with a special case' do
    it 'with no port number and a http scheme should default to port 80' do
      insecure_url = UrlParser.new "http://www.google.com/search"
      expect(insecure_url.port).to eq("80")
    end
    it 'with no port number and a https scheme should default to port 443' do
      secure_url = UrlParser.new "https://www.google.com/search"
      expect(secure_url.port).to eq("443")
    end
    it 'a query sting with duplicate params should only return one key value pair' do
      duplicate_param = UrlParser.new "http://www.google.com:60/search?q=cat&q=overwrite#img=FunnyCat"
      expect(duplicate_param.query_string).to eq({"q"=> "overwrite"})
    end
  end
end