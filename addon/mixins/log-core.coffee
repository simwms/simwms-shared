`import Ember from 'ember'`
`import DS from 'ember-data'`

LogCoreMixin = Ember.Mixin.create
  assocType: DS.attr "string"
  assocId: DS.attr "string"
  eventName: DS.attr "string"
  eventMessage: DS.attr "string"

  insertedAt: DS.attr "moment"
  updatedAt: DS.attr "moment"
  scheduledAt: DS.attr "moment"
  happenedAt: DS.attr "moment"

`export default LogCoreMixin`
