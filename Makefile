descriptions-en.json:
	wd sparql descriptions-en.rq | \
	   jq '[.[]|{key:.country,value:(.demonym+" politician")}]|from_entries' > $@

portfolio.ndjson: portfolio.xls
	./xls2ndjson $< > $@

stats: portfolio.ndjson
	@echo "portfolio:" `wc -l < $<`
	@echo "names:    " `jq .minister $< | sort | uniq | wc -l`
	@echo "countries:" `jq .country  $< | sort | uniq | wc -l`
	@echo "rulers:   " `jq .ruler $< | sort | uniq | wc -l`
	@echo "positions:" `jq .position $< | sort | uniq | wc -l`

positions: portfolio.ndjson
	@jq -r .position $< | sort | uniq | \
		perl -pE '$$_ = "Minister of $$_" if $$_ !~ /Minister/'
