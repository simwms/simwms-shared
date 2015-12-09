`import Ember from 'ember'`
{inject, String, RSVP, K, Mixin, computed: {equal}} = Ember
ChanCoreMixin = Mixin.create
  makeTopic: K
  state: "disconnected"
  isConnected: equal "state", "connected"
  isConnecting: equal "state", "connecting"
  isDisconnecting: equal "state", "disconnecting"
  isDisconnected: equal "state", "disconnected"
  socket: inject.service "user-socket"
  store: inject.service "store"
  notify: inject.service "notify"

  connect: (account) ->
    return @p if @get("isConnecting") or @get("isConnected")
    @set "topic", (topic = @makeTopic(account))
    @get("socket").channel(topic)
    .then (chan) =>
      chan.on "notify", (payload) =>
        @trigger "notify", payload
      chan.on "delta", (payload) =>
        @trigger "delta", payload
      chan.on "update", (payload) =>
        @trigger "update", payload.data
      chan.on "destroy", (payload) =>
        @trigger "destroy", payload.data
      @joinChan chan

  joinChan: (chan) ->
    @set "chan", chan
    @p = new RSVP.Promise (resolve, reject) =>
      @set "state", "connecting"
      chan.join()
      .receive "ok", => 
        @set "state", "connected"
        resolve(@)
      .receive "error", (reason) => 
        @set "state", "disconnected"
        reject(reason)
      .receive "timeout", => 
        @set "state", "disconnected"
        reject(@)

  disconnect: ->
    return @p if @get("isDisconnecting") or @get("isDisconnected")
    @p = new RSVP.Promise (resolve, reject) =>
      @set "state", "disconnecting"
      @get "chan"
      .leave()
      .receive "ok", =>
        @set "state", "disconnected"
        resolve @
      .receive "error", =>
        @set "state", "connected"
        reject @
      .receive "timeout", =>
        @set "state", "disconnected"
        resolve @

ChanCoreMixin.dashingularize = (x) ->
  String.dasherize String.singularize x

`export default ChanCoreMixin`
