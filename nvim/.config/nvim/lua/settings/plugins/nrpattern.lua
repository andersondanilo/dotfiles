local patterns = require"nrpattern.default"

patterns[{"yes", "no"}] = {priority = 5}
patterns[{"True", "False"}] = {priority = 5}
patterns[{"TRUE", "FALSE"}] = {priority = 5}

return patterns
