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


Add CommentCollapse 

new messages

Clay Terry6:51 PM
added this Markdown (raw) snippet: README.md 
# URL Parser
In this project we will learn a variety of topics that range from test driven development to object oriented programming, and take a look ahead to some of next weeks topics.

### The Assignment
Before you go any further, take a look at the Url Parser Infographic to get a better grasp on the parts of a url.

![Url parser Infographic](./url_infographic.png)

The goal of the assignment is to be able to instantiate a new instance of the `UrlParser` class by passing it a string url, and then be able to access all of the parts of the url from that new object.

For example, I should be able to do the following:

- Instantiate a new instance of a `UrlParser`
```ruby
    github_url = UrlParser.new "https://github.com/search?q=ruby#stuff"
```
- Calling the following methods on _that_ instance should return the following results:
```bash
    github_url.scheme
    => "https"
    github_url.domain
    => "github.com"
    github_url.port
    => "443"
    github_url.path
    => "search"
    github.query_string
    => {"q" => "ruby"}
    github_url.fragment_id
    => "stuff"
```
- Pass all the provided rspec tests.

### Setting Up
- From the the terminal `cd` into your `projects` folder

- Once inside the `projects` folder, create the directory for your new project
```bash
    mkdir url_parser
    cd url_parser
```
- Now that you have an empty directory for your new project, we are going to set up the proper file structure. Inside of the `url_parser` folder, create a file named `url_parser.rb`
```bash
    touch url_parser.rb
```
- Great! Now lets create the `spec` folder for our test file, and `touch` the spec file inside that folder
```bash
    mkdir spec
    touch spec/url_parser_spec.rb
```

- Boom! We should have the proper directory structure set up for our project.

- Next we need to copy the code from the `spec/url_parser_spec.rb` in this repository into our newly-created `spec/url_parser_spec.rb` file.

### Getting Started

- Now that we have the rspec tests in the proper place we need to require the
`url_parser.rb` at the top of the spec file.

- Great! Now in your terminal run the tests by executing the command :
```bash
    rspec -fd -c
```
##### This should throw us an error `Uninitialized constant UrlParser(nameError)`. That's because we haven't made the `UrlParser` class yet in the `url_parser.rb` file.

- Create that class, run the spec again and we should see a bunch of failing tests!

- We're off to the races, now go write the code to make all those tests pass!  



### Advice
Good luck! Remember our process of red, green, refactor. Work on one test at a time,
get that spec to pass, then refactor. Then move on to the next test.

Oh, and do not change the tests!