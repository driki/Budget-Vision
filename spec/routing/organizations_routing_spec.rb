require 'spec_helper'

describe OrganizationsController do
  describe "routing" do
    it '/organizations to Organization#index' do
      path = organizations_path
      path.should == '/organizations'
      { :get => path }.should route_to(
        :controller => 'organizations',
        :action => 'index'
      )
    end

    it '/new to Organization#new' do
      path = new_organization_path
      path.should == '/new'
      { :get => path }.should route_to(
        :controller => 'organizations',
        :action => 'new'
      )
    end

    it '/:organization_id to Organization#show' do
      path = organization_path 'hermon-me'
      path.should == '/hermon-me'
      { :get => path }.should route_to(
        :controller => 'organizations',
        :action => 'show',
        :id => 'hermon-me'
      )
    end

    it '/:organization_id/edit to Organization#edit' do
      path = edit_organization_path 'hermon-me'
      path.should == '/hermon-me/edit'
      { :get => path }.should route_to(
        :controller => 'organizations',
        :action => 'edit',
        :id => 'hermon-me'
      )
    end
  end
end