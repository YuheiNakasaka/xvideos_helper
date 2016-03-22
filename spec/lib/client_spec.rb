require 'pry'
require 'spec_helper'

describe "XvideosHelper::Client" do
  context 'movies_of' do
    it 'return valid values' do
      @xh = XvideosHelper::Client.new
      lists = @xh.movies_of("http://www.xvideos.com/")
      lists.count.should > 0
      lists.each do |key,list|
        list["movie_url"].should match(/^http:\/\/.+\/\d+$/)
        list["movie_page_url"].should match(/^http:\/\/.+/)
        list["movie_thumnail_url"].should match(/^http:\/\/.+/)
        list["movie_id"].should_not be_nil
        list["description"].should_not be_nil
        list["duration"].should_not be_nil
        list["movie_quality"].should_not be_nil
      end
    end

    it 'raises error if invalid url' do
      @xh = XvideosHelper::Client.new
      lambda {@xh.movies_of("invalid://www.xvideos.com/")}.should raise_error
    end
  end

  context 'tag_data_lists' do
    it 'return valid values' do
      @xh = XvideosHelper::Client.new
      @xh.tag_data_lists.count.should > 0
      @xh.tag_data_lists.each do |key,list|
        list['tag_name'].should_not be_nil
        list['tag_url'].should match(/^http:\/\/.+/)
        list['tag_count'].should_not be_nil
      end
    end

    it 'raises error if invalid url' do
      @xh = XvideosHelper::Client.new
      @xh.tag_url = 'aaaaaaaa'
      lambda {@xh.tag_data_lists}.should raise_error
    end
  end

  context 'movies_limit=' do
    it 'changes limit to 1' do
      @xh = XvideosHelper::Client.new
      @xh.movies_limit = 1
      lists = @xh.movies_of("http://www.xvideos.com/")
      lists.count.should == 1
      lists.each do |key,list|
        list["movie_url"].should match(/^http:\/\/.+\/\d+$/)
        list["movie_page_url"].should match(/^http:\/\/.+/)
        list["movie_thumnail_url"].should match(/^http:\/\/.+/)
        list["movie_id"].should_not be_nil
        list["description"].should_not be_nil
        list["duration"].should_not be_nil
        list["movie_quality"].should_not be_nil
      end
    end

    it 'changes limit to 0' do
      @xh = XvideosHelper::Client.new
      @xh.movies_limit = 0
      lists = @xh.movies_of("http://www.xvideos.com/")
      lists.count.should == 0
      lists.each do |key,list|
        list["movie_url"].should match(/^http:\/\/.+\/\d+$/)
        list["movie_page_url"].should match(/^http:\/\/.+/)
        list["movie_thumnail_url"].should match(/^http:\/\/.+/)
        list["movie_id"].should_not be_nil
        list["description"].should_not be_nil
        list["duration"].should_not be_nil
        list["movie_quality"].should_not be_nil
      end
    end
  end

  context 'tags_limit=' do
    it 'changes limit to 1' do
      @xh = XvideosHelper::Client.new
      @xh.tags_limit = 1
      @xh.tag_data_lists.count.should == 1
      @xh.tag_data_lists.each do |key,list|
        list['tag_name'].should_not be_nil
        list['tag_url'].should match(/^http:\/\/.+/)
        list['tag_count'].should_not be_nil
      end
    end

    it 'changes limit to 0' do
      @xh = XvideosHelper::Client.new
      @xh.tags_limit = 0
      @xh.tag_data_lists.count.should == 0
      @xh.tag_data_lists.each do |key,list|
        list['tag_name'].should_not be_nil
        list['tag_url'].should match(/^http:\/\/.+/)
        list['tag_count'].should_not be_nil
      end
    end
  end

end
