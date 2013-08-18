ot = angular.module("bombolone", ["ngResource"])

protocol = window.location.protocol
host = window.location.host
path = window.location.pathname

# Init Application
ot.value "appName", "bombolone"

# Main configuration
ot.config ($locationProvider, $interpolateProvider) ->

  # others
  $interpolateProvider.startSymbol "[["
  $interpolateProvider.endSymbol "]]"

# First commands
ot.run ($rootScope, $location) ->

  window.scope = angular.element(d).scope()
