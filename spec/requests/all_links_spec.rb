include '../spec_helper'

class AllLinksSpec
  it "should not have broken links on the site" do
    visit "/"
  end
end