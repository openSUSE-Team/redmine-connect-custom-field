# -*- coding: utf-8 -*-

### register new custom field format
###
Redmine::CustomFieldFormat.register 'connect_profile', :edit_as => 'bool'


module ConnectCustomFieldsHelperPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable
      alias_method_chain :show_value, :connect
    end

  end

  module InstanceMethods
    # Return a string used to display a custom value
    def show_value_with_connect(custom_value)
      return "" unless custom_value
      if custom_value.custom_field.field_format == 'connect_profile'
        if custom_value.true? and custom_value.customized.kind_of?(User)
          username = custom_value.customized.login
          link_to(username, "https://connect.opensuse.org/pg/profile/#{username}")
        else
          l(:connect_no_profile)
        end
      else
        show_value_without_connect(custom_value)
      end
    end
  end
end
