class Proposal < ApplicationRecord
  belongs_to :job
  belongs_to :freelancer
end
