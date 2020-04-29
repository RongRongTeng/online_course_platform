# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_categories_on_name  (name) UNIQUE
#

RSpec.describe Category, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
