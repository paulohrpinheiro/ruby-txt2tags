require_relative '../txt2tags'

# HTML5 driver
class Html5
  BEAUTIFIERS = {
    monospace: '<pre>\1</pre>',
    bold: '<strong>\1</strong>',
    italic: '<em>\1</em>',
    underline: '<span style="text-decoration: underline;">\1</span>',
    strike: '<span style="text-decoration: line-through;">\1</span>',
    link: '<a href="\2">\1</a>'
  }.freeze

  TITLES = {
    title1: '<h2>\1</h2>',
    title2: '<h3>\1</h3>',
    title3: '<h4>\1</h4>'
  }.freeze

  BLOCKS = {
    quote: { begin: '<blockquote>', end: '</blockquote>' },
    verbatim: { begin: '<pre>', end: '</pre>' }
  }.freeze
end
