module V1
  class Leads < Grape::API
    resources :leads do
      desc 'Enqueues a new lead'
      params do
        requires :email, type: String, allow_blank: false, max_length: 80, desc: 'User email'
        requires :name, type: String, allow_blank: false, max_length: 100, desc: 'User name'
        requires :business_name, type: String, allow_blank: false, max_length: 100, desc: 'Business name'
        requires :telephone_number, type: String, allow_blank: false, min_length: 11, max_length: 13, desc: 'Phone number'
        optional :contact_time, type: String, desc: 'Contact time'
        optional :notes, type: String, max_length: 255, desc: 'Notes'
        optional :reference, type: String, max_length: 80, desc: 'Reference'
      end

      post do
        LeadService.enqueue(params)

        {
          status: 'Enqueued'
        }
      rescue Exception => e
        # TODO: parse validation errors being fedback by LeadAPI
        error!('Unable to enqueue a lead.', 400)
      end
    end
  end
end
