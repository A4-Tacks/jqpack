include "sub";
include "share";

def sub::each: each; # re-export
def extract_data: map_values(share::id - .foo);
