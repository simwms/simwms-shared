`import Ember from 'ember'`
`import EmberCPM from 'ember-cpm'`
`import DS from 'ember-data'`

Weighticket = DS.Model.extend
  pounds: DS.attr "number"
  licensePlate: DS.attr "string"
  status: DS.attr "string"
  notes: DS.attr "string"
  finishPounds: DS.attr "number"
  
  updatedAt: DS.attr "moment"
  createdAt: DS.attr "moment"

  pictures: DS.hasMany "picture"
  appointment: DS.belongsTo "appointment", async: true
  truck: DS.belongsTo "truck", async: true
  issuer: DS.belongsTo "tile", async: true
  finisher: DS.belongsTo "tile", async: true
  dock: DS.belongsTo "tile", async: true
  netWeight: EmberCPM.Macros.difference "pounds", "finishPounds"
  
`export default Weighticket`
