execFile = (require 'child_process').execFile
koa = require 'koa'


port = process.env.PORT or 3000

app = koa()

app.use (next) ->
  this.child = execFile 'hxnormalize', ['-e']
  yield next

app.use ->
  
  this.req.on 'data', (d) ->
    console.log ">IN> ",d.toString()

  this.req.pipe this.child.stdin
  this.body = this.child.stdout
  # child.stdin.end()

  yield return

app.listen port
console.log "Listening on #{port}"
