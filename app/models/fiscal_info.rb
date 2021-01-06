class FiscalInfo < ApplicationRecord
  belongs_to :fiscal_infoable, polymorphic: true
end
