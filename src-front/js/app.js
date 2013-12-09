"use strict";

var oyabunApp = angular.module("oyabun", []);

oyabunApp.config(["$interpolateProvider",
    function ($interpolateProvider) {
        $interpolateProvider.startSymbol("[[");
        $interpolateProvider.endSymbol("]]");
    }
]);

oyabunApp.controller("SignupCtrl", ["$scope", "$location", "$http",
    function($scope, $location, $http) {
        $scope.login = function() {
            $scope.loginUser = {loginid:$scope.userLoginId, password:$scope.userPassword};
            // POST signup with data
            $http.post("/signup", $scope.loginUser)
            .success(function (res, status, headers, config) {
                if(res.result == "ok") {
                    location.href='/dashboard';
                }
                else {
                    $scope.loginError = res.data.message;
                    // reset password
                    $scope.userPassword = "";
                }
            })
            .error(function (res, status, headers, config) {
                // error message
            });
        };
    }
]);

oyabunApp.controller("NavibarCtrl", ["$scope", "$location", "$http",
    function($scope, $location, $http) {
        $scope.logout = function() {
            $http.post("/signout")
            .success(function (res, status, headers, config) {
                if(res.result == "ok") {
                    location.href='/';
                }
                else {
                    $scope.loginError = res.data.message;
                }
            })
            .error(function (res, status, headers, config) {
                // error message
            });
        };
    }
]);