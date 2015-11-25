`import Ember from 'ember'`
`import DS from 'ember-data'`
`import {LineCore} from 'simwms-shared'`

Line = DS.Model.extend LineCore,
  insertedAt: DS.attr "moment"
  updatedAt: DS.attr "moment"

`export default Line`