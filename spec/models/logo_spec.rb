require 'spec_helper'

describe Logo do
  
  it 'has a valid factory' do
    expect( build :logo ).to be_valid
  end

  it 'requires alt_text' do
    expect( build :logo, alt_text: '' ).to_not be_valid
    expect( build :logo, alt_text: 'aba' ).to_not be_valid
  end

  it 'requires a file' do
    expect( build :logo, image_file_name: '' ).to_not be_valid
  end

  it 'relates to institutions' do
    expect( build :logo ).to respond_to(:institutions)
  end
  
end
