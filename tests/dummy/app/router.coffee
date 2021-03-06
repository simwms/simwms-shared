`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend
  location: config.locationType

Router.map -> 
  @route "atomic"
  @route "users"
  @route "service-plans"
  @route "login"
  @route "apix", path: "/apix", ->
    @route "accounts", path: "/accounts", ->
      @route "new"
  @route "apiz", path: "/apiz", ->
    @route "tiles", path: "/tiles"
    @route "appointments", path: "/appointments"
    @route "live-appointments", path: "/live-appointments", ->
      @route "new"
    @route "batches", path: "/batches"
    @route "trucks", path: "/trucks", ->
      @route "new"

`export default Router`
