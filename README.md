# Under OS [![Build Status](https://travis-ci.org/under-os/under-os.png)](https://travis-ci.org/under-os/under-os) [![Code Climate](https://codeclimate.com/github/under-os/under-os.png)](https://codeclimate.com/github/under-os/under-os)

[UnderOS](http://under-os.com) is an experiment in building a thin web-browser like
envirnonment over iOS using rubymotion

The idea is to create a native mobile apps development environment that will be
using concepts familiar to all web-developers, like HTML, CSS, jQuery style
events handling, etc.

The result should be a _webbish_ infrastructure that uses ruby instead
of JavaScript and compiles into native code in the end.

That's gonna be legendary!

## How To Use

1) install the `under-os` gem

```
gem install under-os
```

2) Make a new app using the `uos` template

```
motion create test --template=uos
```

3) Run it!

```
cd test && rake
```


# Copyright & License

All code in this library is released under the terms of the MIT license

Copyright (C) 2013-2014 Nikolay Nemshilov

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
