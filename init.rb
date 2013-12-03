require 'custom_field'

Redmine::Plugin.register :connect_custom_field do
  name 'Connect profile custom field'
  author 'Ancor Gonzalez Sosa'
  description 'Adds a new type of custom field for linking to user profiles at connect.opensuse.org'
  version '0.0.1'
  url 'https://github.com/openSUSE-Team/redmine-connect-custom-field'
  author_url 'https://github.com/ancorgs'
  requires_redmine :version_or_higher => '2.0.0'
end

ActionDispatch::Callbacks.to_prepare do
  require_dependency 'custom_fields_helper'
  CustomFieldsHelper.send(:include, ConnectCustomFieldsHelperPatch)
end

