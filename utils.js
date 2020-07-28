const fs = require('fs')
const ndjson = require('ndjson')

const states = fs.readFileSync('states.ndjson', 'utf8').split("\n").map(JSON.parse)

function countryByName(name) {
    if (name === "Tanzania") {
      return "Q924"
  }
}

function portfolioOfCountry(country) {
  return fs.createReadStream('portfolio.ndjson').pipe(ndjson.parse())
}

module.exports = { portfolioOfCountry, countryByName }
