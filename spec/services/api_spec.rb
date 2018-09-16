require_relative '../../app/services/api'

describe Api do
  before { WebMock.allow_net_connect! }

  context 'should works' do
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

    it 'expect it to work' do
      expect(result).to eq 22
    end
  end
end
