# Txt2Tags in Ruby

[![Gem Version](https://badge.fury.io/rb/txt2tags.svg)](https://badge.fury.io/rb/txt2tags)


Txt2Tags is a document generator. It reads a text file with minimal markup such as \*\*bold\*\* and //italic// and converts it to some formats, like *HTML* or *LaTeX*.

This is a reimplementation in Ruby because the original is written in Python:

  http://txt2tags.org/


This project is starting. For now, only some tags are ready, and only html5 output (there are 'null' format, but only for run tests).

For a better understanding of the specification of this format, see this document:

  http://txt2tags.org/markup.html



## Implemented tags

### Comments

Lines beggining with `%` will be ignored.


### Beautifiers

* \`\`monospace\`\`
* `\*\*bold\*\*
* //italic//
* \_\_underline\_\_
* --strike--


### Titles

* = Title 1 =

* == Title 2 ==

* === Title 3 ===


### Blocks


   Quote



### Verbatim

    ```
    Verbatim content
    ```


### Images

    [URL]
    [https://paulohrpinheiro.xyz/favicon.ico]


### Links

    [A description of link THE_URL]
    [My personal blog in pt-BR https://paulohrpinheiro.xyz]


## Usage

### Command line:

```bash
% txt2tags-rb --help
Usage: txt2tags [options]
    -i, --input FILENAME
    -o, --output FILENAME
    -h, --help                       Display this screen
    -l, --list                       List available formats
    -f, --format FORMAT              Use this format for output
paulohrpinheiro@localhost ~ % echo "//italic//" | txt2tags-rb --f null
i_italic_i
% echo "//italic//" | txt2tags-rb --f html5
<em>italic</em>
```


### **IRB**

```ruby
% irb
2.3.0 :001 > require 'txt2tags'
 => true
2.3.0 :002 > require 'txt2tags/null'
 => true
2.3.0 :003 > require 'txt2tags/html5'
 => true
2.3.0 :004 > t = Txt2Tags.new('//italic')
 => #<Txt2Tags:0x000000010eb838 @input=#<StringIO:0x000000010eb810>>
2.3.0 :005 > t.output(Null)
 => #<Enumerator: #<Enumerator::Generator:0x000000010dc158>:each>
2.3.0 :006 > t.output(Null).to_a
 => ["//italic"]
2.3.0 :007 > t.output(Null).to_a.join("\n")
 => "//italic"
2.3.0 :008 > t.output(Html5).to_a.join("\n")
 => "//italic"
```


### More **IRB**

```ruby
% irb                                      
2.3.0 :001 > require 'txt2tags'
 => true
2.3.0 :002 > t = Txt2Tags.new('//italic//')
 => #<Txt2Tags:0x00000002672e90 @input=#<StringIO:0x00000002672e40>>
2.3.0 :003 > t.formats
 => ["html5", "null"]
2.3.0 :004 > t.output(t.load_format 'null').to_a
 => ["i_italic_i"]
2.3.0 :005 > t.output(t.load_format 'html5').to_a
 => ["<em>italic</em>"]
2.3.0 :006 > t.formats.each do |f|
2.3.0 :007 >     puts t.output(t.load_format f).to_a
2.3.0 :008?>   end
<em>italic</em>
i_italic_i
 => ["html5", "null"]
```

## RubyGems

https://rubygems.org/gems/txt2tags
