`import Ember from 'ember'`

SingletonAdapterMixin = Ember.Mixin.create
  pathForType: (modelName) ->
    camelized = Ember.String.camelize modelName
    Ember.String.singularize camelized

  urlForFindRecord: (id, modelName, snapshot) ->
    @_buildUrl modelName

  urlForFindHasMany: (id, modelName) ->
    @_buildUrl modelName

  urlForBelongsTo: (id, modelName) ->
    @_buildUrl modelName

  urlForUpdateRecord: (id, modelName) ->
    @_buildUrl modelName

  urlForDeleteRecord: (id, modelName) -> 
    @_buildUrl modelName

`export default SingletonAdapterMixin`