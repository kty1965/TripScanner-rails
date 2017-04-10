[![Build Status](https://travis-ci.org/kty1965/TripScanner-rails.svg?branch=master)](https://travis-ci.org/kty1965/TripScanner-rails)

# Database Setting

## User setting

```sql
CREATE USER 'zenith'@'localhost' IDENTIFIED BY 'capstone!!';
GRANT ALL PRIVILEGES ON * . * TO 'zenith'@'localhost';
FLUSH PRIVILEGES;

CREATE USER 'travis'@'localhost' IDENTIFIED BY '';
GRANT ALL PRIVILEGES ON * . * TO 'travis'@'localhost';
FLUSH PRIVILEGES;
```

# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

* test
