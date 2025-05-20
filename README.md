Package a simple [jq-lang] dependency tree into a single file

# Example

```
jqpack $ cd example/
example $ ../jqpack main.jq > out.jq
- include share.jq                               from share.jq
- import  data.json             as $data         from data.json
- include lib.jq                                 from lib.jq
  - include sub.jq                               from sub.jq
  - include share.jq                             from share.jq (cached)
example $ chmod a+x out.jq
example $ ./out.jq
{
  "a": 2,
  "b": 3,
  "c": 4
}
example $ cat out.jq
#!/usr/bin/jq -nf
# share.jq
def share::id: 4;
# data.json
[{"a":{"foo":2},"b":{"foo":1}}] as $data |
# sub.jq
def each: .[];
# lib.jq

def sub::each: each; # re-export
def extract_data: map_values(share::id - .foo);
# main.jq
#!/usr/bin/jq -nf

$data | sub::each | extract_data * {c: share::id}
```

[jq-lang]: https://github.com/jqlang/jq
