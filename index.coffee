koa = require 'koa'
{spawn} = require 'duplex-child-process'


port = process.env.PORT or 3000

app = koa()

# prepare CHILD-PROC
app.use (next) ->

  # TODO grab from pool or STUFF
  this.hxNorm = hxNorm = spawn 'hxnormalize', ['-e']

  hxNorm.on 'error', (err) ->
    console.error "hxNorn ERR:",err.message
    hxNorm.push null

  hxNorm.on 'exit', (code,signal) ->
    console.log 'child',code,signal

  yield next
  console.log "back at proc init"

# MAN HANDLER
app.use ->
  this.body = this.req.pipe this.hxNorm
  yield return

# TODO spawn more duplexes based on URI



app.listen port
console.log "#{process.pid} listening on #{port}"
