`import Ember from 'ember'`
`import DS from 'ember-data'`
`import {TileCore} from 'simwms-shared'`

Tile = DS.Model.extend TileCore,
  insertedAt: DS.attr "moment"
  updatedAt: DS.attr "moment"

  cameras: DS.hasMany "camera", async: true
  logs: DS.hasMany "tile-log", async: true
  batches: DS.hasMany "batch", async: true
  
`export default Tile`