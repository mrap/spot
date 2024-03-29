Spot API Documentation
=======================

Getting Started
===============

## Request format

Every request must prepend `/api/v1`. For example:

    POST www.spot.com/api/v1/users

The `/api/v1` prefix is not included in the urls below for brevity.

## Response format

Response JSON provides two macro hashes: `"meta"` and `"data"`.

    {
      "meta": {
          // Response messages such as errors and internal codes.
        }
      "data": {
          // Response data such as places, users, etc.
        }
    }

Assume that all JSON responses below are within the `"data"` macro hash
unless otherwise specified.

## User

### Create a GuestUser

    POST /guest_users

#### Successful Response

Upon successful user creation, the server returns the guest user's authentication `token`
and the `server_uid`.

    {
      "token":"e159c39a1a9223e24099fdbe1f5dd2bac446347f3f3515e82e468053f26fbfbf4b8bd64edd4c1a4fb63018dfddfe429077ff2c153dfc9f3e4337aad3ee50868a",
      "server_uid":"bd47e6e78eda330a80dfba05d8976901"
    }
----------------------------
### Create a Registered User

    POST /registered_users

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

#### Successful Response Example

    {
      "address": "990 Serramonte Blvd",
        "address_extended": "Ste D",
        "country": "us",
        "current_users": [],
        "hours": "{\"monday\":[[\"11:00\",\"22:00\"]],\"tuesday\":[[\"11:00\",\"22:00\"]],\"wednesday\":[[\"11:00\",\"22:00\"]],\"thursday\":[[\"11:00\",\"22:00\"]],\"friday\":[[\"11:00\",\"22:00\"]],\"saturday\":[[\"11:00\",\"22:00\"]],\"sunday\":[[\"11:00\",\"22:00\"]]}",
        "locality": "Colma",
        "name": "Chipotle Mexican Grill",
        "postcode": "94014",
        "posts_count": 0,
        "region": "CA",
        "tel": "(415) 840-7007",
        "id": "52db83826d72612ca1150000",
        "longitude": -122.464216,
        "latitude": 37.67178,
        "posts": [
        {
          "author_id": "52d7b1ea6d72611dbf000000",
          "author_username": "mrap",
          "description": "Not very busy",
          "helped_user_ids": [],
          "place_id": "52db83826d72612ca1150000",
          "id": "52e8bd816d72619dfe020000",
          "photo_url": "http://s3-us-west-1.amazonaws.com/spot-app-dev/posts/photos/27ff456b807cea30c4fdc714996f3cf88b972207/full.jpg?1390984577",
          "created_at": "2014-01-29T08:36:17Z"
        }
      ]
    }

### Creating a new post

Posts are nested within a Place. 
Put simply, a post cannot exist without a place.

    POST /place/:place_id/posts

#### Parameters

<table border="1">
  <tr>
    <th>Parameter Name</th>
    <th>Datatype</th>
    <th>Description</th>
    <th>Required?</th>
  </tr>
  <tr>
    <td>description</td>
    <td>String</td>
    <td>An optional user curated description.</td>
    <td>No</td>
  </tr>
</table>

#### Successful Response Example

If the post was created successfully, 
the server will return a redirect to the post's place.

The place's url is provided in the `"X-XHR-Redirected-To"` header for convenience.

    @header={"X-Frame-Options"=>"SAMEORIGIN",
      "X-XSS-Protection"=>"1; mode=block", 
      "X-Content-Type-Options"=>"nosniff",
      "X-UA-Compatible"=>"chrome=1",
      "X-XHR-Redirected-To"=>"http://www.example.com/api/v1/places/52ec3a8d6d72611cf3000000",
      "Content-Type"=>"text/html; charset=utf-8",
      "Cache-Control"=>"no-cache",
      "Set-Cookie"=>"request_method=GET; path=/\n_scout_session=MHZKUGFwZlZMZWUxTUs3UysycmV5UHRQek5NVFREeUtnbDMxOTV5VjFVVDhzd3BLdFdCclJiRWYvckhrUmd6aGtTMDJ6Z3ZNMm1wQy9GQlZtZU1WL0E9PS0tVWlSQ2xubWZ6MDVLanVPVXZSdEdGZz09--65e33e2bf780f68a28eb41d1ccafa9f96e636063; path=/; HttpOnly",
      "X-Request-Id"=>"d2871412-1a5f-414a-867f-b259f0c7d225",
      "X-Runtime"=>"0.014612", "Content-Length"=>"1"}

