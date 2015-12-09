`import DS from 'ember-data'`
`import {LogCore} from 'simwms-shared'`

BatchLog = DS.Model.extend LogCore,
  batch: DS.belongsTo "batch", async: true

`export default BatchLog`