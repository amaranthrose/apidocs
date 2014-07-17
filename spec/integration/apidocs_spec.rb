require 'spec_helper'

describe "apidocs pages" do
  subject { page }

  before do
   Apidocs.configuration_clear
   visit '/apidocs'
  end
  shared_examples_for "having all the links" do
    it {  should have_link("/products") }
    it {  should have_link("/products/new") }
    it {  should have_link("/products/:id/edit") }
    it {  should have_link("/products/:id") }
  end

  describe "index"  do
    it { should have_title('Apidocs') }
    it { should have_content('Please put API.rdoc') }
  end

  describe "links" do

    before do
     click_link '/products/new'
    end

    it { should_not have_content ('Please put API.rdoc' )  }
    it { should have_content ('GET /products/new')  }
    it { should_not have_content ('POST /products')  }
    it { should have_link 'APIDOC', href: root_path }
    it_should_behave_like "having all the links"

    describe "it should redirect to index page after clicking on logo" do
      before { click_link "APIDOC" }
      it { should have_content ('Please put API.rdoc' )  }
      it_should_behave_like "having all the links"
     end

  end

  describe "search", js: true do
  
   it_should_behave_like "having all the links"

    describe "looking for id" do
      before { fill_in "search-input", with: "id" } 
      it {  should have_link("/products/:id/edit") }
      it {  should_not have_link("/products/new") }

      describe "visiting a link" do
	before { click_link "/products/:id" }
        it {  should have_link("/products/:id/edit") }
        it {  should_not have_link("/products/new") }
      end

      describe "visiting index page" do
	before { click_link "APIDOC" }
        it_should_behave_like "having all the links"
      end
    end
  end
end
