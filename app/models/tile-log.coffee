`import DS from 'ember-data'`
`import {LogCore} from 'simwms-shared'`

TileLog = DS.Model.extend LogCore,
  tile: DS.belongsTo "tile", async: true

`export default TileLog`