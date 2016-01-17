#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'
require 'pry'

mn_names = EveryPolitician::Wikidata.wikipedia_xpath( 
  url: 'https://mn.wikipedia.org/wiki/Загвар:2012-2016_оны_УИХ-ын_гишүүд',
  xpath: '//table[@class="navbox"]//table//tr[td]//td[1]//a[not(@class="new")]/@title',
) 

en_names = EveryPolitician::Wikidata.wikipedia_xpath( 
  url: 'https://en.wikipedia.org/wiki/List_of_MPs_elected_in_the_Mongolian_legislative_election,_2012',
  after: '//span[@id="Party_list"]',
  xpath: '//table//td[1]//a[not(@class="new")]/@title',
) 

EveryPolitician::Wikidata.scrape_wikidata(names: { mn: mn_names, en: en_names })
warn EveryPolitician::Wikidata.notify_rebuilder
