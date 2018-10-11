# frozen_string_literal: true

RSpec.shared_context 'unsuccessful lead creation', shared_context: :metadata do |expected_invalid_key|
  it 'raises a validation error' do
    expect(HTTParty).to_not receive(:post)
    expect(subject.submit).to be false
    expect(lead.errors).not_to be_empty
    expect(lead.errors.messages).to have_key expected_invalid_key
  end
end
