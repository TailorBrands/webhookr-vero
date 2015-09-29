module Webhookr
  module Vero
    module Generators

      class ExampleHooksGenerator < Rails::Generators::Base
        EXAMPLE_HOOK_FILE = 'app/models/vero_hooks.rb'
        source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

        desc "Creates an example vero hook file: '#{EXAMPLE_HOOK_FILE}'"
        def example_hooks
          copy_file( "vero_hooks.rb", EXAMPLE_HOOK_FILE)
        end
      end

    end
  end
end
