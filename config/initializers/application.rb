require 'open-uri'

# Forces all file downloads to be sent to tempfile
OpenURI::Buffer.send :remove_const, 'StringMax' if OpenURI::Buffer.const_defined?('StringMax')
OpenURI::Buffer.const_set 'StringMax', 0


Rack::Utils.key_space_limit = 1048576