Spot API Documentation
=======================

Every request must prepend `/api/v1`. For example:

    POST www.spot.com/api/v1/users

The `/api/v1` prefix is not included in the urls below for brevity.

## User

### Create a User

    POST /users

#### Parameters

<table border="1">
  <tr>
    <th>Parameter Name</th>
    <th>Datatype</th>
    <th>Description</th>
    <th>Required?</th>
  </tr>
  <tr>
    <td>user[email]</td>
    <td>String</td>
    <td>User's email address.</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>user[username]</td>
    <td>String</td>
    <td>User's unique username.</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>user[password]</td>
    <td>String</td>
    <td>User's password.</td>
    <td>Yes</td>
  </tr>
</table>

#### Successful Response

Upon successful user creation, the server returns the new user's authentication `token`
and the token's `expiration` date:

    {
      "token":"e159c39a1a9223e24099fdbe1f5dd2bac446347f3f3515e82e468053f26fbfbf4b8bd64edd4c1a4fb63018dfddfe429077ff2c153dfc9f3e4337aad3ee50868a",
      "expiration":"2014-01-18T09:36:18+00:00"
    }

----------------------------------------------

### Requesting for a new authentication token

Every API client application must submit the user's expirable authenication token
for every request.  
If the token is expired, the user may request for a new one like so:

    POST /tokens

The user's email and password must be encoded in the HTTP Authorization Header as Basic.  
Example for user with email: `mike@mrap.me` and password: `password`.

    Authorization: Basic bWlrZUBtcmFwLm1lOnBhc3N3b3Jk

## Places

### Get a Place

    GET /places/:place_id

### Searching for places

Get a list of places nearby given coordinates.

    GET /places/search

#### Parameters

<table border="1">
  <tr>
    <th>Parameter Name</th>
    <th>Datatype</th>
    <th>Description</th>
    <th>Required?</th>
  </tr>
  <tr>
    <td>latitude</td>
    <td>Float</td>
    <td>Latitude of coordinates.</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>longitude</td>
    <td>Float</td>
    <td>Longitude of coordinates.</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>radius</td>
    <td>Integer</td>
    <td>Sets a max distance around coordinates in meters.</td>
    <td>No</td>
  </tr>
  <tr>
    <td>search_terms</td>
    <td>String</td>
    <td>Words separated by spaces. Provides full-text-search of potential places' names.  </td>
    <td>No</td>
  </tr>
</table>

