# Attempt to disconnect database from spec.
# Will be required by line 9 in 'spec_helper.rb'.
# Not sure it'll work -- disable if not.

# share_as :Disconnected do

#   null_db = Naught.build { |b| b.black_hole }

#   before :all do
#     ActiveRecord::Base.establish_connection(null_db)
#   end

#   after :all do
#     ActiveRecord::Base.establish_connection(:test)
#   end
# end