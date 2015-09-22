`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import {validateAccount} from 'simwms-shared'`
`import {resolveLift} from 'ember-functional-validation/utils/lifts'`
`import startApp from '../../tests/helpers/start-app'`
`import Fixtures from '../helpers/fixtures'`

freePlan = Ember.Object.create
  docks: 2
  warehouses: 2
  employees: 2
  scales: 1

basicPlan = Ember.Object.create
  docks: 5
  warehouses: 5
  employees: 10
  scales: 2

enterprisePlan = Ember.Object.create
  docks: Infinity
  warehouses: Infinity
  employees: Infinity
  scales: Infinity

module 'Acceptance: ValidateAccount',
  beforeEach: ->
    @application = startApp()
    @index = @application.__container__.lookup("route:index")
    @currentUser = @index.currentUser
    @store = @index.store
    return

  afterEach: ->
    Ember.run @application, 'destroy'

test 'validateAccount', (assert) ->
  account = Ember.Object.create
    docks: 3
    warehouses: 3
    employees: 1
    scales: 4
    servicePlan: resolveLift freePlan

  validateAccount account
  .catch (errors) ->
    assert.deepEqual errors.warehouses, ["must be lessThan 2"]
    assert.deepEqual errors.docks, ["must be lessThan 2"]
    assert.deepEqual errors.scales, ["must be lessThan 1"]

test "almost passing validation", (assert) ->
  account = Ember.Object.create
    docks: 3
    warehouses: 3
    employees: 1
    scales: 4
    servicePlan: resolveLift basicPlan

  validateAccount account
  .catch (errors) ->
    assert.notOk errors.warehouses
    assert.notOk errors.docks
    assert.deepEqual errors.scales, ["must be lessThan 2"]

test "passing validation", (assert) ->
  account = Ember.Object.create
    docks: 3
    warehouses: 3
    employees: 1
    scales: 4
    servicePlan: resolveLift enterprisePlan

  validateAccount account
  .then (account) ->
    assert.ok account, "we should get here"
  .catch ->
    assert.ok false, "should not get here"

test "account meta", (assert) ->
  visit '/'
  @currentUser.configure(Fixtures)

  andThen =>
    @currentUser.setup(@store)
    .then (session) ->
      session.get("meta")
    .then (meta) ->
      assert.equal meta.get("docks"), 1, "docks"
      assert.equal meta.get("warehouses"), 1, "warehouses"
      assert.equal meta.get("employees"), 1, "employees"
      assert.equal meta.get("scales"), 1, "scales"

      validateAccount meta
      .then (meta) ->
        assert.ok meta, "we should get here"
      .catch (errors) ->
        console.log errors
        assert.ok false, "should not get here"