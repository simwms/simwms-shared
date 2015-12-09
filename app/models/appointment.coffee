`import Ember from 'ember'`
`import DS from 'ember-data'`
`import {AppointmentCore} from 'simwms-shared'`

Appointment = DS.Model.extend AppointmentCore,
  logs: DS.hasMany "appointment-log", async: true
  batches: DS.hasMany "batch", async: true
  truck: DS.belongsTo "truck", async: true
  weighticket: DS.belongsTo "weighticket", async: true

`export default Appointment`