`import Ember from 'ember'`
`import DS from 'ember-data'`
`import {TileCore} from 'simwms-shared'`

Tile = DS.Model.extend TileCore,
  insertedAt: DS.attr "moment"
  updatedAt: DS.attr "moment"

`export default Tile`