`import Ember from 'ember'`
{A} = Ember

simplifyError = ({detail, source}) -> 
  if typeof detail is "string"
    msg = detail
    [..., key] = source.pointer.split("/")
  else
    key = detail.key
    msg = detail.msg
  {key, msg}

`export {simplifyError}`