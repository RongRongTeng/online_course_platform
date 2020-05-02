# Online Course Platform

[Demo](https://rong-online-course-platform.herokuapp.com/)

- Web-Based tool for admin to manage online courses
- [Grape](https://github.com/ruby-grape/grape) API 
    - For user to view online courses
    - For user to purchase online courses
    - For user to view user courses
  


## Requirement

- ruby 2.6.3
- rails 5.2.3
- postgres


### Update configuration files

```
setup .env file (or .env.development), refer to the example file at .env.example
```

### Install Gem and Setup Database

```
bundle install
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
bundle exec yarn install
```

### Run the server

Just run the rails command to start the server

```
bundle exec rails s
```

Then visit http://localhost:3000


### Testing

```
bundle exec rspec
```

### Try it! 🔥🔥

```
     POST  |  /api/:version/authentications/token(.json)  |  v1  |  Authenticate user and retrieve authentication token
      GET  |  /api/:version/courses(.json)                |  v1  |  Return list of courses for sale                    
      GET  |  /api/:version/courses/:id(.json)            |  v1  |  Return a specific course for sale                  
     POST  |  /api/:version/courses/purchase(.json)       |  v1  |  Purchase a course and return purchase record       
      GET  |  /api/:version/user_courses(.json)           |  v1  |  Return list of user courses                        
      GET  |  /api/:version/user_courses/:id(.json)       |  v1  |  Return a specific user course 
```

#### Method 1
If you use [Postman](https://www.postman.com/), that's perfert! 👍 [Download](https://github.com/RongRongTeng/online_course_platform/blob/develop/online_course_platform.postman_collection.json) and import the API collections.

#### Method 2

use [curl](https://curl.haxx.se/docs/manpage.html)


---


❗️**Assuming that you already signed up with you email**❗️

Use you API token for authorization. 

Get it with ➡️ `POST /api/v1/authentications/token?email={your_email}&password:{your_passord}`

You can use test user to try!
```
email: test_user1@snapask.com
password: secretsecret
```

You need to add `{ api_token: your_api_token }` in params for other APIs to authenticate.


## Author

- **Ya-Rong, Teng** - [RongRongTeng](https://github.com/RongRongTeng)


