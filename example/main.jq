#!/usr/bin/jq -nf
include "share";
import "data" as $data;
include "lib";

$data | sub::each | extract_data * {c: share::id}
