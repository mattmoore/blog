# Ruby 1.8.7 on Mac OS Sierra

Ruby 1.8.7 won't install on Mac OS Sierra with ruby-install. However, you can still compile it manually and use chruby to switch to it.

```ruby
curl -O https://cache.ruby-lang.org/pub/ruby/1.8/ruby-1.8.7.tar.gz
tar xvf ruby-1.8.7.tar.gz
cd ruby-1.8.7
mkdir -p $HOME/.rubies/ruby-1.8.7
./configure --prefix=$HOME/.rubies/ruby-1.8.7
make
make install
```
