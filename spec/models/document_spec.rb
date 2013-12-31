require 'spec_helper'

describe Document do
  it "has a valid factory" do
    expect(create(:document)).to be_valid
  end

  it "is invalid without title" do
    document = build(:document, title: nil)
    document.should_not be_valid
    expect(document).to have(1).errors_on(:title)
  end

end
