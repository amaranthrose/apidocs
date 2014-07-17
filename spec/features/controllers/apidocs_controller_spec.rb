require 'spec_helper'

  def setup
  end 
describe "testing" do

  before { Apidocs.configuration_clear }


  describe "Apidocs Controller" do
  subject { page }

  before do
	Apidocs.configure do |config|
		config.regex_filter =  /id/ 
		config.http_username = 'admin'
		config.http_password = '0832c1202da8d382318e329a7c133ea0'
	end
  end


  
  describe "try not to authorize" do
    before { visit '/apidocs' }
    it { should_not have_content('Please put API.rdoc') }
  end
describe "invalid authorization" do
    let(:badlogin) { 'NotAdminSadly' }
    let(:badpassword) { 'dogs' }
    before do
      page.driver.browser.authorize badlogin, badpassword
      visit '/apidocs' 
    end
    it { should_not have_link('/products')}
  end

  describe "valid authorization" do
    let(:login) { 'admin' }
    let(:password) { 'cats' }
    before do
      page.driver.browser.authorize(login, password) 
      visit '/apidocs'
    end
    it { should have_content('Please put API.rdoc')}
  
    describe "it should filter routes" do
      it { should_not have_link("/products/new") }
      it { should have_link("/products/:id/edit") }
    end
  end
end
end
