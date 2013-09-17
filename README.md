# Cleanist

Welcome to Cleanist! I build this because I was frustrated about the absurd amount of articles I have saved to my [Pocket](http://getpocket.com), my preferred read later service, that I never archived. I always felt like I should save these already read articles to read one day, and 1,000 articles later, here we are.

Now of course, this is just the source code. If you were looking for the online version, check it out [here][1].

## Install

First, do a `git clone URL_NAME` of this repo. 

Or however you want to download this repo.

## Run

In order to run the actual application, you'll need a few things first. 

I gitignored the file that has my API keys. So you'll have to make a new file in `config/` called `application.yml`. This file holds the API keys necessary to make requests to the read later services like Pocket. 

After that, you'll need to write the API keys in. So if you were putting in your Pocket API key, you would write `POCKET_KEY: YOUR_API_KEY`.

Make sure you have Ruby 2.0 and Rails 4 installed. Do a `bundle install` to install all the needed gems. You might need to run `rake db:migrate` as well to set up the table. 

After all that, run `rails server` and you should be good to go! 





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

<!-- Add cleanist link -->

[1]: http:// "Cleanist"
