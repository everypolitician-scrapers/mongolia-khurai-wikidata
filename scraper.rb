#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'
require 'pry'

mn_names = EveryPolitician::Wikidata.wikipedia_xpath( 
  url: 'https://mn.wikipedia.org/wiki/Загвар:2012-2016_оны_УИХ-ын_гишүүд',
  xpath: '//table[@class="navbox"]//table//tr[td]//td[1]//a[not(@class="new")]/@title',
) 
EveryPolitician::Wikidata.scrape_wikidata(names: { mn: names })
warn EveryPolitician::Wikidata.notify_rebuilder

