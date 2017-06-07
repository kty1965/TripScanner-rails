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

# Installation

## Mac OS X
```
$ brew install imagemagick
```

## Ubuntu
```
$ apt-get install imagemagick
```
