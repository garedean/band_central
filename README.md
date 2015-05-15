##Band Central

Author: Garrett Olson

Band Central is a Sinatra app that allows tracks bands and the venues they've played at.

#Setup

Boot up a local Sinatra server (localhost:4567) and navigate to the root directory ('/'). Let the intuitive UI guide you.

#Database Setup, PSQL

```
username=# CREATE DATABASE band_central;  
username=# \c band_central;  
band_central=# CREATE TABLE bands (id serial PRIMARY KEY, name varchar);  
band_central=# CREATE TABLE venues (id serial PRIMARY KEY, name varchar);  
band_central=# CREATE DATABASE band_central_test WITH TEMPLATE band_central; (used for testing)
```

#Copyright and license

Code and documentation copyright 2015 Garrett Olson. Band Central is released under the [MIT license](http://opensource.org/licenses/MIT)
