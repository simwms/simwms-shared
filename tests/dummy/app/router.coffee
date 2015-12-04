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
    @route "accounts", path: "/accounts"

`export default Router`
