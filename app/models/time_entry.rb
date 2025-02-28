class TimeEntry < ApplicationRecord
  belongs_to :contract
  belongs_to :freelancer
end
