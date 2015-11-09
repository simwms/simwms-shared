`import DS from 'ember-data'`

MomentTransform = DS.Transform.extend
  deserialize: (serialized) ->
    moment?serialized

  serialize: (deserialized) ->
    moment?deserialized
    .format()

`export default MomentTransform`
