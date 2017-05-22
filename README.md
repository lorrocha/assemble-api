[![Build Status](https://travis-ci.org/lbaillie/assemble-api.svg?branch=master)](https://travis-ci.org/lbaillie/assemble-api)

## Assemble API

A Rails API for the Assemble mobile app.

To run:

* clone the repo
* run `bundle install`
* run `rails db:migrate`
* run `rails db:setup`
* run `rails server`
* visit `localhost:3000`

Check out the `routes.rb` file and controllers to see the available endpoints.

To get the app itself running, clone [the Ember app](https://github.com/lizbaillie/assemble), run `npm install` and `bower install`, then `ember server`. Navigate to `localhost:4200`.

TODO:

- [ ] Add all the features on the [Ember side](https://github.com/lizbaillie/assemble) and make sure things here work accordingly
- [ ] deploy 🚀🚀🚀


MIT License

Copyright (c) 2016 Elizabeth Baillie

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
