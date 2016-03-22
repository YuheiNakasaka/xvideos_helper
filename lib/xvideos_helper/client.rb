# coding: utf-8
require 'xvideos_helper/env'
require 'xvideos_helper/crawler'

module XvideosHelper
  class Client
    attr_accessor :domain, :tag_url
    def initialize
      @crawler = XvideosHelper::Crawler.new
      @domain ||= Env::XVIDES_URL_WWW
      @tag_url ||= Env::XVIDES_TAG_URL
    end

    # get movie information according to target
    def movies_of(target)
      begin
        return @crawler.get_data_from(target,'movie')
      rescue Exception => e
        raise e
      end
    end

    # tag's url lists
    def tag_data_lists
      begin
        return @crawler.get_data_from(@tag_url,'taglist')
      rescue Exception => e
        raise e
      end
    end

    def movies_limit=(limit)
      @crawler.movies_limit = limit
    end

    def tags_limit=(limit)
      @crawler.tags_limit = limit
    end

  end
end
