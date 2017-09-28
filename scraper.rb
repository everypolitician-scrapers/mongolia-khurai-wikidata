#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'
require 'pry'

mn_names = EveryPolitician::Wikidata.wikipedia_xpath( 
  url: 'https://mn.wikipedia.org/wiki/Загвар:2012-2016_оны_УИХ-ын_гишүүд',
  xpath: '//div[@class="navbox"]//table//tr[td]//td[1]//a[not(@class="new")]/@title',
)

en_names = EveryPolitician::Wikidata.morph_wikinames(source: 'everypolitician-scrapers/mongolia-khurai-wp-multiple-terms', column: 'wikiname')

sparq = <<EOQ
  SELECT ?item WHERE {
    VALUES ?term { wd:Q28112313 wd:Q28112515 wd:Q28112522 }
    ?item p:P39 [ ps:P39 wd:Q21328637 ; pq:P2937 ?term ]
  }
EOQ
ids = EveryPolitician::Wikidata.sparql(sparq)

EveryPolitician::Wikidata.scrape_wikidata(ids: ids, names: { mn: mn_names, en: en_names })
