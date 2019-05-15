module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    ERROR_VALIDATION = "ERROR VALIDATION. Method of validation:"
    def validate(name, type_validate, options = {})
      case type_validate
      when :presence
        define_method("#{name}_validate_#{type_validate}".to_sym) do
          if instance_variable_get("@#{name}".to_sym).nil? \
            || instance_variable_get("@#{name}".to_sym) == ''
            raise  "#{ERROR_VALIDATION} #{name}_validate_#{type_validate}"
          end
        end
      when :format
        define_method("#{name}_validate_#{type_validate}".to_sym) do
          unless options =~ instance_variable_get("@#{name}".to_sym).to_s
            raise  "#{ERROR_VALIDATION} #{name}_validate_#{type_validate}"
          end
        end
      when :type
        define_method("#{name}_validate_#{type_validate}".to_sym) do
          unless options == instance_variable_get("@#{name}".to_sym).class
            raise  "#{ERROR_VALIDATION} #{name}_validate_#{type_validate}"
          end
        end
      end
    end
  end

  module InstanceMethods
    def validate!
      validates_methods = self.methods.select do | method |
        /validate_/.match(method)
      end
      validates_methods.each do | method |
        # puts method
        send(method)
      end
    end
  end

  def valid?
    validate!
    true
  rescue StandardError => e
    puts "#{e.message}"
  end
end
