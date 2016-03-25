#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'
require 'pry'

mn_names = EveryPolitician::Wikidata.wikipedia_xpath( 
  url: 'https://mn.wikipedia.org/wiki/Загвар:2012-2016_оны_УИХ-ын_гишүүд',
  xpath: '//table[@class="navbox"]//table//tr[td]//td[1]//a[not(@class="new")]/@title',
) 

en_names = EveryPolitician::Wikidata.morph_wikinames(source: 'tmtmtmtm/mongolia-khurai-wp', column: 'wikiname')

EveryPolitician::Wikidata.scrape_wikidata(names: { mn: mn_names, en: en_names })
