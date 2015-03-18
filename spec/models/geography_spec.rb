require 'spec_helper'

describe Geography do
  subject(:geo) { build(:geography) }

  it 'has a valid factory' do
    expect(geo).to be_valid
  end
end