# My Ruby/Rails Setup on Mac OS X El Capitan


## Initial Environment Setup

There are different ways to install Ruby/Rails on Mac OS. I use three main tools:

1.  On Mac OS, you really should use [Homebrew](http://brew.sh/). Run the setup command on the Homebrew home page.
2.  [ruby-install](https://github.com/postmodern/ruby-install). This provides an easy way to download and install various Ruby versions. This can be installed through Homebrew.
3.  [chruby](https://github.com/postmodern/chruby). This lets you switch between the different versions of Ruby you've installed through ruby-install. This can also be installed through Homebrew.

Once brew is installed, run the following command:

```shell
$ brew install ruby-install chruby
```

Let it whir and hum a bit and then ruby-install and chruby should be installed!


## Installing Latest Ruby

Next, let's install the latest Ruby version:

```shell
$ ruby-install ruby
```

This will take a while. ruby-install has to download the source, then compile everything. Assuming your Mac isn't broken, this will eventually complete but be patient. You should eventually see a message like this:

```shell
>>> Successfully installed ruby 2.3.1 into /Users/matt/.rubies/ruby-2.3.1
```


## Switching Between Ruby Versions

Once you've installed a given version of Ruby through ruby-install, you should be able to switch to it:

```shell
$ chruby ruby
```

Note that this will switch to the latest version which, at the time of this post, is 2.3.1. If you wanted to specify a version of Ruby to switch to that you have already downloaded and installed through ruby-install, you can do:

```shell
$ chruby ruby-2.3.1
```

or

```shell
$ chruby 2.3.1
```

You can also revert back to the original system version of Ruby your Mac had installed:

```shell
$ chruby system
```

If you want to see what version of Ruby you're currently on:

```shell
$ chruby
 * ruby-2.3.1
```


## Autoloading

All this is great, but autoloading is really where it's at. This means that chruby will automatically load a specific version of Ruby so you don't constantly have to manually switch it with the commands listed above. To enable autoloading, open "~/.bash_profile" on your Mac and add this to the file:

```shell
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh
```

Then run:

```shell
$ source ~/.bash_profile
```

This will provide the necessary scripts to autoload the correct version of Ruby.

Next, to set the version of Ruby you want to automatically load, create a new file "~/.ruby-version" and add the following:

```shell
ruby-2.3.1
```

Voila! Now your Ruby should get auto-loaded whenever you open a new terminal session.


## Installing Rails

Now that you've got the latest Ruby installed, you'll want to install Rails and Bundler for web development. This can be easily done through **gem**, the package manager for Ruby:

```shell
$ gem install rails bundler
```

Once that completes, you should now be able to create a new Rails project:

```shell
$ rails new my_awesome_web_app
```

## A Note on Bundler

Bundler is a Ruby gem that automates a lot of tasks related to environment setup. When you've created a Rails app with a specific version of Ruby and Rails, you'll inevitably be faced with newer versions of Ruby/Rails. This is precisely why we use environment management tools like ruby-install, chruby, and bundler. When running Rails in development, you'll typically run the built-in Rails server:

```shell
$ rails s
```

This will allow you to visit your Rails app in your browser at <http://localhost:3000>. But when there is a newer version of the tools, that can cause conflicts with the Rails project you originally created. To make sure you're running the Rails project under the correct environment configuration, you'll instead want to do this:

```shell
$ bundle exec rails s
```

But you'll quickly find typing "bundle exec" to get really old. To help with this, I've created a command alias for my Bash shell to shorten "bundle exec" to "be". To do this, edit your "~/.bash_profile" file and append this to it:

```shell
alias be="bundle exec"
```

Then run:

```shell
$ source ~/.bash_profile
```

Now, instead of typing:

```shell
$ bundle exec rails s
```

you can instead type:

```shell
$ be rails s
```

Much nicer!
