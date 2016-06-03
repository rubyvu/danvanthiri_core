module DanvanthiriCore
  class DonorRequest < ActiveRecord::Base
    belongs_to :owner, polymorphic: true

    def blood_donor?
      category=="Blood Donor"
    end

    def organ_donor?
      category=="Organ Donor"
    end
    
    validates :category, :sub_category, presence: true
    validates :category, inclusion: {in: Donor.categories}
    validates :sub_category, inclusion: {in: Donor.blood_sub_categories}, if: Proc.new { |donor| donor.blood_donor? }
    validates :sub_category, inclusion: {in: Donor.organ_sub_categories}, if: Proc.new { |donor| donor.organ_donor? }
    validates :blood_group, inclusion: {in: Donor.blood_groups}, allow_blank: true
  end
end
