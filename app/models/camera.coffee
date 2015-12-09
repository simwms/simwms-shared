`import Ember from 'ember'`
`import DS from 'ember-data'`

{computed} = Ember
{equal, or: oneOf} = computed

Camera = DS.Model.extend
  tileId: DS.attr "string"
  cameraStyle: DS.attr "string"
  permalink: DS.attr "string"
  cameraName: DS.attr "string"
  macAddress: DS.attr "string"
  createdAt: DS.attr "date"
  updatedAt: DS.attr "date"

  isImageCam: equal "cameraStyle", "img-cgi"
  isWebCam: equal "cameraStyle", "user-media"
  isKnown: oneOf "isImageCam", "isWebCam"
`export default Camera`