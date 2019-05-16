module AttrAccesssor
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    WRONG_ARGUMENT_TYPE = "Wrong type of argument!!!"
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}"
        var_name_history = "@#{name}_history"
        method_history = "#{name}_history"

        define_method("#{method_history.to_sym}") { instance_variable_get(var_name_history.to_sym) }
        define_method("add_#{name}_history_item") do |value|
          history_attr = instance_variable_get(var_name_history.to_sym) || []
          history_attr << value
          instance_variable_set(var_name_history.to_sym, history_attr)
        end
        define_method("#{name.to_sym}") { instance_variable_get(var_name.to_sym) }
        define_method("#{name.to_sym}=") do |value|
          unless instance_variable_get(var_name.to_sym).nil?
            send("add_#{name}_history_item", instance_variable_get(var_name.to_sym))
          end
          instance_variable_set(var_name.to_sym, value)
        end
      end
    end

    def strong_attr_accessor(name, type)
      var_name = "@#{name}"
      define_method("#{name.to_sym}") { instance_variable_get(var_name.to_sym) }
      define_method("#{name.to_sym}=") do |value|
        raise WRONG_ARGUMENT_TYPE unless value.class == type
        instance_variable_set(var_name.to_sym, value)
      end
    end
  end

  module InstanceMethods
  end
end
