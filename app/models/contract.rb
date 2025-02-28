class Contract < ApplicationRecord
  belongs_to :job
  belongs_to :client
  belongs_to :freelancer
end
