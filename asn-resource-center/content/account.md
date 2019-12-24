+++
title = "My Account"
+++
<div ng-show="accountLoaded">
<button ng-click="logout()">Logout</button>
<br/>

<table>
    <tr ng-if="user.IndFirstName">
        <td>First Name</td>
        <td>{{user.IndFirstName}}</td>
    </tr>
    <tr ng-if="user.IndMidName">
        <td>Middle Name</td>
        <td>{{user.IndMidName}}</td>
    </tr>
    <tr ng-if="user.IndLastName">
        <td>Last Name</td>
        <td>{{user.IndLastName}}</td>
    </tr>
    <tr ng-if="user.CstEmlAddressDn">
        <td>Email</td>
        <td>{{user.CstEmlAddressDn}}</td>
    </tr>
    <tr ng-if="user.CstOrgNameDn">
        <td>Organization</td>
        <td>{{user.CstOrgNameDn}}</td>
    </tr>
    <tr ng-if="user.AdrLine1">
        <td>Address</td>
        <td>{{user.AdrLine1}} {{user.AdrCityStateCode}}</td>
    </tr>
</table>

<hr/>

<p>Available Products</p>

<table>
<thead>
    <tr>
      <th>Name</th>
      <th>Option</th>
    </tr>
  </thead>
  <tbody>
  <tr ng-repeat="product in products">
    <td>{{product.PrdName}}</td>
    <td ng-if="!product.PrdDownloadURL">
        <a href="{{product.PrdOnlineURLExt}}" target="_blank">View</a>
    </td>
    <td ng-if="product.PrdDownloadURL">
        <a href="{{product.PrdDownloadURL}}">Download</a>
    </td>
  </tr>

  </tbody>
</table>

</div>
