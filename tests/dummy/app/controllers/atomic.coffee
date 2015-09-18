`import Ember from 'ember'`
`import {Atomic} from 'simwms-shared'`

AC = Ember.Controller.extend Atomic,
  submitClicked: false
  actions:
    submit: ->
      @set "submitClicked", true
      @atomically =>
        new Ember.RSVP.Promise (resolve) ->
          window.setTimeout resolve, 20

`export default AC`