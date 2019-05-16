module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validations
      @validations
    end

    def validations=(value)
      @validations ||= []
      @validations << value
    end

    def validate(name, type, args = '')
      value = {name: name, type: type, args: args}
      self.validations = value
    end
  end

  module InstanceMethods
    def validate!
      params = self.class.validations
      params.each do |param|
        send("validate_#{param[:type]}", param)
      end
    end

    def validate_presence(options)
      name = options[:name]
      if instance_variable_get("@#{name}".to_sym).nil? \
        || instance_variable_get("@#{name}".to_sym) == ''
        raise "#{name} is empty!"
      end
    end

    def validate_format(options)
      name = options[:name]
      patern = options[:args]
      unless patern =~ instance_variable_get("@#{name}".to_sym).to_s
        raise  "#{name} does not match patern!"
      end
    end

    def validate_type(options)
      name = options[:name]
      type = options[:args]
      unless type == instance_variable_get("@#{name}".to_sym).class
        raise  "#{name} does not match type"
      end
    end

    def valid?
      validate!
      true
    rescue StandardError => e
      puts "#{e.message}"
    end
  end
end
