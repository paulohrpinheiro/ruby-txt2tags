require_relative '../txt2tags'

# Null format
#
# This format is a template and base for basic test_files.
# Copy and paste this file for a new format.
#
# This contain the replace part of a regexp
# "\1" is the group from the search part og regexps in main class
class Null
  BEAUTIFIERS = {
    monospace: 'm_\1_m',
    bold: 'b_\1_b',
    italic: 'i_\1_i',
    underline: 'u_\1_u',
    strike: 's_\1_s'
  }.freeze

  TITLES = {
    title1: 'T1_\1_T1',
    title2: 'T2_\1_T2',
    title3: 'T3_\1_T3'
  }.freeze

  BLOCKS = {
    quote: { begin: 'BEGIN_QUOTE', end: 'END_QUOTE' },
    verbatim: { begin: 'BEGIN_VERBATIM', end: 'END_VERBATIM' }
  }.freeze
end
