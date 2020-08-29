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

...

### Web application

The web application is made available at <http://jakobvoss.de/african-cabinets/>. During development run a hot-reloading server:

    npm run web

