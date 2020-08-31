# African Cabinets

This git repository contains scripts and tools for [Wikidata project African Cabinets](https://www.wikidata.org/wiki/Wikidata:WikiProject_Africa/Cabinets).

## Requirements

* Node
* jq
* make

## Installation

Install files from this repository and its dependencies:

~~~
git clone https://github.com/nichtich/african-cabinets.git
cd african-cabinets
npm install
~~~

## Usage

The repository contains two independent applications:

* command line scripts for data processing
* a web application to inspect Wikidata

### Data processing

Manually download the following source files from <https://osf.io/3exrk/>:

* `cabinetchanges.xls`
* `portfolio.xls`

Run `make` to convert these Excel files to JSON and to download the current list of states and positions from Wikidata:

    make

Some statistics can be calculated for data analysis

    make stats

To convert all ministers from a country to Wikidata items, call `bin/ministers` with the country name:

    ./bin/ministers Angola

The current version only emits ministers with matching generic position item on Wikidata.

Next step to upload/update items in Wikidata:

* Put credentials in `config.json` (not to be commited!)
* *...not fully implemented yet...*

### Web application

The web application is made available at <http://jakobvoss.de/african-cabinets/>. During development run a hot-reloading server:

    npm run web

Some important lists:

* `generic-positions`: needs to be cleaned up on Wikidata to only contain positions not specific to one country
* ...
