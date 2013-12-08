var oyabunApp = angular.module('oyabun', []);

oyabunApp.config(
    function ($interpolateProvider) {
      $interpolateProvider.startSymbol('[[');
      $interpolateProvider.endSymbol(']]');
    });

function SignupCtrl($scope, $location, $http) {

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
                $scope.userPassword = '';
            }
        })
        .error(function (res, status, headers, config) {
            // error message
        });
  };
}

function NavibarCtrl($scope, $location, $http) {
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