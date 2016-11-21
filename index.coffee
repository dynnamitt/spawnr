fs = require "fs"
koa = require 'koa'
_ = require 'highland'
{spawn} = require 'duplex-child-process'


port = process.env.PORT or 3000

app = koa()


# prepare CHILD-PROC
app.use (next) ->

  # TODO grab from pool or STUFF
  this.hxNorm = hxNorm = spawn 'hxnormalize',['-e'], silent:yes
  hxNorm.on 'error', (err) ->
    console.error "hxNorn ERR:",err.message
    hxNorm.push null

  yield next
  console.log "back at proc init"

# MAN HANDLER
app.use ->
  this.body = this.req.pipe this.hxNorm
  yield return


app.listen port
console.log "Listening on #{port}"
