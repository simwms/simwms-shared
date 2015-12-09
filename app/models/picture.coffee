`import DS from 'ember-data'`

Picture = DS.Model.extend
  assocId: DS.attr "string"
  assocType: DS.attr "string"
  location: DS.attr "string"
  etag: DS.attr "string"
  key: DS.attr "string"

`export default Picture`
