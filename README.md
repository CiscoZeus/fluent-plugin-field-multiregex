fluent-plugin-field-multiregex
===========================

Fluent output plugin for reforming a record using multiple named capture regular expressions

## Installation

Use RubyGems:

    td-agent-gem install fluent-plugin-field-multiregex

## Configuration

    <match pattern>
        type                field_multiregex
        parse_key           message
        remove_tag_prefix   raw
        add_tag_prefix      parsed
        multiline           true
        pattern1            ^Regular Expression with (?<capture>named captures)$
    </match>

