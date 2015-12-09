`import DS from 'ember-data'`

Batch = DS.Model.extend
  batchType: DS.attr "string", defaultValue: "incoming"
  permalink: DS.attr "string"
  description: DS.attr "string"
  quantity: DS.attr "string"
  deletedAt: DS.attr "moment"
  createdAt: DS.attr "moment"
  updatedAt: DS.attr "moment"
  
  warehouse: DS.belongsTo "tile", async: true
  logs: DS.hasMany "batch-log", async: true

`export default Batch`