module {
  name: "towikidata",
  description: "transform ministers to Wikidata items",
  jq: "1.5"
};

def minister($POSITIONS):
    $POSITIONS[ ("Minister of " + .) | ascii_downcase ]
;

def date:
  split("T")|.[0]
;

def position($STATE; $POSITIONS):
  (.position | minister($POSITIONS)) as $POS |
  if $POS then
  { 
    value: $POS,
    qualifiers: {
     P580: .startdate|date,
     P582: .enddate|date,    # TODO: support ongoing positions
     P642: $STATE.id,        # of
    }
  }
  else
     ( "Position not found: " + .position | stderr ) | empty
  end
;

# input: array of objects, all with same minister
def person($STATE; $POSITIONS):
  {
    labels: { en: .[0].minister },    
    descriptions: {
      en: ($STATE.demonyms[0] + " politician") 
    },
    claims: {
      P31: "Q5",
      P39: [ .[] | position($STATE; $POSITIONS) ]
    }
  } 
  | select(.claims.P39|length>0)
;
