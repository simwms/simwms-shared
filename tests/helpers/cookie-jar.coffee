class CookieJar
  simwmsAccountSession = ""
  simwmsUserSession = ""
  @preserve = ->
    simwmsUserSession = Cookies.get "simwmsUserSession"
    simwmsAccountSession = Cookies.get "simwmsAccountSession"
    Cookies.clear "simwmsUserSession"
    Cookies.clear "simwmsAccountSession"
  @restore = ->
    if simwmsUserSession?
      Cookies.set "simwmsUserSession", simwmsUserSession
    if simwmsAccountSession?
      Cookies.set "simwmsAccountSession", simwmsAccountSession
`export default CookieJar`