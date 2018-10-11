# frozen_string_literal: true

RSpec.shared_context 'successful lead creation', shared_context: :metadata do
  it 'does not raise validation errors with valid parameters', :vcr do
    response = subject.submit

    expect(response).to be_truthy
    expect(response['message']).to eql('Enqueue success')
    expect(response['errors']).to be_empty
  end
end
