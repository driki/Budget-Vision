require 'spec_helper'

describe "GET organizations" do
  it "shows an organization when requesting one" do
    @organization = Factory(:organization, :name => "TEST ORG", :population => 20001, :state => "ME")
    get organization_path(@organization)
    response.should redirect_to(@organization.projects.first)
  end
end
