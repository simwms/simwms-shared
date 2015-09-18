`import DS from 'ember-data'`

Employee = DS.Model.extend
  fullName: DS.attr "string", defaultValue: "no name"
  title: DS.attr "string"
  tileType: DS.attr "string"
  arrivedAt: DS.attr "date"
  leftWorkAt: DS.attr "date"
  phone: DS.attr "string"
  email: DS.attr "string"
  createdAt: DS.attr "date"
  updatedAt: DS.attr "date"
  role: DS.attr "string", defaultValue: "none"
  picture: DS.attr "string"

  tile: DS.belongsTo "tile"

  account: DS.belongsTo "account", async: true

  watchTileType: Ember.observer "tile.tileType", ->
    @set "tileType", @get("tile.tileType")

`export default Employee`