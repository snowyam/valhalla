# Valhalla

Valhalla is a social network web application built with Ruby on Rails. It is designed to mimic the core functionality of Facebook as a social network with friends, posts, comments, and likes. The project is part of one of the final projects in [The Odin Project's](https://github.com/TheOdinProject) open source full stack web development curriculum. 

Live: https://valhalla-app.herokuapp.com/

Currently very little JavaScript features including infinite scrolling and AJAX requests. Coming after finishing the JavaScript curriculum track. 

## Built With

* Ruby  2.3.1
* Rails 5.0.0.1
* Minitest
* Bootstrap
* PostgreSQL
* Devise
* Many more gems! (full list in gemfile)
* Deployed on Heroku

## Features

* Authentication and Authorization
* Posts, comments, and likes
* Feed and Profile
* Friend system

### Authentication and Authorization

For user login and signup, [Devise](https://github.com/plataformatec/devise) for the implementation of authentication and authorization. Login is required across the application with the exception of the login and sign up pages, as well as the static pages such as about, help, and license. Additional authorization outside of the user model with devise is implemented only in the required controller for that resource.

Email is also sent out through the inluded Devise mailers, opened up in the browser in the development, and through the Heroku [Sendgrid](https://elements.heroku.com/addons/sendgrid) add-on in production. Email is for the primary reason of confirmation for account creation.

### Posts, comments, and likes

As a social network, users can write and post posts on their home page which is the main feed page. The feed contains the user's own posts as well as the posts of friends. Posts can have many likes as well as many comments. The index for the user's own posts are on the profile page.

### Feed and Profile

The main feed of the application home page is just like Facebook's newsfeed and houses the posts of the user and their friends in most recent order.

The profile page has a profile section created on user sign up that is a separate model from the user model. The user's own posts are also located on the profile page.

### Friend system

The friend system allows for users to add each other as friends. The friends list and posts on the feed only include friends that have accepted a friend request. 

The find friends page provides a list of users that do not have a friendship from the current user or an outgoing or incoming friend request.

## Front-end

The overall design of the front-end mimics the style of Facebook albeit very light on the JavaScript and of course nowhere as much features. The Bootstrap framework was used for its relative ease of working with Rails and with Devise's views. 

## Back-end

PostgreSQL was the data store of choice due to it's compatibility with Rails applications being deployed onto the Heroku cloud.

The project was relatively light on having to use raw SQL as Rails' ActiveRecord is able to accommodate most use cases. However, the friend system did require more complex SQL queries to be implemented for the friend requests, friends, and find friends pages.

## Database Configuration and Environment Variables

To get started with running Valhalla, simply clone the repository and setup your environment with the required Ruby and Rails version. You will need to use PostgreSQL as your database for both testing and development environments. Production environment is set for Heroku by default, simply change into your Heroku host name as needed. Applies for the mailer SendGrid add-on as well for Heroku. Test and development environment is set to localhost, and the mailer gem will also open up mail in your browser automatically. Remember to bundle install and migrate database.

## Running Test Suite

Once the test environment and database configuration has been configured, run the test suite to verify that everything is working correctly:

```
$ rails test
```

## License

See the LICENSE file.