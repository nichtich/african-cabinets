module {
  name: "towikidata",
  description: "transform ministers to Wikidata items"
};

def position($STATE):
  { 
    value: ("Minister of " + .position), # TODO: look up Wikidata item!
    qualifiers: {
     P580: .startdate,
     P582: .enddate,    # TODO: support ongoing positions
     P624: $STATE.id,   # of
    }
  }
;

# input: array of objects, all with same minister
def person($STATE):
  {
    labels: { en: .[0].minister },    
    descriptions: {
      en: ($STATE.demonyms[0] + " politician") 
    },
    claims: {
      P31: "Q5",
      P39: [ .[] | position($STATE) ]
    },
    SRC: .
  }
;
