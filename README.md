<img src="http://zizzamia.com/img/tasty_bombolone_logo.png"/>

### Tasty Bombolone version 0.0.1 ###

Bombolone is a tasty Content Management System for Ruby based on Sinatra, Cassandra, [coffeescript](http://coffeescript.org/), [AngularJS](http://angularjs.org), [jQuery](http://jquery.com), [Sass](http://sass-lang.com) and Bootstrap. It's designed to be a simple, flexible toolset for projects of any size.



## Quick start in 7 steps

```shell
# Install the Sinatra
sudo gem install sinatra

# Clone the git repo in your new web app folder
git clone https://github.com/Opentaste/tasty-bombolone.git web_app

# Move in Bombolone folder 
cd web_app/

# Install [compass](http://compass-style.org/install/)
sudo gem install compass

# Install [coffeescript](http://coffeescript.org/#installation)
sudo npm install -g coffee-script

# In two new tabs with the same path run Compass and Coffee
compass watch
coffee --watch --bare --compile --output static/js/ static/coffee/

# Run Tasty Bombolone 
ruby bombolone.rb
```