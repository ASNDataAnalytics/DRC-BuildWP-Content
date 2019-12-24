angular.module('app', ['ApiService'])
 
.controller('MainController', function($scope, $q, ApiService) {
    init();
    
    /**
     * Login form /login
     */
    $scope.signIn = function() {
      $scope.signError = null;
      $scope.loading = true;
      ApiService.login($scope.signEmail, $scope.signPassword).then(function(res){
          $scope.loading = false;
          
          if(!res.success) {
            $scope.signError = res.error;
            return;
          }
          ApiService.setToken(res.data.Individual);

          var productID = ApiService.hasURLParam('productID');
          if(productID) {
            ApiService.userProducts().then(function(userProducts) {
              $scope.products = userProducts.data;
              $scope.accountLoaded = true;
              ApiService.setItemCache("products", $scope.products);
              $scope.onProductClick(productID);
            })
          }else {
            window.location.pathname = '/account/';
          }
          
          
        });
    }


    /**
     * Logout the user
     */
    $scope.logout = function() {
      ApiService.removeToken();
      ApiService.setItemCache("products", null);
      window.location.pathname = '/';
    }

    $scope.checkProductURLParam = function() {
      var product = ApiService.hasURLParam('productID')
      return product;
    }

    /**
     * Checks if the user has a valid premium product
     * If there is no user, redirect to signin
     */
    $scope.onProductClick = function(productID) {
      var redirectToSign = function() {
        window.location.href = '/login/?productID='+productID;
      }

      var redirectToBuy = function() {
        var url = "https://www.asn-online.org/store/buy.aspx?prd_key="+productID+"&return_url="+window.location.origin;
        window.location.href = url;
      }

      var redirectToViewDownload = function(product) {
        var url = product.PrdOnlineURLExt;
        window.location.href = url;
      }

      checkAuthToken().then(function(token){
        if(token) {
          $scope.products = ApiService.getItemCache("products") || [];
          var product = $scope.products.filter(function(item) {
            return item.PrdKey === productID;
          });

          if(product.length > 0) {
            redirectToViewDownload(product[0]);
            return;
          }

          redirectToBuy();
          return;
        }

        redirectToSign();
      });

    }
    
    /**
     * Init function
     */
    function init() {
      checkAuthToken().then(function(token){
        if(!token) {
          ApiService.removeToken();
        }
        setTimeout(productHandler, 80);
      })
      
      switch(window.location.pathname) {
        case '/':
          break;
      
        case '/account/':
          checkAuthToken().then(function(token){
            if(!token) {
              window.location.pathname = '/login/';
              return;
            }
            ApiService.setToken(token);
            accountPage();
          });
          break;
      }
    }

    /**
     * Check for auth token for REST API
     */
    function checkAuthToken() {
      var defer = $q.defer();
      var check = function() {
        var t = ApiService.getToken();
        changeAuthButton(t !== null);
        defer.resolve(t);
      }
      check();
      return defer.promise;
    }

    /**
     * Changes button on header
     * @param {string} signed 
     */
    function changeAuthButton(signed) {
        setTimeout(function(){
          if(signed) {
            $("#auth").html("Account");
            $("#auth").attr("href", "/account/");
            return;
          }
          $("#auth").html("Log In");
          $("#auth").attr("href", "/login/");
        }, 50);
    }


    /**
     * Account Page
     */
    function accountPage() {
        $scope.user = {};
        $scope.products = [];

        $q.all([ApiService.userDetails(), ApiService.userProducts()]).then(function(data) {
          var userResp = data[0];
          var prodResp = data[1];
          if(!userResp.success || !prodResp.success) {
            ApiService.removeToken();
            window.location.pathname = '/login/';
            return;
          }
          $scope.user = userResp.data;
          $scope.products = prodResp.data;
          $scope.accountLoaded = true;
          ApiService.setItemCache("products", $scope.products);
        });
    }

    /**
     * Product Page
     */
    function productHandler() {
        var products = [];
        $("li[data-productid]").each(function(){
            products.push($(this).data("productid"));
        });
        
        $scope.products = ApiService.getItemCache("products");
        if(!$scope.products || $scope.products.length <= 0) {
          return;
        }

        // match products
        var results = [];
        angular.forEach($scope.products, function(userProduct) {
          angular.forEach(products, function(webProduct) {
              if (userProduct.PrdKey === webProduct) {
                  results.push(userProduct);
              }
          });
        });
        
        //switch buttons
        results.forEach(function(val){
          var elem = $("li[data-productID='"+val.PrdKey+"']");
          var button = $(elem).find("button");
          setTimeout(function(){ $(button).text("View"); }, 50)
        });
      
    }

});