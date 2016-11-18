execFile = (require 'child_process').execFile



child = execFile '/usr/bin/env' , ['hxnormalize', '-e']

child.stdout.on 'data' , (data) ->
  console.log "*",data

child.on 'close' , (code) ->
  console.log "closing code:",code

child.stdin.write "<h1>hei sexy"
child.stdin.write "<p>hei sexy"
child.stdin.end()

# child.stdin.write "<dd>hei sexy"
# child.stdin.end()

console.log "init done."
