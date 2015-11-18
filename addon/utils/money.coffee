`import Ember from 'ember'`
`import group from './group'`

{isBlank, getWithDefault} = Ember

class Money
  @fromCents = (cents) ->
    return if isBlank cents
    return "?" if cents is Infinity
    [dollars, cents] = bisectAt Math.round(cents).toString(), -2
    @given(dollars).delimitWith(",").every(-3) + "." + cents
  @given = (dollars) ->
    new Money dollars
  constructor: (@dollars) ->
  delimitWith: (@delimiter) -> @
  every: (k) ->
    group @dollars, k
    .join @delimiter

bisectAt = (str, ind) ->
  return bisectAt(str, getWithDefault(str, "length", 0) + ind) if 0 > ind
  [str.substr(0, ind), str.substr(ind)]

`export default Money`
