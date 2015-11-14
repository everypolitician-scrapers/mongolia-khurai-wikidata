#!/bin/env ruby
# encoding: utf-8

require 'rest-client'
require 'scraperwiki'
require 'wikidata/fetcher'
require 'nokogiri'
require 'colorize'
require 'pry'
require 'open-uri/cached'
OpenURI::Cache.cache_path = '.cache'


def noko_for(url)
  Nokogiri::HTML(open(URI.escape(URI.unescape(url))).read) 
end

def wikinames_from(url)
  noko = noko_for(url)
  names = noko.xpath('//table[@class="navbox"]//table//tr[td]//td[1]//a[not(@class="new")]/@title').map(&:text)
  raise "No names found in #{url}" if names.count.zero?
  return names
end

def fetch_info(names)
  WikiData.ids_from_pages('mn', names).each do |name, id|
    data = WikiData::Fetcher.new(id: id).data('mn', 'ru') rescue nil
    unless data
      warn "No data for #{p}"
      next
    end
    data[:original_wikiname] = name
    ScraperWiki.save_sqlite([:id], data)
  end
end

fetch_info wikinames_from('https://mn.wikipedia.org/wiki/Загвар:2012-2016_оны_УИХ-ын_гишүүд')
warn RestClient.post ENV['MORPH_REBUILDER_URL'], {} if ENV['MORPH_REBUILDER_URL']

