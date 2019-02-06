# frozen_string_literal: true

module MicLeads
  module V1
    class CreateEndpoint < BaseEndpoint
      CONFIG = Rails
               .application
               .config_for('endpoints')
               .with_indifferent_access
               .dig(:mic_leads, :v1, :create)

      def post( # rubocop:disable Metrics/MethodLength, Metrics/ParameterLists
        name:,
        business_name:,
        telephone_number:,
        email:,
        contact_time: nil,
        notes: nil,
        reference: nil
      )
        query = build_query(
          name: name,
          business_name: business_name,
          telephone_number: telephone_number,
          email: email,
          contact_time: contact_time,
          notes: notes,
          reference: reference
        )

        Api::Client
          .new(construct_uri(CONFIG[:domain], CONFIG[:path]))
          .call(:post, query: query)
      end

      private

      def build_query(**hash)
        remove_not_required(hash)
        add_required(hash)
        hash
      end

      def remove_not_required(hash)
        hash.delete(:contact_time) if hash[:contact_time].nil?
        hash.delete(:notes) if hash[:notes].nil?
        hash.delete(:reference) if hash[:reference].nil?
      end

      def add_required(hash)
        hash[:access_token] = CONFIG[:access_token]
        hash[:pGUID] = CONFIG[:p_guid]
        hash[:pAccName] = CONFIG[:p_acc_name]
        hash[:pPartner] = CONFIG[:p_partner]
      end
    end
  end
end
