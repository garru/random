require 'rubygems'
require 'fastercsv'

class OneRule
  #array of hashes
  def initialize(data)
    @data = data
    @attributes = data.first.keys
  end
  
  def solve(for_attribute)
    least_errors = nil
    least_error_attribute = nil
    least_error_rules = nil
    attrs = @attributes.dup
    attrs.delete(for_attribute)
    attrs.each do |attribute|
      rules = rule_evaluation(attribute, for_attribute)
      num_errors = error_rate(attribute, for_attribute, rules)
      if least_errors.nil? || least_errors > num_errors
        least_errors = num_errors
        least_error_attribute = attribute
        least_error_rules = rules
      end
    end
    [least_error_attribute, least_error_rules]
  end

  def rule_evaluation(attribute, value_attribute)
    max_value = 0
    max_attribute = nil
    values = @data.inject({}) do |results, x|
      results[x[attribute]] ||= {}
      results[x[attribute]][x[value_attribute]] ||= 0
      results[x[attribute]][x[value_attribute]] += 1
      n = results[x[attribute]][x[value_attribute]]
      results
    end
    
    values.inject({}) do |rule_hash, (value, results)|
      max_count = 0
      max_value = nil
      results.each do |k,v|
        if v > max_count
          max_count = v
          max_value = k
        end
      end
      rule_hash[value] = max_value
      rule_hash
    end
  end

  def error_rate(attribute, value_attribute, rules)
    @data.inject(0) do |errors, x|
      if rules[x[attribute]] != x[value_attribute]
        errors += 1 
      end
      errors
    end
  end
end

arrs = FasterCSV.table("data/table_1_2.txt", :headers => :first_row)
datas = arrs.inject([]) do |array, x|
  array << x.to_hash
  array
end

one_rule = OneRule.new(datas)
puts one_rule.solve(:play).inspect
