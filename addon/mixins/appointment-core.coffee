`import Ember from 'ember'`
`import DS from 'ember-data'`
`import moment from 'moment'`

{computed, Mixin} = Ember

AppointmentCoreMixin = Mixin.create
  appointmentType: DS.attr "string", defaultValue: "dropoff"
  externalReference: DS.attr "string"
  materialDescription: DS.attr "string"
  permalink: DS.attr "string"
  company: DS.attr "string"
  notes: DS.attr "string"
  createdAt: DS.attr "moment"
  updatedAt: DS.attr "moment"
  expectedAt: DS.attr "moment"
  fulfilledAt: DS.attr "moment"
  cancelledAt: DS.attr "moment"
  explodedAt: DS.attr "moment"

  status: computed "expectedAt", "fulfilledAt", "cancelledAt", "explodedAt", ->
    return "fulfilled" if @get("fulfilledAt")?.isValid()
    return "cancelled" if @get("cancelledAt")?.isValid()
    return "problem" if @get("explodedAt")?.isValid()
    return "problem" unless @get("expectedAt")?.isValid()
    return "vanished" if @get("expectedAt") < moment()
    return "expected" if @get("expectedAt") > moment()
    "unknown"

`export default AppointmentCoreMixin`
