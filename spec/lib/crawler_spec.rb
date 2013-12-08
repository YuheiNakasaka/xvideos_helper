require 'spec_helper'

describe "XvideosHelper::Crawler" do
  context 'get_data_from' do
    it 'return valid movie information' do
      @xh = XvideosHelper::Crawler.new
      lists = @xh.get_data_from("http://jp.xvideos.com/",'movie')
      lists.count.should > 0
      lists.each do |key,list|
        list["movie_url"].should match(/^http:\/\/.+\/\d+$/)
        list["movie_page_url"].should match(/^http:\/\/.+/)
        list["movie_thumnail_url"].should match(/^http:\/\/.+/)
        list["description"].should_not be_nil
        list["duration"].should_not be_nil
        list["movie_quality"].should_not be_nil
      end
    end

    it 'return 0 movie information' do
      @xh = XvideosHelper::Crawler.new
      @xh.movies_limit = 0
      lists = @xh.get_data_from("http://jp.xvideos.com/",'movie')
      lists.count.should == 0
      lists.each do |key,list|
        list["movie_url"].should match(/^http:\/\/.+\/\d+$/)
        list["movie_page_url"].should match(/^http:\/\/.+/)
        list["movie_thumnail_url"].should match(/^http:\/\/.+/)
        list["description"].should_not be_nil
        list["duration"].should_not be_nil
        list["movie_quality"].should_not be_nil
      end
    end

    it 'return 1 movie information' do
      @xh = XvideosHelper::Crawler.new
      @xh.movies_limit = 1
      lists = @xh.get_data_from("http://jp.xvideos.com/",'movie')
      lists.count.should == 1
      lists.each do |key,list|
        list["movie_url"].should match(/^http:\/\/.+\/\d+$/)
        list["movie_page_url"].should match(/^http:\/\/.+/)
        list["movie_thumnail_url"].should match(/^http:\/\/.+/)
        list["description"].should_not be_nil
        list["duration"].should_not be_nil
        list["movie_quality"].should_not be_nil
      end
    end

    it 'return valid tag lists' do
      @xh = XvideosHelper::Crawler.new
      lists = @xh.get_data_from("http://jp.xvideos.com/tags",'taglist')
      lists.count.should > 0
      lists.each do |key,list|
        list['tag_name'].should_not be_nil
        list['tag_url'].should match(/^http:\/\/.+/)
        list['tag_count'].should_not be_nil
      end
    end

    it 'return 0 tag list' do
      @xh = XvideosHelper::Crawler.new
      @xh.tags_limit = 0
      lists = @xh.get_data_from("http://jp.xvideos.com/tags",'taglist')
      lists.count.should == 0
      lists.each do |key,list|
        list['tag_name'].should_not be_nil
        list['tag_url'].should match(/^http:\/\/.+/)
        list['tag_count'].should_not be_nil
      end
    end

    it 'return 1 tag list' do
      @xh = XvideosHelper::Crawler.new
      @xh.tags_limit = 1
      lists = @xh.get_data_from("http://jp.xvideos.com/tags",'taglist')
      lists.count.should == 1
      lists.each do |key,list|
        list['tag_name'].should_not be_nil
        list['tag_url'].should match(/^http:\/\/.+/)
        list['tag_count'].should_not be_nil
      end
    end

    it 'return empty object if undifined name or the other objects' do
      @xh = XvideosHelper::Crawler.new
      lists = @xh.get_data_from("http://jp.xvideos.com/",'undifined_name')
      lists.should == {}
      lists = @xh.get_data_from("http://jp.xvideos.com/",{})
      lists.should == {}
      lists = @xh.get_data_from("http://jp.xvideos.com/",[])
      lists.should == {}
    end

    it 'raises error if invalid url' do
      @xh = XvideosHelper::Crawler.new
      lambda {@xh.movies_of("invalid://jp.xvideos.com/",'movie')}.should raise_error
    end
  end

end