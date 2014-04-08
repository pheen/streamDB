
streamsApp = angular.module('streamsApp', ['ngAnimate'])

streamsApp.controller 'StreamsListCtrl', ($scope, $http) ->

  $http.get('streams/stream_list').success (data) ->
    $scope.snow  = []
    $scope.skate = []
    $scope.surf = []
    $scope.filteredSnow  = []
    $scope.filteredSkate = []
    $scope.filteredSurf = []
    $scope.currentPage   = new Object(snow: 1, skate: 1, surf: 1)
    $scope.pageSize      = 7
    $scope.lastPage      = 3
    $scope.plays = data.plays

    $scope.$watchCollection 'currentPage', (currentPage) ->
      $scope.filterCollections(currentPage)

    _.each [data.snowStreams, data.skateStreams, data.surfStreams], (steamSet) ->
      _.each steamSet, (stream) ->
        sport = stream.sport
        $scope.currentPage[sport] ||= 1
        plays              = _.find($scope.plays, (play) -> play.video_id == stream.id )
        stream.play_count  = if plays then plays.play_count else 0
        stream.url         = stream.direct_url || stream.post_url
        $scope[sport]      = $scope[sport].concat(stream)

  $scope.filterCollections = (currentPages) ->
    _.each _.pairs(currentPages), (page) ->
      sport         = page[0]
      filteredSport = 'filtered' + page[0].replace(/^./, (m) -> m.toUpperCase())
      currentPage   = page[1]
      scope         = $scope[sport]
      min   = ($scope.pageSize * currentPage) - 1
      max   = ($scope.pageSize * currentPage) + 8
      $scope[filteredSport] = scope.slice(min, max)

  $scope.trackPlay = ->
    stream = this.stream
    save   = $http.get("streams/play/#{this.stream.id}").success (data) ->
      stream.play_count++

  $scope.pageForward = (streams) ->
    sport = streams[0].sport
    if $scope.currentPage[sport] < $scope.lastPage
      $scope.currentPage[sport]++

  $scope.pageBack = (streams) ->
    sport = streams[0].sport
    if $scope.currentPage[sport] > 1
      $scope.currentPage[sport]--
