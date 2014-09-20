# Cleanist

Welcome to Cleanist! I build this because I was frustrated about the absurd amount of articles I have saved to my [Pocket](http://getpocket.com), my preferred read later service, that I never archived. I always felt like I should save these already read articles to read one day, and 1,000 articles later, here we are.

This is just the source code. If you were looking for the online version, check it out [here][1].

## Challenges building Cleanist

I faced challenges trying to make a system that made it easy to add multiple models that were still users but that each model did things slightly differently (ie: having pocket/instapaper sign in). I ended going up with Single Table Inheritance, making it easy to add pocket/instapaper support, while still being able to query as users (Users file: https://github.com/irosenb/cleanist/blob/master/app/models/user.rb).


<!-- Add cleanist link -->

[1]: http://cleanist.herokuapp.com
