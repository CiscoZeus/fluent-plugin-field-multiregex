fluent-plugin-field-multiregex
===========================

Fluent output plugin for reforming a record using multiple named capture regular expressions

## Installation

Use RubyGems:

    td-agent-gem install fluent-plugin-field-multiregex

## Configuration

    <match pattern>
        type                field_multiregex

        remove_tag_prefix   raw
        add_tag_prefix      parsed
        pattern             (\S+)=(\S+)
    </match>

