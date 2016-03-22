# XvideosHelper

XvideosHelper is a gem to support for adult site creater.

This gem provides xvideo's data like movie url or movie page url for you with scraping the site easily.

So, if you use this gem in production, please cache the results.

### Notice

Now, there is the html difference between www.xvideos.com and **.xvideos.com.

XvideosHelper only supports www.xvideos.com.

## Installation

Add this line to your application's Gemfile:

    gem 'xvideos_helper'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install xvideos_helper

## Usage

### movies_of(target_url)

- Get movie data

```ruby
    require 'xvideos_helper'
    adult = XvideosHelper::Client.new
    movie_data = adult.movies_of('http://www.xvideos.com') # default 35 objects
```

- return

```ruby
    {
      0 => {
        "movie_url" => "http://flashservice.xvideos.com/embedframe/6243093",
        "movie_page_url"=> "http://www.xvideos.com/video2017657/0/jp_kyoko_ayana_qc05-02_by_zeus4096_asian_cumshots_asian_swallow_japanese_chinese",
        "movie_thumnail_url"=> "http://img100.xvideos.com/videos/thumbs/46/a0/69/46a069b72731e3c22ddf917d9fb1cbca/46a069b72731e3c22ddf917d9fb1cbca.4.jpg",
        "movie_id"=>"9750364",
        "description"=>"Jp Kyoko Ayana Qc05-02 By Zeus4096 asian  ...",
        "duration"=>"(19min)",
        "movie_quality"=>"Pornquality:98%"
      },
      1 => {
        ...
      }
    }
```

### tag_data_lists

- Get all tags data

```ruby
    require 'xvideos_helper'
    sexy = XvideosHelper::Client.new
    tags_data = sexy.tag_data_lists # default 1997 objects

```

- return

```ruby
    {
      0 => {
        tag_name => 'sex'
        tag_url => 'http://www.xvideos.com/tags/sex'
        tag_count => 320165
      },
      1 => {
        ...
      },
    }
```

### define limit

- movie

```ruby
    require 'xvideos_helper'
    adult = XvideosHelper::Client.new
    adult.movies_limit = 10
    movie_data = adult.movies_of('http://www.xvideos.com') # return 10 objects
```

- tag

```ruby
    require 'xvideos_helper'
    sexy.tags_limit = 10
    tags_data = sexy.tag_data_lists # return 10 objects
```
## example

- Get movie information from HOME.

```ruby
    adult = XvideosHelper::Client.new
    movie_data = adult.movies_of('http://www.xvideos.com')
```

- Get movie information from 10 tag pages.

```ruby
    adult = XvideosHelper::Client.new
    adult.tags_limit = 10
    tags_data = adult.tag_data_lists
    tag_movie_data = []
    tags_data.each do |k,v|
      tag_movie_data << adult.movies_of("http://www.xvideos.com/tags/#{v["tag_name"]}")
    end
```

- Get popular movie information.

```ruby
adult = XvideosHelper::Client.new
movie_data = adult.movies_of("http://www.xvideos.com/best/")
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
