namespace :add_data do
  task 'default_values_to_collection' => :environment do
    Rails.logger.info "Add dafault value to Collection start: #{Time.zone.now}"

    Collection.where('status IS NULL').each do |collection|
      begin
        Collection.transaction do
          if collection.user.role == 2
            collection.update!(status: 'reservable')
          else
            collection.update!(status: 'na')
          end
        end
        Rails.logger.info "id=#{collection.id} was successfully to update status."

      rescue ActiveRecord::RecordInvalid => invalid
        Rails.logger.info "id=#{collection.id} was failed to update status."
        Rails.logger.info invalid.record.errors
      end
    end

    Rails.logger.info "Add dafault value to Collection finished: #{Time.zone.now}"
  end
end
