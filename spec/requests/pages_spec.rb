require 'rails_helper'

describe 'Request callback page' do
  subject { page }
  
  before { visit root_path }

  it { should have_content('About Us') }
  it { should have_title('Make it Cheaper | Request a callback') }
end
