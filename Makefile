init: wikidata portfolio.ndjson

portfolio.ndjson: portfolio.xls
	./xls2ndjson $< > $@

stats: portfolio.ndjson wikidata
	@echo "portfolio: " `wc -l < $<`
	@echo " names:    " `jq .minister $< | sort | uniq | wc -l`
	@echo " countries:" `jq .country  $< | sort | uniq | wc -l`
	@echo " rulers:   " `jq .ruler $< | sort | uniq | wc -l`
	@echo " positions:" `jq .position $< | sort | uniq | wc -l`
	@echo "Wikidata"
	@echo " states:   " `wc -l states.ndjson`
	@echo " positions:" `wc -l positions.ndjson`

# Get data from Wikidata
wikidata: states.ndjson positions.ndjson

# Get data about states from Wikidata
states.ndjson: states.rq
	@wd sparql $< | jq -c '.[]' > $@

# Get data about country-specific positions from Wikidata, indexed by name
positions.ndjson: positions.rq
	@wd sparql $< | jq -c '.[]' > $@

generic-positions.ndjson: generic-positions.rq
	@wd sparql $< | jq -c '.[]' > $@
