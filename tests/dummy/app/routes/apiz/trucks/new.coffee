`import Ember from 'ember'`

{Route} = Ember

NewRoute = Route.extend
  model: ->
    @store.createRecord "onsite-truck"

  tearDown: Ember.on "deactivate", ->
    model = @get "controller.model"
    model.rollbackAttributes() if model.get("hasDirtyAttributes")

  actions:
    submit: ->
      model = @get "controller.model"
      model.save()
      .then =>
        @transitionTo "apiz.trucks.index"

`export default NewRoute`