class Post < ApplicationRecord
    has_many :reserves
    has_many :rooms 
    def self.ransackable_attributes(auth_object = nil)
        %w[name introduction address created_at updated_at]
      end
    
      def self.ransackable_associations(auth_object = nil)
        %w[reserves rooms]
      end
end
