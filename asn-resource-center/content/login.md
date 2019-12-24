+++
title = "Sign In"
+++
<form class="form form-centered" ng-submit="signIn()">
    
    <div ng-show="checkProductURLParam()"> 
        <p>Please sign in to view or buy</p> 
    </div>
    
    <div class="form-item">
        <label>Email</label>
        <input ng-model="signEmail" type="email" name="emal" autofocus="true" autocomplete="on" required>
    </div>

    <div class="form-item">
        <label>Password</label>
        <input ng-model="signPassword" type="password" name="password" autocomplete="on" required>
    </div>

    <div class="form-item">
    <label><span id="sign-error">{{signError}}</span></label>
    </div>

    <p><button class="button primary width-100" ng-disabled="loading">Log in</button></p>
  

</form>
