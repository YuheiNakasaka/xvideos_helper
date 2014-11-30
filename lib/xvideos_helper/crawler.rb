# coding: utf-8
require 'open-uri'
require "nokogiri"

module XvideosHelper
  class Crawler
    attr_accessor :movies_limit,:tags_limit
    def initialize
      @domain ||= Env::XVIDES_URL_JP
      @iframe_url ||= Env::XVIDES_IFRAME_URL
      @movies_limit ||= -1
      @tags_limit ||= -1
    end

    def get_data_from(url,from)
      begin
        source = html(url)
        if from == 'movie'
          return parsed_movie_data(source)
        elsif from == 'taglist'
          return parsed_tag_data(source)
        else
          return {}
        end
      rescue Exception => e
        raise e
      end
    end

private
    def html(url)
      begin
        return Nokogiri.HTML(open(url).read)
      rescue Exception => e
        raise e
      end
    end

    # main crawler
    def parsed_movie_data(data)
      parsed_data = {}
      index       = 0

      data.xpath('//div[@class="thumbBlock"]/div[@class="thumbInside"]').each do |post|
        begin
          # limit
          break if @movies_limit == index
          parsed_data[index] = {}
          # thumbnail infomation
          post.search('div[@class="thumb"]/a').each do |a|
            parsed_data[index]['movie_page_url'] = "#{@domain}#{a.attribute('href').value}"
            parsed_data[index]['movie_thumnail_url'] = "#{a.children.attribute('src').value}"
          end

          # if script tag is contained
          post.search('script').each do |elm|
            parsed_data[index]['movie_page_url'] = @domain + (elm.children[0].content.match(/href="(.+?)">/))[1]
            parsed_data[index]['movie_thumnail_url'] = (elm.children[0].content.match(/src="(.+?)"/))[1]
            parsed_data[index]['description'] = (elm.children[0].content.match(/<p><a href=".+">(.+)<\/a><\/p>/))[1]
          end

          # movie_id
          parsed_data[index]['movie_id'] = parsed_data[index]['movie_page_url'].match(/\/video(\d+)\/.*/)[1]

          # iframe url
          parsed_data[index]['movie_url'] = @iframe_url + (parsed_data[index]['movie_page_url'].match(/\/video(\d+)\/.*/))[1]

          # description
          post.search('p/a').each do |a|
            parsed_data[index]['description'] = a.inner_text
          end

          # metadata
          post.search('p[@class="metadata"]/span[@class="bg"]').each do |span|
            text = span.inner_text.gsub(/(\t|\s|\n)+/,'')
            parsed_data[index]['duration'] = (text.match(/\(.+\)/))[0]
            parsed_data[index]['movie_quality'] = text.sub(/\(.+\)/,'')
          end
          index += 1
        rescue Exception => e
          raise e
        end
      end
      return parsed_data
    end

    # tag list crawler
    def parsed_tag_data(data)
        parsed_data = {}
        index       = 0
        data.xpath('//div[@id="main"]/ul[@id="tags"]/li').each do |li|
          begin
            # limit
            break if @tags_limit == index
            parsed_data[index] = {}
            # tag info
            parsed_data[index]['tag_name'] = li.children.children.inner_text
            parsed_data[index]['tag_url'] = "#{@domain}#{li.children.attribute('href').value}"
            parsed_data[index]['tag_count'] = li.inner_text.sub(/.+\s/,'')
            index += 1
          rescue Exception => e
            raise e
          end
        end
        return parsed_data
    end
  end
end
