angular.module('ApiService', [])
.service('ApiService', function($timeout, $http, $q, $window) {
    var service = {};
    const API_URL = document.getElementsByName('api')[0].getAttribute('content');

    /**
     * Login the user via REST method
     * @param {string} email 
     * @param {string} password 
     */
    service.login = function(email, password) {
        var q = $q.defer();
        var formData = new FormData();
        formData.set('email', email);
        formData.set('password', password);
        $http({
            method: 'POST',
            url: API_URL+"/login",
            data: formData,
            headers: { 'Content-Type': undefined} 
        }).then(function(res){
            q.resolve(res.data)
        }).catch(function(err){
            q.resolve({});
        });
        return q.promise;
    }

    /**
     * Get user information
     */
    service.userDetails = function() {
        var q = $q.defer();
        $http({
            method: 'GET',
            url: API_URL + "/user/info"
        }).then(function(res){
            q.resolve(res.data);
        }).catch(function(err){
            q.resolve({});
        })
        return q.promise;
    }

    /**
     * Get user products
     */
    service.userProducts = function() {
        var q = $q.defer();
        $http({
            method: 'GET',
            url: API_URL + "/user/products"
        }).then(function(res){
            q.resolve(res.data);
        }).catch(function(err){
            q.resolve({});
        })
        return q.promise;
    }

    /**
     * Sets the user token into session storage and http header
     * @param {string} token 
     */
    service.setToken = function(token) {
        $window.sessionStorage.setItem("session", JSON.stringify(token));
        $http.defaults.headers.common.Authorization = token.IndCstKey;
    }

    /**
     * Get token from session storage
     */
    service.getToken = function() {
        var data = $window.sessionStorage.getItem("session");
        if(!data) {
            return null;
        }
        return JSON.parse(data);
    }

    /**
     * Removes the token from session and http headers
     */
    service.removeToken = function() {
        $window.sessionStorage.removeItem("session");
        $http.defaults.headers.common.Authorization = "";
    }

    service.setItemCache = function(key, value) {
        $window.sessionStorage.setItem(key, JSON.stringify(value));
    }

    service.getItemCache = function(key) {
        var data = $window.sessionStorage.getItem(key);
        if(!data) {
            return [];
        }
        return JSON.parse(data);
    }

    service.hasURLParam = function(sKey) {
        var params={};
        window.location.search
            .replace(/[?&]+([^=&]+)=([^&]*)/gi, function(str,key,value) {
                params[key] = value;
            }
        );
      return params[sKey];
    }


    return service;
});