`import Ember from 'ember'`
`import DS from 'ember-data'`

{computed} = Ember
{alias} = computed
  
Truck = DS.Model.extend
  arrivedAt: DS.attr "moment"
  dockedAt: DS.attr "moment"
  undockedAt: DS.attr "moment"
  departedAt: DS.attr "moment"
  appointmentPermalink: DS.attr "string"
  licensePlate: DS.attr "string"

  appointment: DS.belongsTo "appointment", async: true
  weighticket: DS.belongsTo "weighticket", async: true
  
  startTile: DS.belongsTo "tile"
  finishTile: DS.belongsTo "tile"

`export default Truck`
