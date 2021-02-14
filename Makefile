PORTFOLIO=data/portfolio.ndjson
CABINETCHANGES=data/cabinetchanges.ndjson

init: wikidata $(PORTFOLIO) $(CABINETCHANGES)

$(PORTFOLIO): data/portfolio.xls
	./bin/xls2ndjson $< > $@

$(CABINETCHANGES): data/cabinetchanges.xls
	./bin/xls2ndjson $< > $@

stats: $(PORTFOLIO) wikidata
	@echo "portfolio: " `wc -l < $<`
	@echo " names:    " `jq .minister $< | sort | uniq | wc -l`
	@echo " countries:" `jq .country  $< | sort | uniq | wc -l`
	@echo " rulers:   " `jq .ruler $< | sort | uniq | wc -l`
	@echo " positions:" `jq .position $< | sort | uniq | wc -l`
	@echo "Wikidata:"
	@wc -l states.ndjson
	@wc -l positions.ndjson
	@echo " generic-positions: " `jq keys generic-positions.json | wc -l`

# Get data from Wikidata
wikidata: states.ndjson positions.ndjson generic-positions.json

# Get data about states from Wikidata
states.ndjson: states.rq
	@wd sparql $< | \
	jq -c '.[]|.+{id:.state.value,state:.state.label,demonyms:(.demonyms|split(", "))}' > $@

# Get data about country-specific positions from Wikidata
positions.ndjson: positions.rq
	@wd sparql $< | jq -c '.[]' > $@

generic-positions.json: generic-positions.rq
	@wd sparql $< | jq -f lib/generic-positions.jq > $@
