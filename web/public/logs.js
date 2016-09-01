
(function() {
    var logsApp = angular.module('logsApp', []);

    logsApp.controller('LogsCtrl', ['$scope', '$http', '$timeout', function($scope, $http, $timeout) {
        $scope.activeChannel = "All Channels";
        $scope.channels = ["All Channels"];
        $scope.messages = [];

        $scope.search = function() {
            var queryString = $scope.queryString;
            if (queryString == "" || queryString === undefined) {
                queryString = "*";
            }
            if ($scope.activeChannel != "All Channels") {
                queryString += " channel:"+$scope.activeChannel;
            }
            $http.post('/query', {query:queryString, size:1000, from:0})
                .then(function(successData) {
                    $scope.messages = successData.data;
                    $scope.messages.reverse();
                    $timeout(function(){
                        // Timeout scrolling, the table won't be full until the scope is applied
                        $(".message-div").scrollTop(function(){ return this.scrollHeight; });
                    });
                }, function(errorData) {
                    alert(JSON.stringify(errorData));
                });
        };

        $scope.changeChannel = function(channel) {
            $scope.activeChannel = channel;
            $scope.search("*");
        };

        $scope.search("*");
        $http.get('/channels')
            .then(function(successData) {
                $scope.channels = ["All Channels"].concat(successData.data);
            }, function(errorData) {
                alert(JSON.stringify(errorData));
            });
    }]);

    $(function() {
        $(".message-div").scrollTop(function(){ return this.scrollHeight; });
    });
})();
