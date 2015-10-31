`import DS from 'ember-data'`

Employee = DS.Model.extend
  email: DS.attr "string"
  phone: DS.attr "string"
  picture: DS.attr "string"
  title: DS.attr "string"
  role: DS.attr "string", defaultValue: "none"
  fullName: DS.attr "string", defaultValue: "no name"
  
  tileType: DS.attr "string"
  arrivedAt: DS.attr "moment"
  leftWorkAt: DS.attr "moment"
  createdAt: DS.attr "moment"
  updatedAt: DS.attr "moment"

  tile: DS.belongsTo "tile"

  account: DS.belongsTo "account", async: true
  
  watchTileType: Ember.observer "tile.tileType", ->
    @set "tileType", @get("tile.tileType")

`export default Employee`