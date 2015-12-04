`import Ember from 'ember'`

UnderscoreSerializerMixin = Ember.Mixin.create
  keyForAttribute: (key, method) ->
    Ember.String.underscore(key)

`export default UnderscoreSerializerMixin`