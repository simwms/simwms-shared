`import Ember from 'ember'`

SingletonAdapterMixin = Ember.Mixin.create
  pathForType: (modelName) ->
    camelized = Ember.String.camelize modelName
    Ember.String.singularize camelized

  urlForFindRecord: (id, modelName, snapshot) ->
    @_buildURL modelName

  urlForFindHasMany: (id, modelName) ->
    @_buildURL modelName

  urlForBelongsTo: (id, modelName) ->
    @_buildURL modelName

  urlForUpdateRecord: (id, modelName) ->
    @_buildURL modelName

  urlForDeleteRecord: (id, modelName) -> 
    @_buildURL modelName

`export default SingletonAdapterMixin`