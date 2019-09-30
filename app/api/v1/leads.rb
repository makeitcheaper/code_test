module V1
  class Leads < Grape::API
    resources :leads do
      desc 'Enqueues a new lead' do
        # failure [[400, 'Error', API::Error]]
        success [[201, 'Created']]
      end
      params do
        requires :email, type: String, allow_blank: false, desc: 'User email'
        requires :name, type: String, allow_blank: false, desc: 'User name'
        requires :business_name, type: String, allow_blank: false, desc: 'Business name'
        requires :telephone_number, type: String, allow_blank: false, desc: 'Phone number'
        optional :contact_time, type: String, desc: 'Contact time'
        optional :notes, type: String, desc: 'Notes'
        optional :reference, type: String, desc: 'Reference'
      end

      post do
        LeadService.enqueue(params)
      rescue
        error!("Unknown Error", 400)
      end
    end
  end
end
