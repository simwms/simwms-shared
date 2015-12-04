`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'user', 'Unit | Model | user', {
  # Specify the other units that are required for this test.
  needs: []
}

test 'it exists', (assert) ->
  model = @subject
    email: "fox@fox.fox"
    username: "foxtestnetwork"
    password: "666"
  store = @store()
  assert.ok model
  assert.equal typeof store?.createRecord, 'function'
  assert.equal typeof store?.serialize, 'function'

test 'serialization', (assert) ->
  store = @store()
  model = @subject
    email: "fox@fox.fox"
    username: "foxtestnetwork"
    password: "666"
  actual = store.serialize(model)
  expected =
    data:
      type: "users"
      attributes:
        email: "fox@fox.fox"
        username: "foxtestnetwork"
        password: "666"

  assert.deepEqual actual, expected, "serialization should be as expected"