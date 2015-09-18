`import Ember from 'ember'`

every = (time, action) -> setInterval action, time

poll = (obj) ->
  until: (check) ->
    new Ember.RSVP.Promise (resolve) ->
      watcher = every 15, -> 
        resolve clearInterval watcher if check obj

andAfterward = (app, action) ->
  poll app.__container__.lookup "controller:application"
  .until (controller) -> controller.get("workersUnion.isBusy") isnt true
  .then ->
    app.testHelpers.andThen action

`export default Ember.Test.registerAsyncHelper('andAfterward', andAfterward)`
