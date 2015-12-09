`import Ember from 'ember'`

{Service, Evented, RSVP} = Ember

errMsg = """
You tried to create a channel synchronously, 
but the socket hasn't connected yet.

This is likely because you called the `channelSync`
method before the user has successfully logged in his account.
"""
UserSocketService = Service.extend Evented,
  state: "disconnected"
  init: ->
    @_super arguments...
    @set "deferredSocket", RSVP.defer()
  channelSync: (topic) ->
    if @socket?
      @socket.channel topic
    else
      throw new Error errMsg
  channel: (topic) ->
    @get "deferredSocket.promise"
    .then (socket) ->
      socket.channel topic
  instanceInit: (Socket, socketNamespace) ->
    i = @
    @currentUser.on "logout-user", ->
      i?.socket?.disconnect()
    @currentUser.on "login-user", ->
      id = @get("session.id")
      socket = new Socket socketNamespace, params: user_id: id
      i.socket = socket
      socket.connect()
      socket.onOpen ->
        i.set "state", "connected"
        i.get("deferredSocket").resolve(socket)
      socket.onClose ->
        i.set "state", "disconnected"
      socket.onError ->
        if i.get("state") is "disconnected"
          i.get("deferredSocket").reject(socket)
        else
          i.set "state", "error"

`export default UserSocketService`
