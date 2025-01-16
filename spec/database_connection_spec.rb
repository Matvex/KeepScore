require 'rails_helper'

RSpec.describe 'Database Connection' do
  it 'can connect to the database' do
    expect { ActiveRecord::Base.connection }.not_to raise_error
  end
end
