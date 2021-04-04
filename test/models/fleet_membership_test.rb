# frozen_string_literal: true

# == Schema Information
#
# Table name: fleet_memberships
#
#  id                  :uuid             not null, primary key
#  aasm_state          :string
#  accepted_at         :datetime
#  declined_at         :datetime
#  hide_ships          :boolean          default(FALSE)
#  invited_at          :datetime
#  invited_by          :uuid
#  primary             :boolean          default(FALSE)
#  requested_at        :datetime
#  role                :integer
#  ships_filter        :integer          default("purchased")
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  fleet_id            :uuid
#  fleet_invite_url_id :uuid
#  hangar_group_id     :uuid
#  user_id             :uuid
#
# Indexes
#
#  index_fleet_memberships_on_user_id_and_fleet_id  (user_id,fleet_id) UNIQUE
#
require 'test_helper'

class FleetMembershipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
