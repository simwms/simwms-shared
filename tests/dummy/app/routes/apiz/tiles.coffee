`import Ember from 'ember'`

TilesRoute = Ember.Route.extend
  model: ->
    @store.findAll "tile"

`export default TilesRoute`