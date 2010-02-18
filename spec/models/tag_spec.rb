require 'spec_helper'

describe Tag do
  before(:each) do
    @valid_attributes = {
      :name => "MyString"
    }
  end

  it "should create a new instance given valid attributes" do
    Tag.create!(@valid_attributes)
  end
end
