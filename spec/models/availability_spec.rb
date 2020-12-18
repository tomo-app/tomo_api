require 'rails_helper'

RSpec.describe Availability, type: :model do
  it { should validate_presence_of :start_date_time }
  it { should validate_presence_of :end_date_time }
  it { should validate_presence_of :status }
end
