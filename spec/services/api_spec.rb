require_relative '../../app/services/api'

describe Api do
  before do
    stub_request(:post, Api.url)
      .to_return(status: status, body: body,
                 headers: {'Content-Type'=>'application/json'})
  end

  let(:body) do
    { message: message, errors: errors }.to_json
  end

  let(:result) do
    Api.enqueue(
      token: ENV['LEAD_API_ACCESS_TOKEN'],
      user_id: ENV['LEAD_API_PGUID'],
      acc_name: ENV['LEAD_API_PACCNAME'],
      partner_name: ENV['LEAD_API_PPARTNER'],
      name: 'Peter Pan',
      business_name: 'Widgets Co',
      tel_number: '01273677688',
      email: 'anyone@example.com'
    )
  end

  shared_examples 'expected response' do
    it { expect(result.status).to eq status }
    it { expect(result.message).to eq message }
    it { expect(result.errors).to eq errors }
  end

  context 'success response' do
    let(:status) { 201 }
    let(:message) { 'Enqueue success' }
    let(:errors) { [] }

    it_behaves_like 'expected response'
  end

  context 'error response' do
    let(:status) { 400 }
    let(:message) { 'There was an error' }
    let(:errors) { ['an error occurred'] }

    it_behaves_like 'expected response'
  end
end
