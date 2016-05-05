class String
  def is_i?
    /\A[-+]?\d+\z/ === self
  end 
  def nan?
    self !~ /^\s*[+-]?((\d+_?)*\d+(\.(\d+_?)*\d+)?|\.(\d+_?)*\d+)(\s*|([eE][+-]?(\d+_?)*\d+)\s*)$/
  end    
end

module Fluent
  class OutputFieldMultiRegex < Fluent::Output
    Fluent::Plugin.register_output('field_multiregex', self)

    config_param :remove_tag_prefix,  :string, :default => nil
    config_param :add_tag_prefix,     :string, :default => nil
    config_param :parse_key,          :string, :default => 'message'
    config_param :multiline,          :bool,   :default => false
    config_param :pattern1,           :string, :default => nil
    config_param :pattern2,           :string, :default => nil
    config_param :pattern3,           :string, :default => nil
    config_param :pattern4,           :string, :default => nil
    config_param :pattern5,           :string, :default => nil
    config_param :pattern6,           :string, :default => nil
    config_param :pattern7,           :string, :default => nil
    config_param :pattern8,           :string, :default => nil
    config_param :pattern9,           :string, :default => nil
    config_param :pattern10,          :string, :default => nil
    config_param :pattern11,          :string, :default => nil
    config_param :pattern12,          :string, :default => nil
    config_param :pattern13,          :string, :default => nil
    config_param :pattern14,          :string, :default => nil
    config_param :pattern15,          :string, :default => nil
    config_param :pattern16,          :string, :default => nil
    config_param :pattern17,          :string, :default => nil
    config_param :pattern18,          :string, :default => nil
    config_param :pattern19,          :string, :default => nil
    config_param :pattern20,          :string, :default => nil

    def emit(tag, es, chain)
      tag = update_tag(tag)
      es.each { |time, record|
        Engine.emit(tag, time, parse_field(record))
      }
      chain.next
    end

    def update_tag(tag)
      if remove_tag_prefix
        if remove_tag_prefix == tag
          tag = ''
        elsif tag.to_s.start_with?(remove_tag_prefix+'.')
          tag = tag[remove_tag_prefix.length+1 .. -1]
        end
      end
      if add_tag_prefix
        tag = tag && tag.length > 0 ? "#{add_tag_prefix}.#{tag}" : add_tag_prefix
      end
      return tag
    end

    def parse_field(record)
      if (parse_key.nil?) || !(record.key?(parse_key))
        return record
      end
      source = record[parse_key].to_s
      
      source_arr = []
      if !(multiline == false)
        source_arr = source.split( /\r?\n/ )
      else
        source_arr << source
      end

      input_patterns = [pattern1,pattern2,pattern3,pattern4,
        pattern5,pattern6,pattern7,pattern8,
        pattern9,pattern10,pattern11,pattern12,
        pattern13,pattern14,pattern15,pattern16,
        pattern17,pattern18,pattern19,pattern20          
        ]
      matched = false
      input_patterns.each do |input_pattern|
        if !(input_pattern.nil?)
          source_arr.each do |source_elem|
            matched = false
            matched_hash = source_elem.match(input_pattern)
            if !(matched_hash.nil?)
              matched_hash.names.each do |key|
                val = matched_hash[key]
                if val.is_i?
                  record[key] = val.to_i
                elsif val.nan?
                  record[key] = val
                else
                  record[key] = val.to_f
                end
              end
              matched = true
            end
          end 
        end
        if matched
          break
        end
      end
      return record
    end
  end
end
