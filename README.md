NlpArabic
=========

This gem is intended to contain tools for Arabic Natural Language Processing. 
As of version 0.1, this toolkit gem allows you to:

1. Clean a text using a stop list. This stop list was generated using the tf-idf score calculated on words from over 400 articles. The words selected have also been checked and validated by hand which resulted in a stop list of over 165 words.

2. Stem a word or a text. The stemming algorithm used is the ISRI Arabic stemmer. It is described in the following research paper: 

  [Arabic Stemming without a root dictionary](http://ieeexplore.ieee.org/xpl/login.jsp?tp=&arnumber=1428453&url=http%3A%2F%2Fieeexplore.ieee.org%2Fiel5%2F9755%2F30835%2F01428453.pdf%3Farnumber%3D1428453)

This root-extraction stemmer is similar to the Khoja stemmer but does not use a root-dictionnary which can be laborious to maintain. Also, when the root can not be found, the ISRI stemmer would return a normalized form and not the orginial unmodified form. Overall, the ISRI has been proved to perform equivalently if not better than the Khoja.


Installation
============

Add this line to your application's Gemfile:

```ruby
gem 'nlp_arabic'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nlp_arabic

## Usage

Once installed, you can use it like this: 

  NlpArabic.clean(text) will return the text without the stop words.

  NlpArabic.stem(word) will return the word stemmed.

  NlpArabic.stem_text(text) will stem an entire text.

  NlpArabic.clean_and_stem(text) will do both.

  NlpArabic.wash_and_stem(text) will stem the text removing stop words and delimiters from it.

  NlpArabic.tokenize_text(text) will break the text into an array of words and delimiters.

Each step of the ISRI algorithm is coded in a separate function so you should be able to find

Development
===========

After checking out the repo, run `bin/console` for an interactive prompt that will allow you to experiment. For now the gem doesn't use any dependencies so you don't need to run `bin/setup`.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

Contributing
============
You are more than welcome to contribute to this project :) Please try to respect the ruby style guidelines described [here](https://github.com/bbatsov/ruby-style-guide). The default encoding used is UTF-8. 

1. Fork it ( https://github.com/othmanela/nlp_arabic/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Write unit tests and make sure all of them (including the old ones) pass
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
