Scout API
=========

API Documentation
=================

## User Authentication Token

### Requesting for a new authentication token

Every API client application must submit the user's expirable authenication token
for every request.  Since, a user does **not** have a token when initially created,
the client must first request the server for a **new token** before interacting.

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

