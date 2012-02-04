require 'spec_helper'

describe ProjectsController do
  describe "routing" do
    it '/:organization_id/new to Projects#new' do
      path = new_organization_project_path('hermon-me')
      path.should == '/hermon-me/new'
      { :get => path }.should route_to(
        :controller => 'projects',
        :action => 'new',
        :organization_id => 'hermon-me'
      )
    end

    it '/:organization_id/:project_id to Projects#show' do
      path = organization_project_path 'hermon-me', '1'
      path.should == '/hermon-me/1'
      { :get => path }.should route_to(
        :controller => 'projects',
        :action => 'show',
        :organization_id => 'hermon-me',
        :id => '1'
      )
    end

    it '/:organization_id/:project_id/edit to Projects#edit' do
      path = edit_organization_project_path 'hermon-me', '1'
      path.should == '/hermon-me/1/edit'
      { :get => path }.should route_to(
        :controller => 'projects',
        :action => 'edit',
        :organization_id => 'hermon-me',
        :id => '1'
      )
    end
  end
end