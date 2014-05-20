
streamsApp = angular.module('streamsApp', ['ngAnimate'])

StreamsListCtrl  = ($scope, $http) ->
  $http.get('streams/stream_list').success (data) ->
    $scope.newStreams  = data.new_streams
    $scope.oldStreams  = data.old_streams
    $scope.sports   = _.keys($scope.newStreams)
    $scope.pageSize = 7
    $scope.currentPage     = new Object()
    _.each $scope.sports, (sport) ->
      $scope.currentPage[sport] = 0

  $scope.trackPlay = ->
    stream = this.stream
    if stream.play_count == 0
      $scope.oldStreams[stream.sport].push(stream)
      $scope.newStreams[stream.sport] = _.without($scope.newStreams[stream.sport], stream)
    save = $http.get("streams/play/#{this.stream.id}").success (data) ->
      stream.play_count++

  $scope.pageForward = (sport) ->
    lastPage = 2
    if $scope.currentPage[sport] < lastPage
      $scope.currentPage[sport]++

  $scope.pageBack = (sport) ->
    firstPage = 0
    if $scope.currentPage[sport] > firstPage
      $scope.currentPage[sport]--

StreamsListCtrl.$inject = ['$scope', '$http'];
streamsApp.controller('StreamsListCtrl', StreamsListCtrl)
