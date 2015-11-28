`import DS from 'ember-data'`
`import moment from 'moment'`

MomentTransform = DS.Transform.extend
  deserialize: (serialized) ->
    moment serialized

  serialize: (deserialized) ->
    moment deserialized
    .format()

`export default MomentTransform`
