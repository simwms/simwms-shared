`import DS from 'ember-data'`

Employee = DS.Model.extend
  fullName: DS.attr "string"
  title: DS.attr "string"
  tileType: DS.attr "string"
  arrivedAt: DS.attr "moment"
  leftWorkAt: DS.attr "moment"
  phone: DS.attr "string"
  email: DS.attr "string"
  createdAt: DS.attr "moment"
  updatedAt: DS.attr "moment"
  tile: DS.belongsTo "tile"

  account: DS.belongsTo "account", async: true

  watchTileType: Ember.observer "tile.tileType", ->
    @set "tileType", @get("tile.tileType")

`export default Employee`